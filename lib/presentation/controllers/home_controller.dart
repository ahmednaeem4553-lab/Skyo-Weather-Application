import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';

import '../../data/models/weather_response.dart';
import '../../data/services/weather_services.dart';
import '../controllers/current_weather_controller.dart';
import '../controllers/forecast_controller.dart';

class HomeController extends GetxController {
  final WeatherService _weatherService = Get.find<WeatherService>();

  // Reactive state
  final Rx<WeatherResponse?> weatherResponse = Rx<WeatherResponse?>(null);
  final RxBool isLoading = true.obs;
  final RxString errorMessage = ''.obs;
  final RxString currentCity = ''.obs;
  final RxBool hasUserSearched = false.obs;
  final Rx<DateTime> lastUpdate = DateTime.now().obs;

  @override
  void onInit() {
    super.onInit();

    // Auto-sync weather data to section controllers whenever it changes
    ever(weatherResponse, (_) {
      final current = weatherResponse.value?.current;
      if (current != null) {
        Get.find<CurrentWeatherController>().updateFromWeather(current);
      }

      final forecast = weatherResponse.value?.dailyForecast ?? [];
      Get.find<ForecastController>().updateFromForecast(forecast);
    });

    _loadInitialWeather();
  }

  Future<void> _loadInitialWeather() async {
    if (hasUserSearched.value) return;

    isLoading.value = true;
    errorMessage.value = '';

    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        errorMessage.value = 'Location services disabled.';
        Get.snackbar('Info', errorMessage.value);
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          errorMessage.value = 'Location permission denied.';
          Get.snackbar('Permission', errorMessage.value);
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        errorMessage.value = 'Location permanently denied.';
        Get.snackbar('Permission', errorMessage.value);
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium,
      );

      final response = await _weatherService.getWeatherWithForecast(
        lat: position.latitude,
        lon: position.longitude,
      );

      weatherResponse.value = response;
      currentCity.value = 'Current Location';
      lastUpdate.value = DateTime.now();
    } catch (e) {
      errorMessage.value = 'Location error: ${e.toString().replaceFirst('Exception: ', '')}';
      Get.snackbar('Error', errorMessage.value);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchWeather(String city) async {
    if (city.trim().isEmpty) return;

    isLoading.value = true;
    errorMessage.value = '';

    try {
      final response = await _weatherService.getWeatherWithForecast(city: city);
      weatherResponse.value = response; // this triggers ever() listener
      currentCity.value = city.trim();
      hasUserSearched.value = true;
      lastUpdate.value = DateTime.now();
      print('Loaded weather for: ${currentCity.value}');
    } catch (e) {
      errorMessage.value = e.toString().replaceFirst('Exception: ', '');
      Get.snackbar('Error', errorMessage.value);
      weatherResponse.value = null;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshWeather() async {
    if (hasUserSearched.value) {
      await fetchWeather(currentCity.value);
    } else {
      await _loadInitialWeather();
    }
  }

  Future<void> searchCity(String city) async {
    if (city.trim().isEmpty) return;
    await fetchWeather(city.trim());
  }
}