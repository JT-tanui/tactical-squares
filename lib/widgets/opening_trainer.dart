import 'package:flutter/material.dart';
import '../services/game_service.dart';
import 'chessboard.dart';

class OpeningTrainer extends StatefulWidget {
  const OpeningTrainer({Key? key}) : super(key: key);

  @override
  _OpeningTrainerState createState() => _OpeningTrainerState();
}

class _OpeningTrainerState extends State<OpeningTrainer> {
  final String _currentOpening = 'Ruy Lopez';
  final List<String> _openingMoves = ['e4', 'e5', 'Nf3', 'Nc6', 'Bb5'];
  int _currentMoveIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Current Opening: $_currentOpening', style: Theme.of(context).textTheme.titleLarge),
        const Expanded(
          child: Chessboard(
            // Pass the current opening position to the Chessboard
          ),
        ),
        Text('Next move: ${_openingMoves[_currentMoveIndex]}', style: Theme.of(context).textTheme.titleMedium),
        ElevatedButton(
          onPressed: _makeNextMove,
          child: const Text('Make Move'),
        ),
        ElevatedButton(
          onPressed: _resetOpening,
          child: const Text('Reset Opening'),
        ),
      ],
    );
  }

  void _makeNextMove() {
    setState(() {
      if (_currentMoveIndex < _openingMoves.length - 1) {
        _currentMoveIndex++;
        // Update the board position based on the new move
      }
    });
  }

  void _resetOpening() {
    setState(() {
      _currentMoveIndex = 0;
      // Reset the board to the starting position
    });
  }
}

