// lib/presentation/controllers/detail_forecast_controller.dart
import 'dart:ui';

import 'package:get/get.dart';
import 'package:skyo_app_new/data/models/detail_forecast_model.dart';
import 'package:skyo_app_new/core/utils/weather_utils.dart';

class DetailForecastController extends GetxController {
  final Rx<DetailForecastModel?> detail = Rx<DetailForecastModel?>(null);

  @override
  void onInit() {
    super.onInit();
    final arg = Get.arguments as DetailForecastModel?;
    if (arg != null) {
      detail.value = arg;
    } else {
      Get.back(); // or handle error
    }
  }

  String getConditionIcon() => WeatherUtils.getConditionIconPath(detail.value?.condition);
  Color getBackgroundColor() => WeatherUtils.getBackgroundColor(detail.value?.condition);
  Color getTextColor() => WeatherUtils.getTextColor(detail.value?.condition);
  Color getSecondaryTextColor() => WeatherUtils.getSecondaryTextColor(detail.value?.condition);

  // Optional helpers for UI formatting
  String getWindDisplay() {
    final speed = detail.value?.windSpeed ?? 0;
    final dir = detail.value?.windDirection ?? 'N/A';
    return '${speed.toStringAsFixed(1)} km/h $dir';
  }

  String getAqiLabel() {
    final aqi = detail.value?.airQuality ?? 0;
    if (aqi <= 50) return 'Good';
    if (aqi <= 100) return 'Moderate';
    if (aqi <= 150) return 'Unhealthy for Sensitive Groups';
    return 'Unhealthy';
  }
}