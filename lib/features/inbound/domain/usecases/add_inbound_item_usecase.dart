import 'package:cold_storage_warehouse_management/features/inbound/domain/entities/inbound_item_entity.dart';
import 'package:cold_storage_warehouse_management/features/inbound/domain/repositories/inbound_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AddInboundItemUseCase {
  AddInboundItemUseCase(this.repository);

  final InventoryRepository repository;

  Future<void> call(InboundItemEntity item) => repository.addInboundItem(item);
}
