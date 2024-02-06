import "dart:convert";
import "package:flutter/material.dart";
import "package:http/http.dart" as http;
import "package:geolocator/geolocator.dart";
import "package:weather_icons/weather_icons.dart";

// Weather Forecast instance
WeatherForecast weatherForecast = WeatherForecast();

WeatherForecastState weatherForecastState = WeatherForecastState.loading;

// Location error enum
enum WeatherForecastState {
  loading,
  locationServiceDisabled,
  locationPermissionDenied,
  locationPermissionDeniedForever,
  apiCallProblem,
  allFine
}

// Hourly Forecast
class HourlyForecast {

  final DateTime time;
  final double temperature;
  final int weatherCode;

  // Constructor
  HourlyForecast(this.time, this.temperature, this.weatherCode);

}

// Daily Forecast
class DailyForecast {

  final DateTime day;
  final double maxTemperature;
  final double minTemperature;
  final int weatherCode;

  // Constructor
  DailyForecast(this.day, this.maxTemperature, this.minTemperature, this.weatherCode);

}

/// Weather forecast class
class WeatherForecast {

  // Properties
  // User location
  double? latitude;
  double? longitude;

  String location = "";

  DateTime lastUpdate = DateTime.now();

  // Weather forecast
  List<HourlyForecast> dailyForecast = [];
  List<DailyForecast> longTermForecast = [];

  // Methods
  // Get user coordinates
  Future<WeatherForecastState> getUserCoordinates() async {

    // Checks if the location service is enabled
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return WeatherForecastState.locationServiceDisabled;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      return WeatherForecastState.locationPermissionDeniedForever;
    }

    Position position = await Geolocator.getCurrentPosition();
    latitude = position.latitude;
    longitude = position.longitude;

    // Get address
    final response = await http.get(Uri.parse(
        "https://www.mapquestapi.com/geocoding/v1/reverse?key=BxjvY69fjSJU7qjHmB0vetQpjBZdV1kE&"
        "location=$latitude,$longitude&includeRoadMetadata=false&includeNearestIntersection=false"
    ));

    return WeatherForecastState.allFine;

  }

  // Get hourly forecast
  Future<void> getDailyForecast() async {

    dailyForecast = [];

    // Execute API call
    final response = await http.get(Uri.parse(
      "https://api.open-meteo.com/v1/forecast?latitude=$latitude&longitude=$longitude&hourly=temperature_2m,weather_code&timezone=auto&forecast_days=2"
    ));
    if (response.statusCode == 200) {

      var data = jsonDecode(response.body)["hourly"];
      var time = data["time"];
      var temperature_2m = data["temperature_2m"];
      var weatherCode = data["weather_code"];

      for(var i = DateTime.now().hour; i < DateTime.now().hour + 24; i++) {
        dailyForecast.add(HourlyForecast(
            DateTime.parse(time[i]),
            temperature_2m[i],
            weatherCode[i]
          )
        );
      }
      return;

    } else {
      weatherForecastState = WeatherForecastState.apiCallProblem;
      return;
    }

  }

  // Get daily forecast
  Future<void> get14DaysForecast() async {

    longTermForecast = [];

    // Execute API call
    final response = await http.get(Uri.parse(
        "https://api.open-meteo.com/v1/forecast?latitude=$latitude&longitude=$longitude"
        "&daily=weather_code,temperature_2m_max,temperature_2m_min&timezone=auto&forecast_days=14"
    ));
    if (response.statusCode == 200) {

      var data = jsonDecode(response.body)["daily"];
      var time = data["time"];
      var maxTemperature = data["temperature_2m_max"];
      var minTemperature = data["temperature_2m_min"];
      var weatherCode = data["weather_code"];

      for(var i = 0; i < 14; i++) {
        longTermForecast.add(DailyForecast(
            DateTime.parse(time[i]),
            maxTemperature[i],
            minTemperature[i],
            weatherCode[i]
          )
        );
      }

      return;

    } else {
      weatherForecastState = WeatherForecastState.apiCallProblem;
      return;
    }
  }

  // Get weather forecast
  // Return states:
  // 0 - All fine
  // 1 - Location service problem
  // 2 - API call problem
  Future<void> getWeatherForecast() async {
    WeatherForecastState localizationState = await getUserCoordinates();
    if(localizationState != WeatherForecastState.allFine) {
      weatherForecastState = localizationState;
      return;
    }
    await getDailyForecast();
    await get14DaysForecast();
    weatherForecastState = WeatherForecastState.allFine;
    lastUpdate = DateTime.now();
    return;
  }

  // Returns an icon base on the weather-code
  // Weather codes:
  // 0	Clear sky
  // 1, 2, 3	Mainly clear, partly cloudy, and overcast
  // 45, 48	Fog and depositing rime fog
  // 51, 53, 55	Drizzle: Light, moderate, and dense intensity
  // 56, 57	Freezing Drizzle: Light and dense intensity
  // 61, 63, 65	Rain: Slight, moderate and heavy intensity
  // 66, 67	Freezing Rain: Light and heavy intensity
  // 71, 73, 75	Snow fall: Slight, moderate, and heavy intensity
  // 77	Snow grains
  // 80, 81, 82	Rain showers: Slight, moderate, and violent
  // 85, 86	Snow showers slight and heavy
  // 95	Thunderstorm: Slight or moderate
  // 96, 99	Thunderstorm with slight and heavy hail
  static IconData getWeatherIcon(int weatherCode) {
    switch(weatherCode) {
      case 0:
        return WeatherIcons.day_sunny;
      case 1:
      case 2:
      case 3:
        return WeatherIcons.day_cloudy;
      case 45:
      case 48:
        return WeatherIcons.fog;
      case 51:
      case 53:
      case 55:
        return WeatherIcons.rain;
      case 56:
      case 57:
        return WeatherIcons.sleet;
      case 61:
      case 63:
      case 65:
        return WeatherIcons.rain;
      case 66:
      case 67:
        return WeatherIcons.sleet;
      case 71:
      case 73:
      case 75:
        return WeatherIcons.snow;
      case 77:
        return WeatherIcons.snow;
      case 80:
      case 81:
      case 82:
        return WeatherIcons.showers;
      case 85:
      case 86:
        return WeatherIcons.snow;
      case 95:
        return WeatherIcons.thunderstorm;
      case 96:
      case 99:
        return WeatherIcons.thunderstorm;
      default:
        return WeatherIcons.alien;
    }
  }

  // Returns a text based on the weather-code
  static String getWeatherState(int weatherCode) {
    switch(weatherCode) {
      case 0:
        return "Clear sky";
      case 1:
      case 2:
      case 3:
        return "Partly cloudy";
      case 45:
      case 48:
        return "Fog";
      case 51:
      case 53:
      case 55:
        return "Drizzle";
      case 56:
      case 57:
        return "Freezing drizzle";
      case 61:
      case 63:
      case 65:
        return "Rain";
      case 66:
      case 67:
        return "Freezing rain";
      case 71:
      case 73:
      case 75:
        return "Snow";
      case 77:
        return "Snow grains";
      case 80:
      case 81:
      case 82:
        return "Rain showers";
      case 85:
      case 86:
        return "Snow showers";
      case 95:
        return "Thunderstorm";
      case 96:
      case 99:
        return "Thunderstorm with hail";
      default:
        return "Alien weather";
    }
  }

}
