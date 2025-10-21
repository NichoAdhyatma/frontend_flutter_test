class LocationEntity {
  LocationEntity({
    required this.id,
    required this.label,
    required this.capacity,
    required this.currentLoad,
  });

  final String id;
  final String label;
  final int capacity;
  final int currentLoad;

  bool get isFull => currentLoad >= capacity;
}

extension ListEntityLocationX on List<LocationEntity> {
  LocationEntity? isSelected(String? id) {
    if (id == null) return null;
    try {
      return firstWhere((location) => location.id == id);
    } on Exception catch (_) {
      return null;
    }
  }
}
