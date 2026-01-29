class DailyForecastModel {
  final DateTime date;
  final double minTemp;
  final double maxTemp;
  final double avgTemp;
  final String condition;       // "Clear", "Clouds", "Rain", etc.
  final String description;
  final String iconCode;        // e.g. "10d" — you can map to your custom icons later
  final int humidity;

  DailyForecastModel({
    required this.date,
    required this.minTemp,
    required this.maxTemp,
    required this.avgTemp,
    required this.condition,
    required this.description,
    required this.iconCode,
    required this.humidity,
  });

  factory DailyForecastModel.fromJson(Map<String, dynamic> json) {
    return DailyForecastModel(
      date: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000),
      minTemp: (json['main']['temp_min'] as num).toDouble(),
      maxTemp: (json['main']['temp_max'] as num).toDouble(),
      avgTemp: (json['main']['temp'] as num).toDouble(),
      condition: (json['weather'] as List<dynamic>)[0]['main'] as String,
      description: (json['weather'] as List<dynamic>)[0]['description'] as String,
      iconCode: (json['weather'] as List<dynamic>)[0]['icon'] as String,
      humidity: json['main']['humidity'] as int,
    );
  }
}