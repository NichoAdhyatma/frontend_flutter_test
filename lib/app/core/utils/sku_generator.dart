String skuGeneratorRandom({
  required String prefix,
}) {
  final timestamp = DateTime.now().millisecondsSinceEpoch;
  final randomPart = (timestamp % 1000000).toString().padLeft(6, '0');

  return '$prefix-$randomPart';
}
