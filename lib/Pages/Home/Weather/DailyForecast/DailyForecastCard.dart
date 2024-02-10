import 'package:flutter/material.dart';
import 'package:minilauncher/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minilauncher/Internationalization/Locale.dart';
import 'package:minilauncher/Preferences/WeatherForecast.dart';


dailyForecastCard(HourlyForecast forecast, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(
        top: 5,
        bottom: 5,
        left: 5
    ),
    child: SizedBox(
      width: 85,
      child: Card(
        color: preferences.selectedTheme.textColor.withOpacity(0.13),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: 5
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              // Hour
              Text(
                forecast.time.hour == DateTime.now().hour ?
                "${lng["weather"]["now"]}" : "${forecast.time.hour.toString().padLeft(2, "0")}:00",
                style: GoogleFonts.montserrat(
                    letterSpacing: 1,
                    color: preferences.selectedTheme.textColor,
                    fontSize: MediaQuery.of(context).size.width / 30
                ),
              ),

              // Weather icon
              Icon(
                WeatherForecast.getWeatherIcon(forecast.weatherCode),
                size: 17,
                color: preferences.selectedTheme.textColor,
              ),

              const SizedBox(height: 2),

              // Temperature
              Text(
                "${forecast.temperature.toStringAsFixed(0)}°",
                style: GoogleFonts.montserrat(
                    letterSpacing: 1,
                    color: preferences.selectedTheme.textColor,
                    fontSize: MediaQuery.of(context).size.width / 30
                ),
              ),

            ],
          ),
        ),
      ),
    ),
  );
}