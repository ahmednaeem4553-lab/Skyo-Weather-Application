// weather_services.dart
import 'package:dio/dio.dart';

import '../../core/constants/api_constants.dart';
import '../models/daily_forecast_model.dart';
import '../models/weather_model.dart';
import '../models/weather_response.dart';

// Simple model for city suggestions from Geocoding API
class CitySuggestion {
  final String name;
  final String? state;
  final String country;
  final double lat;
  final double lon;

  CitySuggestion({
    required this.name,
    this.state,
    required this.country,
    required this.lat,
    required this.lon,
  });

  factory CitySuggestion.fromJson(Map<String, dynamic> json) {
    return CitySuggestion(
      name: json['name'] as String? ?? 'Unknown',
      state: json['state'] as String?,
      country: json['country'] as String? ?? '',
      lat: (json['lat'] as num?)?.toDouble() ?? 0.0,
      lon: (json['lon'] as num?)?.toDouble() ?? 0.0,
    );
  }

  // Nice display string for UI suggestions
  String get displayName {
    final parts = [name];
    if (state != null && state!.isNotEmpty) parts.add(state!);
    if (country.isNotEmpty) parts.add(country);
    return parts.join(', ');
  }
}

class WeatherService {
  final Dio _dio;

  WeatherService() : _dio = Dio();

  /// Fetches current weather + 5-day forecast.
  /// Accepts either city name OR latitude/longitude.
  /// One of (city) or (lat + lon) must be provided.
  Future<WeatherResponse> getWeatherWithForecast({
    String? city,
    double? lat,
    double? lon,
  }) async {
    try {
      // Validate input
      if ((city == null || city.isEmpty) && (lat == null || lon == null)) {
        throw Exception('Either city name or coordinates (lat/lon) must be provided');
      }

      // Common query parameters
      final baseParams = {
        'appid': ApiConstants.apiKey,
        'units': 'metric',
      };

      // Add location params
      if (city != null && city.isNotEmpty) {
        baseParams['q'] = city;
      } else {
        baseParams['lat'] = lat.toString();
        baseParams['lon'] = lon.toString();
      }

      // 1. Fetch current weather
      final currentResponse = await _dio.get(
        '${ApiConstants.baseUrl}/weather',
        queryParameters: baseParams,
      );

      if (currentResponse.statusCode != 200) {
        throw Exception('Failed to load current weather: ${currentResponse.statusCode}');
      }

      final currentWeather = WeatherModel.fromJson(currentResponse.data);

      // 2. Fetch 5-day forecast (3-hourly)
      final forecastResponse = await _dio.get(
        '${ApiConstants.baseUrl}/forecast',
        queryParameters: baseParams,
      );

      if (forecastResponse.statusCode != 200) {
        throw Exception('Failed to load forecast: ${forecastResponse.statusCode}');
      }

      final List<dynamic> forecastList = forecastResponse.data['list'];

      // Group into daily summaries (take one representative per day ≈ every 8th item)
      final List<DailyForecastModel> dailyForecast = [];
      for (int i = 0; i < forecastList.length; i += 8) {
        if (dailyForecast.length >= 5) break;
        final dayJson = forecastList[i];
        dailyForecast.add(DailyForecastModel.fromJson(dayJson));
      }

      return WeatherResponse(
        current: currentWeather,
        dailyForecast: dailyForecast,
      );
    } on DioException catch (e) {
      String msg = 'Network error: ${e.message ?? 'No connection'}';
      if (e.response != null) {
        msg = 'API error: ${e.response?.statusCode} - ${e.response?.data['message'] ?? 'Unknown'}';
      }
      throw Exception(msg);
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  /// Search for matching cities using OpenWeather Geocoding API (for autocomplete)
  Future<List<CitySuggestion>> searchCities(String query) async {
    if (query.trim().length < 2) return [];

    try {
      final response = await _dio.get(
        'https://api.openweathermap.org/geo/1.0/direct',
        queryParameters: {
          'q': query.trim(),
          'limit': 8, // max suggestions to show
          'appid': ApiConstants.apiKey,
        },
      );

      if (response.statusCode != 200) {
        return [];
      }

      final List<dynamic> data = response.data;
      return data.map((json) => CitySuggestion.fromJson(json)).toList();
    } catch (e) {
      print('City search error: $e');
      return [];
    }
  }
}