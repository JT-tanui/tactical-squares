import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/game_service.dart';
import 'chessboard.dart';

class PuzzleSolver extends StatefulWidget {
  const PuzzleSolver({Key? key}) : super(key: key);

  @override
  _PuzzleSolverState createState() => _PuzzleSolverState();
}

class _PuzzleSolverState extends State<PuzzleSolver> {
  String _currentPuzzle = '';
  int _puzzleRating = 0;
  bool _showSolution = false;

  @override
  void initState() {
    super.initState();
    _loadNewPuzzle();
  }

  void _loadNewPuzzle() {
    // In a real app, you would fetch puzzles from an API or local database
    setState(() {
      _currentPuzzle = 'r1bqkbnr/pppp1ppp/2n5/4p3/4P3/5N2/PPPP1PPP/RNBQKB1R w KQkq - 2 3';
      _puzzleRating = 1500;
      _showSolution = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Puzzle Rating: $_puzzleRating', style: Theme.of(context).textTheme.titleLarge),
        const Expanded(
          child: Chessboard(
            // Pass the current puzzle position to the Chessboard
          ),
        ),
        ElevatedButton(
          onPressed: () => setState(() => _showSolution = true),
          child: const Text('Show Solution'),
        ),
        if (_showSolution)
          Text('Solution: e4-e5, Nf3-Nc6', style: Theme.of(context).textTheme.titleMedium),
        ElevatedButton(
          onPressed: _loadNewPuzzle,
          child: const Text('Next Puzzle'),
        ),
      ],
    );
  }
}

