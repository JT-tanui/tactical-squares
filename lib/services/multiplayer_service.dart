import 'package:flutter/foundation.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:wifi_iot/wifi_iot.dart';

enum ConnectionType { bluetooth, online, wifi }

class MultiplayerService extends ChangeNotifier {
  ConnectionType? _connectionType;
  bool _isConnected = false;
  String? _opponentName;
  WebSocketChannel? _channel;
  BluetoothDevice? _bluetoothDevice;
  BluetoothCharacteristic? _characteristic;

  ConnectionType? get connectionType => _connectionType;
  bool get isConnected => _isConnected;
  String? get opponentName => _opponentName;

  Future<List<ScanResult>> scanForBluetoothDevices() async {
    FlutterBluePlus flutterBlue = FlutterBluePlus.instance;
    await flutterBlue.startScan(timeout: const Duration(seconds: 4));
    List<ScanResult> scanResults = await flutterBlue.scanResults.first;
    await flutterBlue.stopScan();
    return scanResults;
  }

  Future<void> connectBluetooth(BluetoothDevice device) async {
    try {
      await device.connect();
      List<BluetoothService> services = await device.discoverServices();
      BluetoothService chessService = services.firstWhere(
        (service) => service.uuid.toString() == '0000180d-0000-1000-8000-00805f9b34fb',
        orElse: () => throw Exception('Chess service not found'),
      );
      _characteristic = chessService.characteristics.firstWhere(
        (char) => char.uuid.toString() == '00002a37-0000-1000-8000-00805f9b34fb',
        orElse: () => throw Exception('Chess characteristic not found'),
      );

      _bluetoothDevice = device;
      _connectionType = ConnectionType.bluetooth;
      _isConnected = true;
      _opponentName = device.name;
      notifyListeners();

      _characteristic!.setNotifyValue(true);
      _characteristic!.value.listen((value) {
        if (value.isNotEmpty) {
          receiveMove(String.fromCharCodes(value));
        }
      });
    } catch (e) {
      print('Error connecting via Bluetooth: $e');
      _isConnected = false;
    }
  }

  Future<void> connectOnline(String gameId) async {
    try {
      _channel = WebSocketChannel.connect(
        Uri.parse('wss://your-chess-server.com/ws/$gameId'),
      );
      _connectionType = ConnectionType.online;
      _isConnected = true;
      _opponentName = "Online Opponent";
      _channel!.stream.listen((message) {
        receiveMove(message);
      });
      notifyListeners();
    } catch (e) {
      print('Error connecting online: $e');
      _isConnected = false;
    }
  }

  Future<void> connectWifi() async {
    try {
      bool? isConnected = await WiFiForIoTPlugin.isConnected();
      if (isConnected == true) {
        _connectionType = ConnectionType.wifi;
        _isConnected = true;
        _opponentName = "WiFi Opponent";
        notifyListeners();
      }
    } catch (e) {
      print('Error connecting via WiFi: $e');
      _isConnected = false;
    }
  }

  void disconnect() async {
    _channel?.sink.close();
    if (_bluetoothDevice != null) {
      await _bluetoothDevice!.disconnect();
    }
    _connectionType = null;
    _isConnected = false;
    _opponentName = null;
    _bluetoothDevice = null;
    _characteristic = null;
    notifyListeners();
  }

  void sendMove(String move) {
    if (_connectionType == ConnectionType.online && _channel != null) {
      _channel!.sink.add(move);
    } else if (_connectionType == ConnectionType.bluetooth && _characteristic != null) {
      _characteristic!.write(move.codeUnits);
    }
    // Implement sending moves for WiFi
  }

  void receiveMove(String move) {
    // Implement move receiving logic
    print('Received move: $move');
    notifyListeners();
  }
}

