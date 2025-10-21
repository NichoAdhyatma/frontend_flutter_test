class InboundItemEntity {
  InboundItemEntity({
    required this.sku,
    required this.batch,
    required this.expiry,
    required this.qty,
    required this.locationId,
  });

  final String sku;
  final String batch;
  final DateTime expiry;
  final int qty;
  final String locationId;

  bool get isExpiryBefore30Days {
    final currentDate = DateTime.now();

    final difference = expiry.difference(currentDate).inDays;

    return difference < 30;
  }
}
