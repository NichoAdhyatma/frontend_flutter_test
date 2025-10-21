import 'dart:math';

import 'package:injectable/injectable.dart';

@LazySingleton()
class TemperaturesMockApi {
  final Random _random = Random();

  Future<List<Map<String, dynamic>>> getTemperatures() async {
    await Future<void>.delayed(
      const Duration(milliseconds: 500),
    );

    final now = DateTime.now().toIso8601String();

    double vary(double base) => double.parse(
      (base + (_random.nextDouble() * 1.4 - 0.7)).toStringAsFixed(2),
    );

    return [
      {'room_id': 'COLD-01', 'temperature': vary(-18.3), 'timestamp': now},
      {'room_id': 'COLD-02', 'temperature': vary(-15.8), 'timestamp': now},
      {'room_id': 'COLD-03', 'temperature': vary(-19.5), 'timestamp': now},
    ];
  }
}
