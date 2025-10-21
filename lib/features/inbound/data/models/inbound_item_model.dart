import 'package:cold_storage_warehouse_management/features/inbound/domain/entities/inbound_item_entity.dart';

class InboundItemModel extends InboundItemEntity {
  InboundItemModel({
    required super.sku,
    required super.batch,
    required super.expiry,
    required super.qty,
    required super.locationId,
  });
}
