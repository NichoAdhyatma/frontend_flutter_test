import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cold_storage_warehouse_management/features/dashboard/domain/entities/temperature_entity.dart';
import 'package:cold_storage_warehouse_management/features/dashboard/domain/usecases/get_temperatures_usecase.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

part 'temperature_state.dart';

@injectable
class TemperatureCubit extends Cubit<TemperatureState> {
  TemperatureCubit(this.getTemperaturesUseCase) : super(TemperatureInitial());

  final GetTemperaturesUseCase getTemperaturesUseCase;

  Timer? _timer;

  Future<void> fetch() async {
    try {
      emit(TemperatureLoading());

      final temps = await getTemperaturesUseCase();

      emit(TemperatureLoadSuccess(temps, DateTime.now()));
    } on Exception catch (e) {
      emit(TemperatureFailure(e.toString()));
    }
  }

  Future<void> startPolling({int seconds = 5}) async {
    log('START POLLING every $seconds seconds');
    
    await fetch();

    _timer?.cancel();

    _timer = Timer.periodic(Duration(seconds: seconds), (_) => fetch());
  }

  void stopPolling() {
    log('STOP POLLING');
    
    _timer?.cancel();

    _timer = null;
  }

  @override
  Future<void> close() {
    _timer?.cancel();

    return super.close();
  }
}
