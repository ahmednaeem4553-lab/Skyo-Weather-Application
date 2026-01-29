// lib/presentation/controllers/custom_search_bar_controller.dart
import 'dart:async';
import 'package:get/get.dart';
import 'package:skyo_app_new/data/services/weather_services.dart';

class CustomSearchBarController extends GetxController {
  final WeatherService _weatherService = Get.find<WeatherService>();

  // Reactive state
  final RxList<CitySuggestion> suggestions = <CitySuggestion>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool isExpanded = false.obs;
  final RxString currentQuery = ''.obs;

  Timer? _debounce;

  /// Called on every keystroke in search field
  void onQueryChanged(String value) {
    currentQuery.value = value.trim();

    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 400), () {
      _fetchSuggestions(currentQuery.value);
    });
  }
  /// Fetch real city suggestions from API
  Future<void> _fetchSuggestions(String query) async {
    if (query.length < 2) {
      suggestions.clear();
      return;
    }

    isLoading.value = true;
    try {
      final results = await _weatherService.searchCities(query);
      suggestions.assignAll(results);
    } catch (e) {
      suggestions.clear();
      print('Search error: $e'); // for debugging
    } finally {
      isLoading.value = false;
    }
  }

  /// Clear search and collapse bar
  void clear() {
    currentQuery.value = '';
    suggestions.clear();
    isExpanded.value = false;
  }

  /// Expand suggestions area
  void expand() => isExpanded.value = true;

  /// Collapse suggestions area
  void collapse() => isExpanded.value = false;

  @override
  void onClose() {
    _debounce?.cancel();
    super.onClose();
  }
}