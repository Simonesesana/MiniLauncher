import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minilauncher/Preferences/WeatherForecast.dart';
import 'package:minilauncher/main.dart';

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
            "Localization service is disabled, please enable it to view weather forecast",
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
          child: Text(
            "Localization access is denied. Please enable it to view weather forecast",
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
    } else if(widget.weatherForecastState == WeatherForecastState.apiCallProblem) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 10
          ),
          child: Text(
            "Network error.\nPlease try again later",
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
