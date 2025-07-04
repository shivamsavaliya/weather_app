import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import '../apis/weather_api.dart';
import '../models/weather_model.dart';
part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitial()) {
    on<WeatherInitialEvent>(weatherInitialEvent);
  }

  double lat = 0.0;
  double lon = 0.0;

  FutureOr<void> weatherInitialEvent(
      WeatherInitialEvent event, Emitter<WeatherState> emit) async {
    try {
      emit(GettingLatLong());
      await getLocation();
      WeatherModelData? data =
          await WeatherApi.fetchData(lat.toDouble(), lon.toDouble());
      emit(FetchedData(data: data!));
    } catch (e) {
      emit(ErrorState(errorText: e.toString()));
    }
  }

  Location location = Location();
  Future getLocation() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    locationData = await location.getLocation();
    await Future.delayed(const Duration(milliseconds: 500));
    lat = locationData.latitude!.toDouble();
    lon = locationData.longitude!.toDouble();
  }
}
