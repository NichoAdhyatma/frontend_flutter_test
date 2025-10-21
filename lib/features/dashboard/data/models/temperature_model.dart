import 'package:cold_storage_warehouse_management/features/dashboard/domain/entities/temperature_entity.dart';

class TemperatureModel extends TemperatureEntity {
  TemperatureModel({
    required super.roomId,
    required super.temperature,
    required super.timestamp,
  });

  factory TemperatureModel.fromMap(Map<String, dynamic> json) {
    return TemperatureModel(
      roomId: json['room_id'] as String,
      temperature: (json['temperature'] as num).toDouble(),
      timestamp: DateTime.parse(json['timestamp'] as String),
    );
  }
}
