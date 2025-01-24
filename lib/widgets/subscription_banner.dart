import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/subscription_service.dart';

class SubscriptionBanner extends StatelessWidget {
  const SubscriptionBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final subscriptionService = Provider.of<SubscriptionService>(context);

    if (subscriptionService.isPremium) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.all(8.0),
      color: const Color(0xFF00A86B),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Upgrade to Premium for advanced features!',
            style: TextStyle(color: Colors.white),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              onPrimary: const Color(0xFF00A86B),
            ),
            child: const Text('Upgrade Now'),
          ),
        ],
      ),
    );
  }
}

