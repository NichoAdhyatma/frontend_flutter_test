import 'dart:async';

import 'package:cold_storage_warehouse_management/app/core/utils/sku_generator.dart';
import 'package:cold_storage_warehouse_management/features/inbound/domain/entities/inbound_item_entity.dart';
import 'package:cold_storage_warehouse_management/features/inbound/domain/entities/location_entity.dart';
import 'package:cold_storage_warehouse_management/features/inbound/presentation/cubit/inventory_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class InboundScreen extends StatefulWidget {
  const InboundScreen({super.key});

  static const String routeName = '/inbound';

  @override
  State<InboundScreen> createState() => _InboundScreenState();
}

class _InboundScreenState extends State<InboundScreen> {
  final _formKey = GlobalKey<FormState>();
  final _skuController = TextEditingController();
  final _batchController = TextEditingController();
  final _qtyController = TextEditingController();
  DateTime? _expiry;
  String? _selectedLocId;

  @override
  void initState() {
    super.initState();
    unawaited(context.read<InventoryCubit>().loadData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Inbound Barang')),
      body: BlocBuilder<InventoryCubit, InventoryState>(
        builder: (context, state) {
          if (state is InventoryLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is InventoryLocationLoaded) {
            final locations = state.locations;

            _selectedLocId ??= locations.isNotEmpty ? locations.first.id : null;

            final selected = locations.isSelected(_selectedLocId);

            final isFull = selected?.isFull ?? false;

            return Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    TextFormField(
                      controller: _skuController,
                      decoration: InputDecoration(
                        labelText: 'SKU',
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.qr_code),
                          onPressed: () =>
                              _skuController.text = skuGeneratorRandom(
                                prefix: 'SKU',
                              ),
                        ),
                      ),
                      validator: (v) =>
                          v == null || v.isEmpty ? 'Wajib diisi' : null,
                    ),

                    TextFormField(
                      controller: _batchController,
                      decoration: const InputDecoration(labelText: 'Batch'),
                      validator: (v) =>
                          v == null || v.isEmpty ? 'Wajib diisi' : null,
                    ),

                    TextFormField(
                      controller: _qtyController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: 'Qty'),
                      validator: (v) {
                        final n = int.tryParse(v ?? '');
                        if (n == null || n <= 0) return 'Qty > 0';
                        return null;
                      },
                    ),

                    ListTile(
                      title: Text(
                        _expiry == null
                            ? 'Pilih tanggal Expiry'
                            : 'Expiry: ${DateFormat('dd-MM-y').format(
                                _expiry?.toLocal() ?? DateTime.now(),
                              )}',
                      ),
                      trailing: const Icon(Icons.calendar_today),
                      onTap: () async {
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2100),
                        );
                        if (picked != null) setState(() => _expiry = picked);
                      },
                    ),

                    if (_expiry == null)
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          'Wajib diisi',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                          ),
                        ),
                      ),

                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(labelText: 'Lokasi'),
                      initialValue: _selectedLocId ?? locations.first.id,
                      items: locations.map((l) {
                        return DropdownMenuItem(
                          value: l.id,
                          child: Text(
                            '${l.label} (${l.currentLoad}/${l.capacity})',
                          ),
                        );
                      }).toList(),
                      onChanged: (v) => setState(() => _selectedLocId = v),
                    ),

                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: isFull
                          ? null
                          : () async {
                              if (_formKey.currentState!.validate() &&
                                  _expiry != null) {
                                final item = InboundItemEntity(
                                  sku: _skuController.text,
                                  batch: _batchController.text,
                                  expiry: _expiry!,
                                  qty: int.parse(_qtyController.text),
                                  locationId:
                                      _selectedLocId ?? locations.first.id,
                                );
                                await context.read<InventoryCubit>().addItem(
                                  item,
                                );

                                Navigator.pop(context);
                              }
                            },
                      child: Text(isFull ? 'Lokasi penuh' : 'Submit'),
                    ),
                  ],
                ),
              ),
            );
          }

          if (state is InventoryError) {
            return Center(child: Text(state.message));
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
