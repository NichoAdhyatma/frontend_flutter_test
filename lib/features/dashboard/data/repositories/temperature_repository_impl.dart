import 'package:cold_storage_warehouse_management/features/dashboard/data/datasources/temperatures_mock_api.dart';
import 'package:cold_storage_warehouse_management/features/dashboard/data/models/temperature_model.dart';
import 'package:cold_storage_warehouse_management/features/dashboard/domain/entities/temperature_entity.dart';
import 'package:cold_storage_warehouse_management/features/dashboard/domain/repositories/temperature_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: TemperatureRepository)
class TemperatureRepositoryImpl implements TemperatureRepository {
  TemperatureRepositoryImpl(this.api);

  final TemperaturesMockApi api;

  @override
  Future<List<TemperatureEntity>> getTemperatures() async {
    final raw = await api.getTemperatures();

    return raw.map(TemperatureModel.fromMap).toList();
  }
}
