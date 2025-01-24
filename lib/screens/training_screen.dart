import 'package:flutter/material.dart';
import '../widgets/puzzle_solver.dart';
import '../widgets/opening_trainer.dart';
import '../widgets/endgame_practice.dart';

class TrainingScreen extends StatelessWidget {
  const TrainingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Advanced Training'),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.extension), text: 'Puzzles'),
              Tab(icon: Icon(Icons.book), text: 'Openings'),
              Tab(icon: Icon(Icons.flag), text: 'Endgames'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            PuzzleSolver(),
            OpeningTrainer(),
            EndgamePractice(),
          ],
        ),
      ),
    );
  }
}

