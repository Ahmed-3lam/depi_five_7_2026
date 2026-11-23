import 'package:flutter/services.dart';

class BatteryService {
  static const MethodChannel _channel = MethodChannel('samples.flutter.dev/battery');

  Future<int> getBatteryLevel() async {
    final int batteryLevel = await _channel.invokeMethod('getBatteryLevel');
    return batteryLevel;
  }

}