import 'package:cold_storage_warehouse_management/features/inbound/domain/entities/location_entity.dart';
import 'package:cold_storage_warehouse_management/features/inbound/domain/repositories/inbound_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetLocationsUseCase {
  GetLocationsUseCase(this.repository);

  final InventoryRepository repository;

  Future<List<LocationEntity>> call() => repository.getLocations();
}
