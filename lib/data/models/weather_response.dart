import 'package:skyo_app_new/data/models/daily_forecast_model.dart';
import 'package:skyo_app_new/data/models/weather_model.dart';

class WeatherResponse {
  final WeatherModel current;
  final List<DailyForecastModel> dailyForecast; // 5 days

  WeatherResponse({
    required this.current,
    required this.dailyForecast,
  });
}