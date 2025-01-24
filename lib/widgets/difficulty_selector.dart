import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/game_service.dart';

class DifficultySelector extends StatelessWidget {
  const DifficultySelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final gameService = Provider.of<GameService>(context);

    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.child_care),
          label: 'Easy',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.school),
          label: 'Medium',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.psychology),
          label: 'Hard',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.auto_awesome),
          label: 'Adaptive',
        ),
      ],
      currentIndex: gameService.difficultyLevel.index,
      onTap: (index) {
        gameService.setDifficulty(DifficultyLevel.values[index]);
      },
    );
  }
}

