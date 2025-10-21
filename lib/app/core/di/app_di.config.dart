// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cold_storage_warehouse_management/features/dashboard/data/datasources/temperatures_mock_api.dart'
    as _i760;
import 'package:cold_storage_warehouse_management/features/dashboard/data/repositories/temperature_repository_impl.dart'
    as _i654;
import 'package:cold_storage_warehouse_management/features/dashboard/domain/repositories/temperature_repository.dart'
    as _i471;
import 'package:cold_storage_warehouse_management/features/dashboard/domain/usecases/get_temperatures_usecase.dart'
    as _i612;
import 'package:cold_storage_warehouse_management/features/dashboard/presentation/cubit/temperature_cubit.dart'
    as _i509;
import 'package:cold_storage_warehouse_management/features/inbound/data/datasources/inventory_local_datasource.dart'
    as _i36;
import 'package:cold_storage_warehouse_management/features/inbound/data/datasources/location_mock_api.dart'
    as _i242;
import 'package:cold_storage_warehouse_management/features/inbound/data/repositories/inbound_repository_impl.dart'
    as _i38;
import 'package:cold_storage_warehouse_management/features/inbound/domain/repositories/inbound_repository.dart'
    as _i7;
import 'package:cold_storage_warehouse_management/features/inbound/domain/usecases/add_inbound_item_usecase.dart'
    as _i430;
import 'package:cold_storage_warehouse_management/features/inbound/domain/usecases/get_inbound_item_usecase.dart'
    as _i1067;
import 'package:cold_storage_warehouse_management/features/inbound/domain/usecases/get_location_usecase.dart'
    as _i707;
import 'package:cold_storage_warehouse_management/features/inbound/presentation/cubit/inventory_cubit.dart'
    as _i264;
import 'package:cold_storage_warehouse_management/features/inbound/presentation/cubit/inventory_list_cubit.dart'
    as _i818;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.lazySingleton<_i760.TemperaturesMockApi>(
      () => _i760.TemperaturesMockApi(),
    );
    gh.lazySingleton<_i242.LocationMockApi>(() => _i242.LocationMockApi());
    gh.lazySingleton<_i471.TemperatureRepository>(
      () => _i654.TemperatureRepositoryImpl(gh<_i760.TemperaturesMockApi>()),
    );
    gh.lazySingleton<_i612.GetTemperaturesUseCase>(
      () => _i612.GetTemperaturesUseCase(gh<_i471.TemperatureRepository>()),
    );
    gh.lazySingleton<_i36.InventoryLocalSource>(
      () => _i36.InventoryLocalSource(gh<_i242.LocationMockApi>()),
    );
    gh.lazySingleton<_i7.InventoryRepository>(
      () => _i38.InventoryRepositoryImpl(gh<_i36.InventoryLocalSource>()),
    );
    gh.lazySingleton<_i430.AddInboundItemUseCase>(
      () => _i430.AddInboundItemUseCase(gh<_i7.InventoryRepository>()),
    );
    gh.lazySingleton<_i707.GetLocationsUseCase>(
      () => _i707.GetLocationsUseCase(gh<_i7.InventoryRepository>()),
    );
    gh.lazySingleton<_i1067.GetInboundItemsUseCase>(
      () => _i1067.GetInboundItemsUseCase(gh<_i7.InventoryRepository>()),
    );
    gh.factory<_i264.InventoryCubit>(
      () => _i264.InventoryCubit(
        gh<_i707.GetLocationsUseCase>(),
        gh<_i430.AddInboundItemUseCase>(),
        gh<_i7.InventoryRepository>(),
      ),
    );
    gh.factory<_i509.TemperatureCubit>(
      () => _i509.TemperatureCubit(gh<_i612.GetTemperaturesUseCase>()),
    );
    gh.factory<_i818.InventoryListCubit>(
      () => _i818.InventoryListCubit(
        gh<_i1067.GetInboundItemsUseCase>(),
        gh<_i7.InventoryRepository>(),
      ),
    );
    return this;
  }
}
