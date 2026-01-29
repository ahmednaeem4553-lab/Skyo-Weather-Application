import 'package:get/get.dart';
import 'package:skyo_app_new/data/services/location_services.dart';
import 'package:skyo_app_new/presentation/controllers/current_weather_controller.dart';
import 'package:skyo_app_new/presentation/controllers/forecast_controller.dart';
import 'package:skyo_app_new/presentation/controllers/weather_icon_controller.dart';
import '../../data/services/weather_services.dart';
import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WeatherService>(() => WeatherService(),);
    Get.lazyPut<LocationService>(() => LocationService());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<CurrentWeatherController>(() => CurrentWeatherController());
    Get.lazyPut<ForecastController>(() => ForecastController());
    Get.lazyPut<WeatherIconController>(() => WeatherIconController());
  }
}
