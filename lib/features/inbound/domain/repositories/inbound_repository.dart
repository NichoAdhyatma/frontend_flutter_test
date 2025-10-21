import 'package:cold_storage_warehouse_management/features/inbound/domain/entities/inbound_item_entity.dart';
import 'package:cold_storage_warehouse_management/features/inbound/domain/entities/location_entity.dart';

abstract class InventoryRepository {
  Future<List<LocationEntity>> getLocations();

  Future<void> addInboundItem(InboundItemEntity item);

  Future<List<InboundItemEntity>> getInboundItems();
}
