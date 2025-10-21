import 'package:bloc/bloc.dart';
import 'package:cold_storage_warehouse_management/features/inbound/domain/entities/inbound_item_entity.dart';
import 'package:cold_storage_warehouse_management/features/inbound/domain/repositories/inbound_repository.dart';
import 'package:cold_storage_warehouse_management/features/inbound/domain/usecases/get_inbound_item_usecase.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'inventory_list_state.dart';

@injectable
class InventoryListCubit extends Cubit<InventoryListState> {
  InventoryListCubit(
    this.getInboundItemsUseCase,
    this.repository,
  ) : super(InventoryListInitial());

  final GetInboundItemsUseCase getInboundItemsUseCase;
  final InventoryRepository repository;

  Future<void> loadItems() async {
    emit(InventoryListLoading());
    try {
      final items = await getInboundItemsUseCase();

      emit(InventoryListLoaded(items: items, filteredItems: items));
    } on Exception catch (e) {
      emit(InventoryListError(e.toString()));
    }
  }

  void search(String query) {
    if (state is! InventoryListLoaded) return;

    final current = state as InventoryListLoaded;

    final filtered = current.items.where((i) {
      return i.sku.toLowerCase().contains(query.toLowerCase()) ||
          i.locationId.toLowerCase().contains(query.toLowerCase());
    }).toList();

    emit(
      InventoryListLoaded(
        items: current.items,
        filteredItems: filtered,
        selectedLocation: current.selectedLocation,
      ),
    );
  }

  void filterByLocation(String? locationId) {
    if (state is! InventoryListLoaded) return;
    final current = state as InventoryListLoaded;

    final filtered = locationId == null
        ? current.items
        : current.items.where((i) => i.locationId == locationId).toList();

    emit(
      InventoryListLoaded(
        items: current.items,
        filteredItems: filtered,
        selectedLocation: locationId,
      ),
    );
  }
}
