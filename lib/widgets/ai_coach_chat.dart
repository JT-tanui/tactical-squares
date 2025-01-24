import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/game_service.dart';
import '../services/subscription_service.dart';

class AICoachChat extends StatelessWidget {
  const AICoachChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final gameService = Provider.of<GameService>(context);
    final subscriptionService = Provider.of<SubscriptionService>(context);

    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: gameService.chatMessages.length,
              itemBuilder: (context, index) {
                final message = gameService.chatMessages[index];
                return ListTile(
                  title: Text(
                    message.content,
                    style: TextStyle(
                      color: message.isUser ? Colors.white : Theme.of(context).primaryColor,
                    ),
                  ),
                  leading: CircleAvatar(
                    backgroundColor: message.isUser ? Colors.blue : Theme.of(context).primaryColor,
                    child: Icon(
                      message.isUser ? Icons.person : Icons.psychology,
                      color: Colors.white,
                    ),
                  ),
                );
              },
            ),
          ),
          TextField(
            decoration: InputDecoration(
              hintText: 'Ask the AI Coach a question...',
              suffixIcon: IconButton(
                icon: const Icon(Icons.send),
                onPressed: () {
                  // TODO: Implement send message
                },
              ),
            ),
            onSubmitted: (value) {
              if (subscriptionService.isPremium) {
                gameService.askCoach(value);
              } else {
                _showUpgradeDialog(context);
              }
            },
          ),
        ],
      ),
    );
  }

  void _showUpgradeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Premium Feature'),
          content: const Text('Upgrade to Premium to access advanced AI coaching!'),
          actions: [
            TextButton(
              child: const Text('Maybe Later'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Upgrade Now'),
              onPressed: () {
                // TODO: Implement subscription upgrade
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

