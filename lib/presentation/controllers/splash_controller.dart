import 'package:get/get.dart';

class SplashController extends GetxController {
  // Add future logic here (e.g. check onboarding, auth)
  void navigateToHome() {
    Get.offAllNamed('/home');
  }
}