import 'dart:async';

import 'package:cold_storage_warehouse_management/features/inbound/presentation/cubit/inventory_list_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InventoryListScreen extends StatefulWidget {
  const InventoryListScreen({super.key});

  static const String routeName = '/inventory-list';

  @override
  State<InventoryListScreen> createState() => _InventoryListScreenState();
}

class _InventoryListScreenState extends State<InventoryListScreen> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    unawaited(context.read<InventoryListCubit>().loadItems());
  }

  bool _isNearExpiry(DateTime expiry) {
    final now = DateTime.now();
    return expiry.isBefore(now.add(const Duration(days: 3)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Inventory List')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              onChanged: (v) => context.read<InventoryListCubit>().search(v),
              decoration: const InputDecoration(
                labelText: 'Search by SKU or Batch',
                prefixIcon: Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 12),
            BlocBuilder<InventoryListCubit, InventoryListState>(
              builder: (context, state) {
                if (state is InventoryListLoading) {
                  return const Expanded(
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                if (state is InventoryListError) {
                  return Expanded(child: Center(child: Text(state.message)));
                }

                if (state is InventoryListLoaded) {
                  if (state.filteredItems.isEmpty) {
                    return const Expanded(
                      child: Center(child: Text('No items found')),
                    );
                  }

                  return Expanded(
                    child: RefreshIndicator(
                      onRefresh: () {
                        return context
                            .read<InventoryListCubit>()
                            .loadItems();
                      },
                      child: ListView.builder(
                        itemCount: state.filteredItems.length,
                        itemBuilder: (context, index) {
                          final item = state.filteredItems[index];
                          final isNear = _isNearExpiry(item.expiry);

                          return Card(
                            color: isNear ? Colors.red[100] : null,
                            margin: const EdgeInsets.symmetric(vertical: 6),
                            child: ListTile(
                              title: Text(
                                item.sku,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Batch: ${item.batch}'),
                                  Text(
                                    'Qty: ${item.qty} | Loc: ${item.locationId}',
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'Expiry: ${item.expiry.toIso8601String().split('T').first}',
                                      ),

                                      if (item.isExpiryBefore30Days)
                                        const Padding(
                                          padding: EdgeInsets.only(
                                            left: 8,
                                          ),
                                          child: Icon(
                                            Icons.warning,
                                            color: Colors.red,
                                            size: 16,
                                          ),
                                        )
                                      else
                                        const SizedBox.shrink(),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }

                return const Expanded(child: SizedBox());
              },
            ),
          ],
        ),
      ),
    );
  }
}
