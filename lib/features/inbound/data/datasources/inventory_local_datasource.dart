import 'package:cold_storage_warehouse_management/features/inbound/data/datasources/location_mock_api.dart';
import 'package:cold_storage_warehouse_management/features/inbound/data/models/inbound_item_model.dart';
import 'package:cold_storage_warehouse_management/features/inbound/data/models/location_model.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class InventoryLocalSource {
  InventoryLocalSource(this.api);

  final LocationMockApi api;
  final List<InboundItemModel> _items = [];

  Future<List<LocationModel>> getLocations() async {
    final data = await api.getLocations();
    return data.map(LocationModel.fromMap).toList();
  }

  Future<void> addInboundItem(InboundItemModel item) async {
    _items.add(item);
  }

  List<InboundItemModel> getItems() => _items;
}
