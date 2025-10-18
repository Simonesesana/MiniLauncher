import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minilauncher/Packages/WeatherForecast.dart';
import 'package:minilauncher/main.dart';

class WeeklyForecastWidget extends StatefulWidget {
  const WeeklyForecastWidget({super.key});

  @override
  State<WeeklyForecastWidget> createState() => _WeeklyForecastWidgetState();
}

class _WeeklyForecastWidgetState extends State<WeeklyForecastWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        color: preferences.selectedTheme.textColor.withOpacity(0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Text
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 30,
                  vertical: MediaQuery.of(context).size.width / 40
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.calendar_month,
                    size: 17,
                    color: preferences.selectedTheme.textColor,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    "Weekly Forecast",
                    style: GoogleFonts.montserrat(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: preferences.selectedTheme.textColor
                    ),
                  ),
                ],
              ),
            ),

            // Divider
            Container(
              height: 2,
              width: MediaQuery.of(context).size.width,
              color: preferences.selectedTheme.textColor.withOpacity(0.03),
            ),


            // Forecast
            Flexible(
              child: ListView.builder(
                itemCount: 14,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width / 20,
                      vertical: MediaQuery.of(context).size.width / 60
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            // Day
                            Text(
                              weatherForecast.longTermForecast[index].day.day != DateTime.now().day ?
                                "${weatherForecast.longTermForecast[index].day.day.toString().padLeft(2, "0")}"
                                "/${weatherForecast.longTermForecast[index].day.month.toString().padLeft(2, "0")}"
                                : "Today",
                              style: GoogleFonts.montserrat(
                                color: preferences.selectedTheme.textColor
                              ),
                            ),

                            Row(
                              children: [

                                // Temperature
                                Text(
                                  "${weatherForecast.longTermForecast[index].minTemperature}° / "
                                      "${weatherForecast.longTermForecast[index].maxTemperature}°",
                                  style: GoogleFonts.montserrat(
                                      color: preferences.selectedTheme.textColor
                                  ),
                                ),

                                const SizedBox(width: 20),

                                // Weather icon
                                Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: 11
                                  ),
                                  child: Icon(
                                    WeatherForecast.getWeatherIcon(weatherForecast.longTermForecast[index].weatherCode),
                                    color: preferences.selectedTheme.textColor,
                                    size: 17,
                                  ),
                                ),

                              ],
                            )

                          ],
                        ),

                        // Divider
                        index != 13 ? Padding(
                          padding: const EdgeInsets.only(
                            top: 8,
                          ),
                          child: Container(
                            height: 2,
                            width: MediaQuery.of(context).size.width,
                            color: preferences.selectedTheme.textColor.withOpacity(0.1),
                          ),
                        ) : Container(
                          height: 10,
                        ),

                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        )
      ),
    );
  }
}
