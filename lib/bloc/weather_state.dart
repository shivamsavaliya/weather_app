part of 'weather_bloc.dart';

@immutable
sealed class WeatherState {}

final class WeatherInitial extends WeatherState {}

class FetchedData extends WeatherState {
  final WeatherModelData data;
  FetchedData({
    required this.data,
  });
}

class GettingLatLong extends WeatherState {}

class ErrorState extends WeatherState {
  final String errorText;
  ErrorState({
    required this.errorText,
  });
}
