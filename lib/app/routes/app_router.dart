import 'package:cold_storage_warehouse_management/app/core/di/app_di.dart';
import 'package:cold_storage_warehouse_management/features/dashboard/presentation/cubit/temperature_cubit.dart';
import 'package:cold_storage_warehouse_management/features/dashboard/presentation/views/dashboard_screen.dart';
import 'package:cold_storage_warehouse_management/features/inbound/presentation/cubit/inventory_cubit.dart';
import 'package:cold_storage_warehouse_management/features/inbound/presentation/cubit/inventory_list_cubit.dart';
import 'package:cold_storage_warehouse_management/features/inbound/presentation/views/inbound_screen.dart';
import 'package:cold_storage_warehouse_management/features/inbound/presentation/views/inventory_list_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

abstract class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: DashboardScreen.routeName,
    routes: <RouteBase>[
      GoRoute(
        path: DashboardScreen.routeName,
        builder: (context, state) {
          return BlocProvider(
            create: (context) => getIt<TemperatureCubit>(),
            child: const DashboardScreen(),
          );
        },
      ),
      GoRoute(
        path: InboundScreen.routeName,
        builder: (context, state) => BlocProvider(
          create: (context) => getIt<InventoryCubit>(),
          child: const InboundScreen(),
        ),
      ),
      GoRoute(
        path: InventoryListScreen.routeName,
        builder: (context, state) => BlocProvider(
          create: (context) => getIt<InventoryListCubit>(),
          child: const InventoryListScreen(),
        ),
      ),
    ],
  );
}
