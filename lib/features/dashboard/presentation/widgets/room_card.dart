import 'package:cold_storage_warehouse_management/features/dashboard/domain/entities/temperature_entity.dart';
import 'package:flutter/material.dart';

class RoomCard extends StatelessWidget {
  const RoomCard({required this.temperature, super.key});

  final TemperatureEntity temperature;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        elevation: 4,
        color: temperature.highlightColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: SizedBox(
          height: 150,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 16,
              children: [
                Text(
                  temperature.roomId,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: Text(
                    '${temperature.temperature.toStringAsFixed(1)}°C',
                    style: TextStyle(
                      fontSize: 20,
                      color: temperature.temperatureColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                if (!temperature.isInRange)
                  const Expanded(
                    child: Text(
                      'OUT OF RANGE',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
