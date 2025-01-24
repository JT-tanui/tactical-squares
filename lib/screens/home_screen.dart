import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/chessboard.dart';
import '../widgets/ai_coach_chat.dart';
import '../widgets/difficulty_selector.dart';
import '../widgets/progress_tracker.dart';
import '../widgets/move_history.dart';
import '../widgets/subscription_banner.dart';
import '../widgets/training_plan.dart';
import '../services/auth_service.dart';
import '../services/game_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final gameService = Provider.of<GameService>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Royal Chess Coach AI'),
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              // TODO: Implement game history
            },
          ),
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () async {
              await authService.signOut();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          const SubscriptionBanner(),
          Expanded(
            child: Row(
              children: [
                const Expanded(
                  flex: 3,
                  child: Chessboard(),
                ),
                const Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      ProgressTracker(),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Consumer<AuthService>(
                        builder: (context, authService, child) {
                          return FutureBuilder<UserProfile?>(
                            future: authService.getUserProfile(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return const CircularProgressIndicator();
                              }
                              if (!snapshot.hasData) {
                                return const Text('Error loading profile');
                              }

                              UserProfile profile = snapshot.data!;
                              bool canAccessAICoach = gameService.canAccessFeature('ai_coach', profile.tier);

                              if (canAccessAICoach) {
                                return const AICoachChat();
                              } else {
                                return Center(
                                  child: ElevatedButton(
                                    child: const Text('Upgrade to Access AI Coach'),
                                    onPressed: () => Navigator.pushNamed(context, '/profile'),
                                  ),
                                );
                              }
                            },
                          );
                        },
                      ),
                      const MoveHistory(),
                      TrainingPlan(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const DifficultySelector(),
    );
  }
}

