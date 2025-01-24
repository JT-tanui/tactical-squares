import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/home_screen.dart';
import 'screens/multiplayer_screen.dart';
import 'screens/training_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/play_mode_selection_screen.dart';
import 'screens/login_screen.dart';
import 'screens/bot_game_screen.dart';
import 'services/game_service.dart';
import 'services/subscription_service.dart';
import 'services/auth_service.dart';
import 'services/analytics_service.dart';
import 'services/multiplayer_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GameService()),
        ChangeNotifierProvider(create: (_) => SubscriptionService()),
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => AnalyticsService()),
        ChangeNotifierProvider(create: (_) => MultiplayerService()),
      ],
      child: const ChessCoachApp(),
    ),
  );
}

class ChessCoachApp extends StatelessWidget {
  const ChessCoachApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Royal Chess Coach AI',
      theme: ThemeData(
        primaryColor: const Color(0xFFFFD700),
        scaffoldBackgroundColor: const Color(0xFF1A1A1A),
        textTheme: GoogleFonts.playfairDisplay(
          textStyle: Theme.of(context).textTheme,
        ).apply(
          bodyColor: Colors.white,
          displayColor: const Color(0xFFFFD700),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF00A86B),
            onPrimary: Colors.white,
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const AuthWrapper(),
        '/home': (context) => const HomeScreen(),
        '/multiplayer': (context) => const MultiplayerScreen(),
        '/training': (context) => const TrainingScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/play_mode_selection': (context) => PlayModeSelectionScreen(),
        '/bot_game': (context) => BotGameScreen(),
      },
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    return StreamBuilder<User?>(
      stream: authService.user,
      builder: (_, AsyncSnapshot<User?> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final User? user = snapshot.data;
          return user == null ? LoginScreen() : const PlayModeSelectionScreen();
        }
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      },
    );
  }
}

