import 'package:flutter/material.dart';
import '../services/game_service.dart';
import 'chessboard.dart';

class EndgamePractice extends StatefulWidget {
  const EndgamePractice({Key? key}) : super(key: key);

  @override
  _EndgamePracticeState createState() => _EndgamePracticeState();
}

class _EndgamePracticeState extends State<EndgamePractice> {
  String _currentEndgame = 'King and Pawn vs King';
  String _endgamePosition = '4k3/4P3/4K3/8/8/8/8/8 w - - 0 1';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Current Endgame: $_currentEndgame', style: Theme.of(context).textTheme.titleLarge),
        const Expanded(
          child: Chessboard(
            // Pass the current endgame position to the Chessboard
          ),
        ),
        ElevatedButton(
          onPressed: _loadNewEndgame,
          child: const Text('Load New Endgame'),
        ),
        ElevatedButton(
          onPressed: _showEndgameHint,
          child: const Text('Show Hint'),
        ),
      ],
    );
  }

  void _loadNewEndgame() {
    // In a real app, you would load different endgame positions
    setState(() {
      _currentEndgame = 'Rook and King vs King';
      _endgamePosition = '4k3/8/8/8/8/8/R7/4K3 w - - 0 1';
    });
  }

  void _showEndgameHint() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Endgame Hint'),
          content: const Text('Try to push the pawn to the 8th rank while keeping the opponent\'s king away.'),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }
}

