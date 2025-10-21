import 'dart:ui';

import 'package:flutter/material.dart';

class TemperatureEntity {
  TemperatureEntity({
    required this.roomId,
    required this.temperature,
    required this.timestamp,
  });

  final String roomId;
  final double temperature;
  final DateTime timestamp;

  bool get isInRange => temperature >= -20.0 && temperature <= -16.0;

  Color get highlightColor {
    return isInRange ? Colors.white : Colors.red.shade100;
  }

  Color get temperatureColor {
    return isInRange ? Colors.black : Colors.red;
  }
}
