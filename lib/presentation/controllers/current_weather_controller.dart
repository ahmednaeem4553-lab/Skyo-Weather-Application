// lib/presentation/controllers/current_weather_controller.dart
import 'package:get/get.dart';
import 'package:skyo_app_new/data/models/current_weather_model.dart';
import 'package:skyo_app_new/data/models/weather_model.dart';

class CurrentWeatherController extends GetxController {
  final Rx<CurrentWeatherModel?> model = Rx<CurrentWeatherModel?>(null);

  void updateFromWeather(WeatherModel weather) {
    model.value = CurrentWeatherModel.fromWeather(weather);
  }

  // Reactive getter for "Updated X min ago" text
  String get updatedText {
    final m = model.value;
    if (m == null) return 'Updated just now';

    final diff = DateTime.now().difference(m.lastUpdated);
    final minutes = diff.inMinutes;

    if (minutes == 0) return 'Updated just now';
    if (minutes == 1) return 'Updated 1 min ago';
    return 'Updated $minutes min ago';
  }

  // Reactive getter for blink effect (true = full opacity, false = faded)
  bool get shouldBlink {
    final m = model.value;
    if (m == null) return true;

    final diff = DateTime.now().difference(m.lastUpdated);
    return diff.inMinutes % 2 == 0; // alternate every minute
  }
}
