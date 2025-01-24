import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: FutureBuilder<UserProfile?>(
        future: authService.getUserProfile(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Error loading profile'));
          }
          if (!snapshot.hasData) {
            return const Center(child: Text('No profile data'));
          }

          UserProfile profile = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Name: ${profile.name}', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 8),
                Text('Country: ${profile.country}', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                Text('Rating: ${profile.rating}', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                Text('Subscription Tier: ${profile.tier.toString().split('.').last}', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 24),
                ElevatedButton(
                  child: const Text('Upgrade Subscription'),
                  onPressed: () {
                    _showUpgradeDialog(context, authService);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showUpgradeDialog(BuildContext context, AuthService authService) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Upgrade Subscription'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                child: const Text('Upgrade to Basic'),
                onPressed: () async {
                  await authService.upgradeTier(UserTier.basic);
                  Navigator.of(context).pop();
                },
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                child: const Text('Upgrade to Premium'),
                onPressed: () async {
                  await authService.upgradeTier(UserTier.premium);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

