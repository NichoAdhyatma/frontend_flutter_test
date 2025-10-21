import 'package:cold_storage_warehouse_management/features/dashboard/domain/entities/temperature_entity.dart';

abstract class TemperatureRepository {
  Future<List<TemperatureEntity>> getTemperatures();
}
