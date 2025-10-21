part of 'inventory_cubit.dart';

@immutable
sealed class InventoryState {}

final class InventoryInitial extends InventoryState {}

class InventoryLoading extends InventoryState {}

class InventoryLocationLoaded extends InventoryState {
  InventoryLocationLoaded(this.locations);

  final List<LocationEntity> locations;
}

class InventoryError extends InventoryState {
  InventoryError(this.message);

  final String message;
}
