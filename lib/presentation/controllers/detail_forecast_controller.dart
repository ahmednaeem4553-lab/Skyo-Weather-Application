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
    final arg =
        Get.arguments as DetailForecastModel?; // ← expects DetailForecastModel
    if (arg != null) {
      detail.value = arg;
    } else {
      Get.back();
    }
  }

  // RxBool isbool = false.obs;
  String getConditionIcon() =>
      WeatherUtils.getConditionIconPath(detail.value?.condition);
  Color getBackgroundColor() =>
      WeatherUtils.getBackgroundColor(detail.value?.condition);
  Color getTextColor() => WeatherUtils.getTextColor(detail.value?.condition);
  Color getSecondaryTextColor() =>
      WeatherUtils.getSecondaryTextColor(detail.value?.condition);
}
