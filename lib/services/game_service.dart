import 'package:flutter/foundation.dart';
import 'package:chess/chess.dart' as chess;
import 'dart:async';

enum DifficultyLevel { beginner, intermediate, advanced, master }

enum UserTier { basic, premium }

class ChatMessage {
  final String content;
  final bool isUser;

  ChatMessage(this.content, this.isUser);
}

class Move {
  final String from;
  final String to;
  final String? promotion;

  Move(this.from, this.to, {this.promotion});
}

class GameService extends ChangeNotifier {
  chess.Chess _game = chess.Chess();
  DifficultyLevel _difficultyLevel = DifficultyLevel.intermediate;
  final List<ChatMessage> _chatMessages = [];
  final List<Move> _moveHistory = [];
  double _overallProgress = 0.0;
  int _currentLevel = 1;
  bool _isInCheck = false;
  bool _isCheckmate = false;
  bool _isStalemate = false;
  bool _isDraw = false;
  Timer? _gameTimer;
  int _gameTimeInSeconds = 0;

  DifficultyLevel get difficultyLevel => _difficultyLevel;
  List<ChatMessage> get chatMessages => _chatMessages;
  List<Move> get moveHistory => _moveHistory;
  double get overallProgress => _overallProgress;
  int get currentLevel => _currentLevel;
  bool get isInCheck => _isInCheck;
  bool get isCheckmate => _isCheckmate;
  bool get isStalemate => _isStalemate;
  bool get isDraw => _isDraw;
  int get gameTimeInSeconds => _gameTimeInSeconds;

  void setDifficulty(DifficultyLevel level) {
    _difficultyLevel = level;
    notifyListeners();
  }

  bool makeMove(Move move) {
    final result = _game.move({
      'from': move.from,
      'to': move.to,
      'promotion': move.promotion,
    });

    _moveHistory.add(move);
    _updateGameStatus();
    _generateCoachResponse();
    _updateProgress();
    notifyListeners();
    return true;
      return false;
  }

  List<String> getValidMoves(String square) {
    return _game.moves({'square': square, 'verbose': true})
        .map((m) => m['to'] as String)
        .toList();
  }

  void _updateGameStatus() {
    _isInCheck = _game.in_check;
    _isCheckmate = _game.in_checkmate;
    _isStalemate = _game.in_stalemate;
    _isDraw = _game.in_draw;
  }

  void askCoach(String question) {
    _chatMessages.add(ChatMessage(question, true));
    _generateCoachResponse(userQuestion: question);
    notifyListeners();
  }

  void _generateCoachResponse({String? userQuestion}) {
    String response;
    if (userQuestion != null) {
      response = _generateResponseToUserQuestion(userQuestion);
    } else {
      response = _generateMoveAdvice();
    }
    _chatMessages.add(ChatMessage(response, false));
  }

  String _generateResponseToUserQuestion(String question) {
    // Implement more sophisticated response generation based on the question and game state
    return "That's a great question! Based on the current position, I would suggest focusing on controlling the center and developing your pieces.";
  }

  String _generateMoveAdvice() {
    // Implement more sophisticated move advice based on the game state and difficulty level
    switch (_difficultyLevel) {
      case DifficultyLevel.beginner:
        return "Try to control the center of the board and develop your pieces.";
      case DifficultyLevel.intermediate:
        return "Look for tactical opportunities and consider the pawn structure.";
      case DifficultyLevel.advanced:
        return "Analyze the position critically and plan your long-term strategy.";
      case DifficultyLevel.master:
        return "Consider the subtle nuances of the position and look for creative ways to create imbalances.";
    }
  }

  void _updateProgress() {
    _overallProgress += 0.01;
    if (_overallProgress >= 1.0) {
      _overallProgress = 0.0;
      _currentLevel++;
    }
    notifyListeners();
  }

  void newGame() {
    _game = chess.Chess();
    _moveHistory.clear();
    _isInCheck = false;
    _isCheckmate = false;
    _isStalemate = false;
    _isDraw = false;
    _gameTimeInSeconds = 0;
    _startGameTimer();
    notifyListeners();
  }

  void _startGameTimer() {
    _gameTimer?.cancel();
    _gameTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _gameTimeInSeconds++;
      notifyListeners();
    });
  }

  void pauseGame() {
    _gameTimer?.cancel();
  }

  void resumeGame() {
    _startGameTimer();
  }

  @override
  void dispose() {
    _gameTimer?.cancel();
    super.dispose();
  }

  bool canAccessFeature(String featureName, UserTier userTier) {
    switch (featureName) {
      case 'basic_analytics':
        return true;
      case 'advanced_analytics':
        return userTier == UserTier.basic || userTier == UserTier.premium;
      case 'ai_coach':
        return userTier == UserTier.premium;
      case 'all_bots':
        return userTier == UserTier.basic || userTier == UserTier.premium;
      default:
        return false;
    }
  }
}

