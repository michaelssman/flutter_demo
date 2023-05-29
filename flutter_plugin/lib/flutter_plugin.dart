
import 'dart:async';

import 'package:flutter/services.dart';

class FlutterPlugin {
  static const MethodChannel _channel = MethodChannel('flutter_plugin');
  // 版本号
  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
  //电池电量
  static Future<String?> get platformBatteryLevel async {
    int batteryLevel = await _channel.invokeMethod('getPlatformBatteryLevel');
    return batteryLevel.toString();
  }
}
