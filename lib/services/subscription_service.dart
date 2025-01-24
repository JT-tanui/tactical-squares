import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SubscriptionService with ChangeNotifier {
  bool _isPremium = false;

  bool get isPremium => _isPremium;

  SubscriptionService() {
    _loadSubscriptionStatus();
  }

  Future<void> _loadSubscriptionStatus() async {
    final prefs = await SharedPreferences.getInstance();
    _isPremium = prefs.getBool('isPremium') ?? false;
    notifyListeners();
  }

  Future<void> upgradeToPremium() async {
    // In a real app, you would implement payment processing here
    _isPremium = true;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isPremium', true);
    notifyListeners();
  }

  Future<void> cancelPremium() async {
    _isPremium = false;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isPremium', false);
    notifyListeners();
  }
}

