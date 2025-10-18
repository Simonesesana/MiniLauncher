import 'package:flutter/material.dart';
import 'package:minilauncher/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minilauncher/Packages/WeatherForecast.dart';
import 'package:minilauncher/Pages/Home/Weather/WeatherForecastErrorPage.dart';
import 'package:minilauncher/Pages/Home/Weather/DailyForecast/DailyForecastWidget.dart';
import 'package:minilauncher/Pages/Home/Weather/WeeklyForecast/WeeklyForecastWidget.dart';

class Weather extends StatefulWidget {
  const Weather({super.key});

  @override
  State<Weather> createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {

  void fetchWeather() async {
    await weatherForecast.getWeatherForecast();
    setState(() {});
  }

  @override
  void initState() {
    if(DateTime.now().difference(weatherForecast.lastUpdate).inMinutes > 30
        || weatherForecastState != WeatherForecastState.allFine
        || weatherForecast.dailyForecast[0].time.hour != DateTime.now().hour
    ) {
      fetchWeather();
    }
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return weatherForecastState == WeatherForecastState.allFine ? SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width / 20,
          right: MediaQuery.of(context).size.width / 20,
          top: MediaQuery.of(context).size.width / 20,
        ),
        child: Column(
          children: [

            SizedBox(
              height: MediaQuery.of(context).size.width / 10,
            ),

            Center(
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    children: [
                      TextSpan(
                        text: "My location:\n",
                        style: GoogleFonts.montserrat(
                            letterSpacing: 1,
                            fontWeight: FontWeight.w400,
                            color: preferences.selectedTheme.textColor,
                            fontSize: MediaQuery.of(context).size.width / 17
                        ),
                      ),
                      TextSpan(
                        text: weatherForecast.location,
                        style: GoogleFonts.montserrat(
                            letterSpacing: 1,
                            fontWeight: FontWeight.w400,
                            color: preferences.selectedTheme.textColor.withOpacity(0.7),
                            fontSize: MediaQuery.of(context).size.width / 20
                        ),
                      ),
                      TextSpan(
                        text: "\n${weatherForecast.dailyForecast[0].temperature}°\n",
                        style: GoogleFonts.montserrat(
                            letterSpacing: 2,
                            fontWeight: FontWeight.w400,
                            color: preferences.selectedTheme.textColor,
                            fontSize: MediaQuery.of(context).size.width / 5
                        ),
                      ),
                      TextSpan(
                        text: WeatherForecast.getWeatherState(weatherForecast.dailyForecast[0].weatherCode),
                        style: GoogleFonts.montserrat(
                            letterSpacing: 1,
                            fontWeight: FontWeight.w400,
                            color: preferences.selectedTheme.textColor,
                            fontSize: MediaQuery.of(context).size.width / 20
                        ),
                      ),
                    ]
                ),
              ),
            ),

            SizedBox(
              height: MediaQuery.of(context).size.width / 10,
            ),

            // Daily forecast
            const DailyForecastWidget(),

            const SizedBox(height: 4),

            // Weekly forecast
            const WeeklyForecastWidget()

          ],
        ),
      ),
    ) : WeatherForecastErrorPage(weatherForecastState: weatherForecastState);
  }
}
