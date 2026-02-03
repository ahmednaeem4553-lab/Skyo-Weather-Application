// lib/presentation/controllers/current_weather_controller.dart
import 'dart:async';
import 'package:get/get.dart';
import 'package:skyo_app_new/data/models/current_weather_model.dart';
import 'package:skyo_app_new/data/models/weather_model.dart';

class CurrentWeatherController extends GetxController {
  final Rx<CurrentWeatherModel?> model = Rx<CurrentWeatherModel?>(null);

  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    _startTimer(); // start real-time update
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  void updateFromWeather(WeatherModel weather) {
    model.value = CurrentWeatherModel.fromWeather(weather);
    _restartTimer(); // restart timer on new data
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 60), (_) {
      update(); // force UI rebuild for updatedText & shouldBlink
    });
  }

  void _restartTimer() {
    _startTimer();
  }

  // Reactive "Updated X min ago" text
  String get updatedText {
    final m = model.value;
    if (m == null) return 'Updated just now';

    final diff = DateTime.now().difference(m.lastUpdated);
    final minutes = diff.inMinutes;

    if (minutes <= 0) return 'Updated just now';
    if (minutes == 1) return 'Updated 1 min ago';
    return 'Updated $minutes min ago';
  }

  // Reactive blink effect (alternates every minute)
  bool get shouldBlink {
    final m = model.value;
    if (m == null) return true;

    final diff = DateTime.now().difference(m.lastUpdated);
    return diff.inMinutes % 2 == 0;
  }
}