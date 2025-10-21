part of 'inventory_list_cubit.dart';

@immutable
sealed class InventoryListState {}

final class InventoryListInitial extends InventoryListState {}

class InventoryListLoading extends InventoryListState {}

class InventoryListLoaded extends InventoryListState {
  InventoryListLoaded({
    required this.items,
    required this.filteredItems,
    this.selectedLocation,
  });

  final List<InboundItemEntity> items;
  final List<InboundItemEntity> filteredItems;
  final String? selectedLocation;
}

class InventoryListError extends InventoryListState {
  InventoryListError(this.message);

  final String message;
}
