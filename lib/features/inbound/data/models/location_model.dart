import 'package:cold_storage_warehouse_management/features/inbound/domain/entities/location_entity.dart';

class LocationModel extends LocationEntity {
  LocationModel({
    required super.id,
    required super.label,
    required super.capacity,
    required super.currentLoad,
  });

  factory LocationModel.fromMap(Map<String, dynamic> json) => LocationModel(
    id: json['id'] as String,
    label: json['label'] as String,
    capacity: json['capacity'] as int,
    currentLoad: json['current_load'] as int,
  );
}
