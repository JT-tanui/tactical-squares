import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/game_service.dart';
import '../services/auth_service.dart';
import '../widgets/chessboard.dart';

class BotGameScreen extends StatelessWidget {
  const BotGameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final gameService = Provider.of<GameService>(context);
    final authService = Provider.of<AuthService>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Play Against Bot')),
      body: FutureBuilder<UserProfile?>(
        future: authService.getUserProfile(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData) {
            return const Center(child: Text('Error loading profile'));
          }

          UserProfile profile = snapshot.data!;
          bool canAccessAllBots = gameService.canAccessFeature('all_bots', profile.tier);

          return Column(
            children: [
              const Expanded(child: Chessboard()),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text('Select Bot Difficulty:', style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children: [
                        ElevatedButton(
                          child: const Text('Easy'),
                          onPressed: () => gameService.setDifficulty(DifficultyLevel.beginner),
                        ),
                        ElevatedButton(
                          onPressed: canAccessAllBots
                              ? () => gameService.setDifficulty(DifficultyLevel.intermediate)
                              : () => _showUpgradeDialog(context),
                          child: Text('Medium'),
                        ),
                        ElevatedButton(
                          onPressed: canAccessAllBots
                              ? () => gameService.setDifficulty(DifficultyLevel.advanced)
                              : () => _showUpgradeDialog(context),
                          child: Text('Hard'),
                        ),
                        ElevatedButton(
                          onPressed: canAccessAllBots
                              ? () => gameService.setDifficulty(DifficultyLevel.master)
                              : () => _showUpgradeDialog(context),
                          child: Text('Master'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showUpgradeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Upgrade Required'),
          content: const Text('Upgrade to Basic or Premium tier to access all bot difficulties.'),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            ElevatedButton(
              child: const Text('Upgrade'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushNamed(context, '/profile');
              },
            ),
          ],
        );
      },
    );
  }
}

