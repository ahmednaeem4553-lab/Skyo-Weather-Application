class WeatherModel {
  final String cityName;
  final double temperature;
  final String condition; // e.g. "Clear", "Clouds", "Rain"
  final String description; // e.g. "clear sky", "light rain"
  final int humidity;
  final double feelsLike;
  final String iconCode; // e.g. "01d", "10n"

  WeatherModel({
    required this.cityName,
    required this.temperature,
    required this.condition,
    required this.description,
    required this.humidity,
    required this.feelsLike,
    required this.iconCode,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      cityName: json['name'] as String? ?? 'Unknown',
      temperature: (json['main']['temp'] as num?)?.toDouble() ?? 0.0,
      condition: (json['weather'] as List<dynamic>?)?.isNotEmpty == true
          ? (json['weather'][0] as Map<String, dynamic>)['main'] as String? ?? 'Unknown'
          : 'Unknown',
      description: (json['weather'] as List<dynamic>?)?.isNotEmpty == true
          ? (json['weather'][0] as Map<String, dynamic>)['description'] as String? ?? ''
          : '',
      humidity: (json['main']['humidity'] as num?)?.toInt() ?? 0,
      feelsLike: (json['main']['feels_like'] as num?)?.toDouble() ?? 0.0,
      iconCode: (json['weather'] as List<dynamic>?)?.isNotEmpty == true
          ? (json['weather'][0] as Map<String, dynamic>)['icon'] as String? ?? '01d'
          : '01d',
    );
  }
}