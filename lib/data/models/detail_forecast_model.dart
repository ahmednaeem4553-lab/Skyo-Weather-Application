// lib/data/models/detail_forecast_model.dart
class DetailForecastModel {
  final String dayName;
  final double morningTemp;
  final double afternoonTemp;
  final double eveningTemp;
  final double nightTemp;
  final double minTemp;
  final double maxTemp;
  final int humidity;
  final double feelsLike;
  final String condition;
  final String description;
  final String iconPath;

  DetailForecastModel({
    required this.dayName,
    required this.morningTemp,
    required this.afternoonTemp,
    required this.eveningTemp,
    required this.nightTemp,
    required this.minTemp,
    required this.maxTemp,
    required this.humidity,
    required this.feelsLike,
    required this.condition,
    required this.description,
    required this.iconPath,
  });
}