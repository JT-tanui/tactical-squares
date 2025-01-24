import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/game_service.dart';

class MoveHistory extends StatelessWidget {
  const MoveHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final gameService = Provider.of<GameService>(context);

    return Container(
      height: 150,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Move History',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: gameService.moveHistory.length,
              itemBuilder: (context, index) {
                final move = gameService.moveHistory[index];
                return ListTile(
                  dense: true,
                  title: Text(
                    '${index + 1}. ${move.from}-${move.to}',
                    style: TextStyle(
                      color: move.evaluation > 0 ? Colors.green : Colors.red,
                    ),
                  ),
                  trailing: Text(move.evaluation.toStringAsFixed(1)),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

