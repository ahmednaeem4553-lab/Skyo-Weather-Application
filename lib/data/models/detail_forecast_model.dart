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

  // Additional valuable details
  final double windSpeed;       // km/h
  final String windDirection;   // e.g. "N", "SSW"
  final int pressure;           // hPa
  final int uvIndex;
  final int airQuality;         // AQI (0-500)
  final double visibility;      // km
  final String sunrise;         // e.g. "06:15 AM"
  final String sunset;          // e.g. "07:45 PM"
  final double dewPoint;
  final int chanceOfRain;       // %

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
    required this.windSpeed,
    required this.windDirection,
    required this.pressure,
    required this.uvIndex,
    required this.airQuality,
    required this.visibility,
    required this.sunrise,
    required this.sunset,
    required this.dewPoint,
    required this.chanceOfRain,
  });

  // Optional: factory for API mapping (add real fields when you have hourly/daily extended data)
  factory DetailForecastModel.fromJson(Map<String, dynamic> json) {
    return DetailForecastModel(
      dayName: json['dayName'] ?? 'N/A',
      morningTemp: (json['morningTemp'] as num?)?.toDouble() ?? 0.0,
      afternoonTemp: (json['afternoonTemp'] as num?)?.toDouble() ?? 0.0,
      eveningTemp: (json['eveningTemp'] as num?)?.toDouble() ?? 0.0,
      nightTemp: (json['nightTemp'] as num?)?.toDouble() ?? 0.0,
      minTemp: (json['minTemp'] as num?)?.toDouble() ?? 0.0,
      maxTemp: (json['maxTemp'] as num?)?.toDouble() ?? 0.0,
      humidity: json['humidity'] as int? ?? 0,
      feelsLike: (json['feelsLike'] as num?)?.toDouble() ?? 0.0,
      condition: json['condition'] as String? ?? 'Unknown',
      description: json['description'] as String? ?? '',
      iconPath: json['iconPath'] as String? ?? 'assets/icons/unknown.png',
      windSpeed: (json['windSpeed'] as num?)?.toDouble() ?? 0.0,
      windDirection: json['windDirection'] as String? ?? 'N/A',
      pressure: json['pressure'] as int? ?? 0,
      uvIndex: json['uvIndex'] as int? ?? 0,
      airQuality: json['airQuality'] as int? ?? 0,
      visibility: (json['visibility'] as num?)?.toDouble() ?? 0.0,
      sunrise: json['sunrise'] as String? ?? 'N/A',
      sunset: json['sunset'] as String? ?? 'N/A',
      dewPoint: (json['dewPoint'] as num?)?.toDouble() ?? 0.0,
      chanceOfRain: json['chanceOfRain'] as int? ?? 0,
    );
  }
}