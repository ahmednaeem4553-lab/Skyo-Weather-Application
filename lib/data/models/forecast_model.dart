// lib/presentation/models/forecast_model.dart
class ForecastDayModel {
  final String dayName;
  final double minTemp;
  final double maxTemp;
  final String condition;
  final String iconPath;
  final double iconSize;

  ForecastDayModel({
    required this.dayName,
    required this.minTemp,
    required this.maxTemp,
    required this.condition,
    required this.iconPath,
    // this.iconsize = 40.0,
    required this.iconSize,
  });
}
