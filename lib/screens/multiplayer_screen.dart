import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import '../services/multiplayer_service.dart';
import '../widgets/chessboard.dart';
import '../services/auth_service.dart';

class MultiplayerScreen extends StatelessWidget {
  const MultiplayerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final multiplayerService = Provider.of<MultiplayerService>(context);
    final authService = Provider.of<AuthService>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Multiplayer'),
        actions: [
          IconButton(
            icon: const Icon(Icons.bluetooth),
            onPressed: () => _showBluetoothDialog(context),
          ),
          IconButton(
            icon: const Icon(Icons.wifi),
            onPressed: () => _showConnectionDialog(context, ConnectionType.wifi),
          ),
          IconButton(
            icon: const Icon(Icons.cloud),
            onPressed: () => _showConnectionDialog(context, ConnectionType.online),
          ),
        ],
      ),
      body: Column(
        children: [
          if (multiplayerService.isConnected)
            Text('Connected to: ${multiplayerService.opponentName}'),
          const Expanded(child: Chessboard(isMultiplayer: true)),
          ElevatedButton(
            child: const Text('Match with Friend'),
            onPressed: () => _matchWithFriend(context, authService),
          ),
        ],
      ),
    );
  }

  void _showBluetoothDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Connect via Bluetooth'),
          content: FutureBuilder<List<ScanResult>>(
            future: Provider.of<MultiplayerService>(context, listen: false).scanForBluetoothDevices(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Text('No devices found');
              } else {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    ScanResult result = snapshot.data![index];
                    return ListTile(
                      title: Text(result.device.name.isNotEmpty ? result.device.name : 'Unknown device'),
                      subtitle: Text(result.device.id.id),
                      onTap: () {
                        Provider.of<MultiplayerService>(context, listen: false).connectBluetooth(result.device);
                        Navigator.of(context).pop();
                      },
                    );
                  },
                );
              }
            },
          ),
        );
      },
    );
  }

  void _showConnectionDialog(BuildContext context, ConnectionType type) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Connect via ${type.toString().split('.').last}'),
          content: Text('Implement connection UI for $type'),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Connect'),
              onPressed: () {
                // Implement connection logic
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _matchWithFriend(BuildContext context, AuthService authService) async {
    UserProfile? profile = await authService.getUserProfile();
    if (profile != null) {
      // In a real app, you would implement a matchmaking algorithm here
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Matching with Friend'),
            content: Text('Searching for players with rating ${profile.rating} ± 100...'),
            actions: [
              TextButton(
                child: const Text('Cancel'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          );
        },
      );
    }
  }
}

