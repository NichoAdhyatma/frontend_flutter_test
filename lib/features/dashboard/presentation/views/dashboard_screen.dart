import 'dart:async';
import 'dart:developer';
import 'package:cold_storage_warehouse_management/features/dashboard/presentation/cubit/temperature_cubit.dart';
import 'package:cold_storage_warehouse_management/features/dashboard/presentation/widgets/room_card.dart';
import 'package:cold_storage_warehouse_management/features/inbound/presentation/views/inbound_screen.dart';
import 'package:cold_storage_warehouse_management/features/inbound/presentation/views/inventory_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  static const String routeName = '/dashboard';

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();

    unawaited(context.read<TemperatureCubit>().startPolling());
  }

  @override
  void dispose() {
    log('STOP POLLING');

    context.read<TemperatureCubit>().stopPolling();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ColdStorage Dashboard'),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await context.read<TemperatureCubit>().fetch();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(), // penting!
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            spacing: MediaQuery.of(context).size.height * 0.4,
            children: [
              const TemperatureCard(),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton.icon(
                    icon: const Icon(Icons.add_box),
                    label: const Text('Inbound'),
                    onPressed: () async {
                      context.read<TemperatureCubit>().stopPolling();

                      await context.push(InboundScreen.routeName);

                      if (!context.mounted) return;

                      unawaited(
                        context.read<TemperatureCubit>().startPolling(),
                      );
                    },
                  ),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.inventory),
                    label: const Text('Inventory'),
                    onPressed: () async {
                      context.read<TemperatureCubit>().stopPolling();

                      await context.push(InventoryListScreen.routeName);

                      if (!context.mounted) return;

                      unawaited(
                        context.read<TemperatureCubit>().startPolling(),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TemperatureCard extends StatelessWidget {
  const TemperatureCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TemperatureCubit, TemperatureState>(
      builder: (context, state) {
        if (state is TemperatureLoading || state is TemperatureInitial) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is TemperatureFailure) {
          return Center(child: Text('Error: ${state.message}'));
        } else if (state is TemperatureLoadSuccess) {
          final temps = state.temps;

          final formatedDate = DateFormat(
            'dd MMM yyyy, HH:mm:ss',
          ).format(state.lastUpdated.toLocal());

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text.rich(
                TextSpan(
                  text: 'Last Updated',
                  children: [
                    TextSpan(
                      text: '\n$formatedDate',
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),

                style: const TextStyle(fontSize: 12),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: temps
                    .map(
                      (temp) => RoomCard(temperature: temp),
                    )
                    .toList(),
              ),
            ],
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
