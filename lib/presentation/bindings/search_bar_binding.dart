import 'package:get/get.dart';
import 'package:skyo_app_new/presentation/controllers/search_bar_controller.dart';

class SearchBarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomSearchBarController>(() => CustomSearchBarController());
  }
}