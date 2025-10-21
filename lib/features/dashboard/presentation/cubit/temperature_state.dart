part of 'temperature_cubit.dart';

@immutable
sealed class TemperatureState {}

final class TemperatureInitial extends TemperatureState {}

final class TemperatureLoading extends TemperatureState {}

class TemperatureLoadSuccess extends TemperatureState {
  TemperatureLoadSuccess(this.temps, this.lastUpdated);

  final List<TemperatureEntity> temps;
  final DateTime lastUpdated;
}

class TemperatureFailure extends TemperatureState {
  TemperatureFailure(this.message);

  final String message;
}
