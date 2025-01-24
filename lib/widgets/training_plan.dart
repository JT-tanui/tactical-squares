import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/game_service.dart';
import '../services/analytics_service.dart';

class TrainingPlan extends StatelessWidget {
  const TrainingPlan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final gameService = Provider.of<GameService>(context);
    final analyticsService = Provider.of<AnalyticsService>(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your Personalized Training Plan',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            _buildTrainingItem(context, 'Tactical Puzzles', 'Improve your tactical vision', () {
              // Navigate to tactical puzzles
            }),
            _buildTrainingItem(context, 'Endgame Studies', 'Master essential endgames', () {
              // Navigate to endgame studies
            }),
            _buildTrainingItem(context, 'Opening Repertoire', 'Expand your opening knowledge', () {
              // Navigate to opening repertoire
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildTrainingItem(BuildContext context, String title, String description, VoidCallback onTap) {
    return ListTile(
      title: Text(title),
      subtitle: Text(description),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}

