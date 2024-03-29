import "dart:async";
import "dart:convert";
import "package:flutter/material.dart";
import "package:http/http.dart" as http;
import "package:minilauncher/keys.dart";
import "package:geolocator/geolocator.dart";
import "package:permission_handler/permission_handler.dart";
import "package:weather_icons/weather_icons.dart";
import "package:minilauncher/Internationalization/Locale.dart";

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
  connectionError,
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

  bool isFetchingWeather = false;

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

    /*
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      try {
        await Geolocator.requestPermission();
      } catch(e) {
        return WeatherForecastState.locationPermissionDeniedForever;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return WeatherForecastState.locationPermissionDeniedForever;
    }
     */

    bool granted = await Permission.location.isGranted;
    if (!granted) {
      return WeatherForecastState.locationPermissionDeniedForever;
    }

    Position position = await Geolocator.getCurrentPosition();
    latitude = position.latitude;
    longitude = position.longitude;

    // Get address
    final response = await http.get(Uri.parse(
        "https://us1.locationiq.com/v1/reverse?key=${Keys.locationIqKey}"
            "&lat=$latitude&lon=$longitude&format=json&accept-languageA=${Lng.locale}"
    ));
    if (response.statusCode == 200) {
      try {
        location = jsonDecode(response.body)["address"]["city"];
      } catch(e) {
        try {
          location = jsonDecode(response.body)["address"]["town"];
        } catch(e) {
          try {
            location = jsonDecode(response.body)["address"]["village"];
          } catch(e) {
            try {
              location = jsonDecode(response.body)["address"]["county"];
            } catch(e) {
              location = "Unknown";
            }
          }
        }
      }
    } else {
      return WeatherForecastState.apiCallProblem;
    }

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

    if(isFetchingWeather) {
      return;
    }

    isFetchingWeather = true;

    // Function timeout
    Timer t = Timer(const Duration(seconds: 10), () {
      weatherForecastState = WeatherForecastState.connectionError;
      isFetchingWeather = false;
      return;
    });

    // Get user coordinates
    WeatherForecastState localizationState = await getUserCoordinates();
    if(localizationState != WeatherForecastState.allFine) {
      weatherForecastState = localizationState;
      isFetchingWeather = false;
      t.cancel();
      return;
    }

    // Get weather forecast
    await getDailyForecast();
    await get14DaysForecast();

    if(weatherForecastState != WeatherForecastState.apiCallProblem) {
      weatherForecastState = WeatherForecastState.allFine;
      lastUpdate = DateTime.now();
      isFetchingWeather = false;
      t.cancel();
      return;
    }

    isFetchingWeather = false;
    t.cancel();
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
        return lng["weather"]["weatherType"]["clearSky"];
      case 1:
      case 2:
      case 3:
        return lng["weather"]["weatherType"]["partlyCloudy"];
      case 45:
      case 48:
        return lng["weather"]["weatherType"]["fog"];
      case 51:
      case 53:
      case 55:
        return lng["weather"]["weatherType"]["drizzle"];
      case 56:
      case 57:
        return lng["weather"]["weatherType"]["freezingDrizzle"];
      case 61:
      case 63:
      case 65:
        return lng["weather"]["weatherType"]["rain"];
      case 66:
      case 67:
        return lng["weather"]["weatherType"]["freezingRain"];
      case 71:
      case 73:
      case 75:
        return lng["weather"]["weatherType"]["snow"];
      case 77:
        return lng["weather"]["weatherType"]["snowGrains"];
      case 80:
      case 81:
      case 82:
        return lng["weather"]["weatherType"]["rainshower"];
      case 85:
      case 86:
        return lng["weather"]["weatherType"]["snowshower"];
      case 95:
        return lng["weather"]["weatherType"]["thunderstorm"];
      case 96:
      case 99:
        return lng["weather"]["weatherType"]["thunderstormWithHail"];
      default:
        return lng["weather"]["weatherType"]["unknown"];
    }
  }

}
