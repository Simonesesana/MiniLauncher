import 'package:flutter/material.dart';
import 'package:minilauncher/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:minilauncher/Packages/WeatherForecast.dart';
import 'package:permission_handler/permission_handler.dart';

class WeatherForecastErrorPage extends StatefulWidget {

  WeatherForecastState weatherForecastState;

  WeatherForecastErrorPage({super.key, required this.weatherForecastState});

  @override
  State<WeatherForecastErrorPage> createState() => _WeatherForecastErrorPageState();
}

class _WeatherForecastErrorPageState extends State<WeatherForecastErrorPage> {

  @override
  Widget build(BuildContext context) {

    if(widget.weatherForecastState == WeatherForecastState.loading) {
      return SpinKitRing(
        color: preferences.selectedTheme.textColor,
        lineWidth: 1,
      );
    } else if(widget.weatherForecastState == WeatherForecastState.locationServiceDisabled) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10
          ),
          child: Text(
            "Location service is disabled. Please enable it to fetch weather data.",
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
                letterSpacing: 1,
                fontWeight: FontWeight.w400,
                color: preferences.selectedTheme.textColor,
                fontSize: MediaQuery.of(context).size.width / 25
            ),
          ),
        ),
      );
    } else if(widget.weatherForecastState == WeatherForecastState.locationPermissionDenied ||
              widget.weatherForecastState == WeatherForecastState.locationPermissionDeniedForever) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 10
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Location permission is denied. Please grant location permission to fetch weather data.",
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                    letterSpacing: 1,
                    fontWeight: FontWeight.w400,
                    color: preferences.selectedTheme.textColor,
                    fontSize: MediaQuery.of(context).size.width / 25
                ),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  openAppSettings();
                },
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 15
                    ),
                    child: Text(
                      "Grant permission",
                      style: GoogleFonts.montserrat(
                          color: preferences.selectedTheme.primaryColor,
                          fontSize: MediaQuery.of(context).size.width / 27
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    } else if(widget.weatherForecastState == WeatherForecastState.apiCallProblem
        || widget.weatherForecastState == WeatherForecastState.connectionError) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 10
          ),
          child: Text(
            "There was a problem fetching weather data. Please try again later.",
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
                letterSpacing: 1,
                fontWeight: FontWeight.w400,
                color: preferences.selectedTheme.textColor,
                fontSize: MediaQuery.of(context).size.width / 25
            ),
          ),
        ),
      );
    } else {
      return SpinKitRing(
        color: preferences.selectedTheme.textColor,
        lineWidth: 1,
      );
    }
  }
}
