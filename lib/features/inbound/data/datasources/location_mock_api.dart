import 'package:injectable/injectable.dart';

@LazySingleton()
class LocationMockApi {
  Future<List<Map<String, dynamic>>> getLocations() async {
    await Future<void>.delayed(const Duration(milliseconds: 300));

    return [
      {
        'id': 'A1-01',
        'label': 'Zone A / Rack 1 / Slot 01',
        'capacity': 100,
        'current_load': 72,
      },
      {
        'id': 'A1-02',
        'label': 'Zone A / Rack 1 / Slot 02',
        'capacity': 120,
        'current_load': 120,
      },
      {
        'id': 'B2-05',
        'label': 'Zone B / Rack 2 / Slot 05',
        'capacity': 80,
        'current_load': 30,
      },
    ];
  }
}
