import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';

class PlayModeSelectionScreen extends StatelessWidget {
  const PlayModeSelectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Choose Play Mode')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text('Play with AI Coach'),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/home');
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              child: const Text('Play with Friends'),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/multiplayer');
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              child: const Text('Play with Bot'),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/bot_game');
              },
            ),
          ],
        ),
      ),
    );
  }
}

