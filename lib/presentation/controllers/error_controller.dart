// lib/presentation/controllers/error_controller.dart
import 'package:get/get.dart';
import 'package:skyo_app_new/data/models/error_model.dart';

class ErrorController extends GetxController {
  final Rx<ErrorModel?> error = Rx<ErrorModel?>(null);

  void showError(String message) {
    error.value = ErrorModel(message: message);
  }

  void clear() {
    error.value = null;
  }
}