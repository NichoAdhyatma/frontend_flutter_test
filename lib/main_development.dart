import 'package:cold_storage_warehouse_management/app/app.dart';
import 'package:cold_storage_warehouse_management/app/core/di/app_di.dart';
import 'package:cold_storage_warehouse_management/bootstrap.dart';

Future<void> main() async {
  await bootstrap(() {
    configureDependencies();

    return const App();
  });
}
