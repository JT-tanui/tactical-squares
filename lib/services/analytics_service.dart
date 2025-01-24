import 'package:flutter/foundation.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsService with ChangeNotifier {
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  Future<void> logGameCompleted(int moveCount, String result, int difficulty) async {
    await _analytics.logEvent(
      name: 'game_completed',
      parameters: {
        'move_count': moveCount,
        'result': result,
        'difficulty': difficulty,
      },
    );
  }

  Future<void> logLessonCompleted(String lessonId, int timeSpent) async {
    await _analytics.logEvent(
      name: 'lesson_completed',
      parameters: {
        'lesson_id': lessonId,
        'time_spent': timeSpent,
      },
    );
  }

  Future<void> logPuzzleSolved(String puzzleId, int attempts, int timeSpent) async {
    await _analytics.logEvent(
      name: 'puzzle_solved',
      parameters: {
        'puzzle_id': puzzleId,
        'attempts': attempts,
        'time_spent': timeSpent,
      },
    );
  }
}

