import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/bloc/weather_bloc.dart';
import 'package:weather_app/utils/constants.dart';
import 'package:weather_app/widgets/blur_box.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  WeatherBloc bloc = WeatherBloc();

  @override
  void initState() {
    bloc.add(WeatherInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: colors,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: BlocConsumer<WeatherBloc, WeatherState>(
            bloc: bloc,
            listener: (context, state) {},
            builder: (context, state) {
              switch (state.runtimeType) {
                case FetchedData:
                  var successData = state as FetchedData;
                  double temp = successData.data.main!.temp! - 273.15;
                  double max = successData.data.main!.tempMax! - 273.15;
                  double min = successData.data.main!.tempMin! - 273.15;

                  return Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            child: Image.network(
                              "https://openweathermap.org/img/wn/${successData.data.weather![0].icon}@4x.png",
                            ),
                          ),
                          Text(
                            "${temp.toStringAsFixed(2)}°C",
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 36,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "${successData.data.name}, ${successData.data.sys!.country}",
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "Max: ${max.toStringAsFixed(2)}",
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                "Min: ${min.toStringAsFixed(2)}",
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),
                          Image.asset("assets/House.png"),
                          const SizedBox(height: 10),
                          BlurBox(
                              name: "Condition",
                              value: successData.data.weather![0].description
                                  .toString()),
                          BlurBox(
                              name: "Humidity",
                              value: successData.data.main!.humidity!
                                  .toStringAsFixed(2)),
                          BlurBox(
                              name: "Pressure",
                              value: successData.data.main!.pressure!
                                  .toStringAsFixed(2)),
                          BlurBox(
                              name: "Visibility",
                              value: successData.data.visibility!.toString()),
                          BlurBox(
                              name: "Wind Speed",
                              value:
                                  "${successData.data.wind!.speed!.toStringAsFixed(2)} meter/sec"),
                          BlurBox(
                              name: "Cloudness",
                              value: "${successData.data.clouds!.all} %"),
                        ],
                      ),
                    ),
                  );

                case GettingLatLong:
                  return const Center(
                      child: CircularProgressIndicator(
                    color: Colors.white,
                  ));

                case ErrorState:
                  var errorData = state as ErrorState;
                  return Center(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Error: ${errorData.errorText}",
                      style: GoogleFonts.inter(fontSize: 20),
                    ),
                  ));
                default:
                  return const Center(child: Text("No Data Found"));
              }
            },
          ),
        ),
      ),
    );
  }
}
