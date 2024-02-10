import 'package:flutter/material.dart';
import 'package:minilauncher/main.dart';
import 'package:minilauncher/Preferences/WeatherForecast.dart';

import 'DailyForecastCard.dart';

class DailyForecastWidget extends StatefulWidget {
  const DailyForecastWidget({super.key});

  @override
  State<DailyForecastWidget> createState() => _DailyForecastWidgetState();
}

class _DailyForecastWidgetState extends State<DailyForecastWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      color: Colors.transparent,
      child: Card(
        color: preferences.selectedTheme.textColor.withOpacity(0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
        ),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: weatherForecast.dailyForecast.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return dailyForecastCard(
              weatherForecast.dailyForecast[index],
              context,
            );
          },
        ),
      ),
    );
  }
}
