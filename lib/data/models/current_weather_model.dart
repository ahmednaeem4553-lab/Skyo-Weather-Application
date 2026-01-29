// lib/presentation/models/current_weather_model.dart
import 'package:skyo_app_new/data/models/weather_model.dart';

class CurrentWeatherModel {
  final double temperature;
  final String cityName;
  final String description;
  final double feelsLike;
  final int humidity;
  final DateTime lastUpdated;

  CurrentWeatherModel({
    required this.temperature,
    required this.cityName,
    required this.description,
    required this.feelsLike,
    required this.humidity,
    required this.lastUpdated,
  });

  factory CurrentWeatherModel.fromWeather(WeatherModel weather) {
    return CurrentWeatherModel(
      temperature: weather.temperature,
      cityName: weather.cityName,
      description: weather.description,
      feelsLike: weather.feelsLike,
      humidity: weather.humidity,
      lastUpdated: DateTime.now(),
    );
  }
}