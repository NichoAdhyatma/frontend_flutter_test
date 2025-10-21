import 'package:cold_storage_warehouse_management/features/inbound/data/datasources/inventory_local_datasource.dart';
import 'package:cold_storage_warehouse_management/features/inbound/data/models/inbound_item_model.dart';
import 'package:cold_storage_warehouse_management/features/inbound/domain/entities/inbound_item_entity.dart';
import 'package:cold_storage_warehouse_management/features/inbound/domain/entities/location_entity.dart';
import 'package:cold_storage_warehouse_management/features/inbound/domain/repositories/inbound_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: InventoryRepository)
class InventoryRepositoryImpl implements InventoryRepository {
  InventoryRepositoryImpl(this.localSource);

  final InventoryLocalSource localSource;

  @override
  Future<List<LocationEntity>> getLocations() => localSource.getLocations();

  @override
  Future<void> addInboundItem(InboundItemEntity item) async {
    await localSource.addInboundItem(
      InboundItemModel(
        sku: item.sku,
        batch: item.batch,
        expiry: item.expiry,
        qty: item.qty,
        locationId: item.locationId,
      ),
    );
  }

  @override
  Future<List<InboundItemEntity>> getInboundItems() async {
    await Future<void>.delayed(const Duration(milliseconds: 500));

    return localSource.getItems();
  }
}
