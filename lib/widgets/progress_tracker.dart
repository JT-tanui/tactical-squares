import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/game_service.dart';

class ProgressTracker extends StatelessWidget {
  const ProgressTracker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final gameService = Provider.of<GameService>(context);

    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your Progress',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: gameService.overallProgress,
            backgroundColor: Colors.grey[700],
            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF00A86B)),
          ),
          const SizedBox(height: 8),
          Text(
            'Level ${gameService.currentLevel}',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}

