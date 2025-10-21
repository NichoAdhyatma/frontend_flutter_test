import 'package:bloc/bloc.dart';
import 'package:cold_storage_warehouse_management/features/inbound/domain/entities/inbound_item_entity.dart';
import 'package:cold_storage_warehouse_management/features/inbound/domain/entities/location_entity.dart';
import 'package:cold_storage_warehouse_management/features/inbound/domain/repositories/inbound_repository.dart';
import 'package:cold_storage_warehouse_management/features/inbound/domain/usecases/add_inbound_item_usecase.dart';
import 'package:cold_storage_warehouse_management/features/inbound/domain/usecases/get_location_usecase.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'inventory_state.dart';

@injectable
class InventoryCubit extends Cubit<InventoryState> {
  InventoryCubit(
    this.getLocationsUsecase,
    this.addInboundUsecase,
    this.repo,
  ) : super(InventoryInitial());

  final GetLocationsUseCase getLocationsUsecase;
  final AddInboundItemUseCase addInboundUsecase;
  final InventoryRepository repo;

  Future<void> loadData() async {
    try {
      await _getLocationAndInboundItem();
    } on Exception catch (e) {
      emit(InventoryError(e.toString()));
    }
  }

  Future<void> addItem(InboundItemEntity item) async {
    try {
      emit(InventoryLoading());

      await addInboundUsecase(item);

      await _getLocationAndInboundItem(isEmitLoading: false);
    } on Exception catch (e) {
      emit(InventoryError(e.toString()));
    }
  }

  Future<void> _getLocationAndInboundItem({bool isEmitLoading = true}) async {
    if (isEmitLoading) emit(InventoryLoading());

    final locations = await getLocationsUsecase();

    emit(InventoryLocationLoaded(locations));
  }
}
