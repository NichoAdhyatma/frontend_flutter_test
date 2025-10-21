import 'package:cold_storage_warehouse_management/features/dashboard/domain/entities/temperature_entity.dart';
import 'package:cold_storage_warehouse_management/features/dashboard/domain/repositories/temperature_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetTemperaturesUseCase {
  GetTemperaturesUseCase(this.repository);

  final TemperatureRepository repository;

  Future<List<TemperatureEntity>> call() async {
    return repository.getTemperatures();
  }
}
