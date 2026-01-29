// lib/presentation/bindings/detail_forecast_binding.dart
import 'package:get/get.dart';
import '../controllers/detail_forecast_controller.dart';

class DetailForecastBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailForecastController>(() => DetailForecastController());
  }
}