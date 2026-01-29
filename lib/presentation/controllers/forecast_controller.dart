// lib/presentation/controllers/forecast_controller.dart
import 'package:get/get.dart';
import 'package:skyo_app_new/core/utils/weather_utils.dart';
import 'package:skyo_app_new/data/models/daily_forecast_model.dart';
import 'package:skyo_app_new/data/models/forecast_model.dart';

class ForecastController extends GetxController {
  // Reactive list of forecast days
  final RxList<ForecastDayModel> days = <ForecastDayModel>[].obs;

  /// Update forecast data from API response
  void updateFromForecast(List<DailyForecastModel> forecast) {
    if (forecast.isEmpty) {
      days.clear();
      return;
    }

    days.assignAll(
      forecast.map((day) => ForecastDayModel(
            dayName: _getDayName(day.date),
            minTemp: day.minTemp,
            maxTemp: day.maxTemp,
            condition: day.condition,
            iconPath: WeatherUtils.getConditionIconPath(day.condition),
            iconSize: WeatherUtils.getConditionIconSize(day.condition), // ← size from utils
          )).toList(),
    );
  }

  /// Helper to get short day name (Sun, Mon, etc.)
  String _getDayName(DateTime date) {
    const daysOfWeek = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    return daysOfWeek[date.weekday % 7];
  }

}