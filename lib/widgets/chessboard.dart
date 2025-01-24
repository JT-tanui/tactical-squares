import 'package:flutter/material.dart';
import 'package:flutter_chess_board/flutter_chess_board.dart';
import 'package:provider/provider.dart';
import '../services/game_service.dart';
import '../services/multiplayer_service.dart';

class Chessboard extends StatelessWidget {
  final bool isMultiplayer;

  const Chessboard({Key? key, this.isMultiplayer = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final gameService = Provider.of<GameService>(context);
    final multiplayerService = Provider.of<MultiplayerService>(context);

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).primaryColor, width: 2),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColor.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: ChessBoard(
        onMove: (move) {
          if (isMultiplayer && !multiplayerService.isConnected) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Not connected to an opponent')),
            );
            return;
          }

          final result = gameService.makeMove(Move(move.from, move.to, promotion: move.promotion));
          if (result) {
            if (isMultiplayer) {
              multiplayerService.sendMove('${move.from}${move.to}${move.promotion ?? ''}');
            }
            _checkGameStatus(context, gameService);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Invalid move')),
            );
          }
        },
        onCheckMate: (color) => _showGameOverDialog(context, 'Checkmate! ${color.name} wins!'),
        onDraw: () => _showGameOverDialog(context, 'Draw!'),
        size: MediaQuery.of(context).size.width * 0.8,
        enableUserMoves: true,
        boardColor: BoardColor.orange,
        boardOrientation: PlayerColor.white,
      ),
    );
  }

  void _checkGameStatus(BuildContext context, GameService gameService) {
    if (gameService.isCheckmate) {
      _showGameOverDialog(context, 'Checkmate!');
    } else if (gameService.isStalemate) {
      _showGameOverDialog(context, 'Stalemate!');
    } else if (gameService.isDraw) {
      _showGameOverDialog(context, 'Draw!');
    } else if (gameService.isInCheck) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Check!')),
      );
    }
  }

  void _showGameOverDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Game Over'),
          content: Text(message),
          actions: [
            TextButton(
              child: const Text('New Game'),
              onPressed: () {
                Navigator.of(context).pop();
                Provider.of<GameService>(context, listen: false).newGame();
              },
            ),
          ],
        );
      },
    );
  }
}

