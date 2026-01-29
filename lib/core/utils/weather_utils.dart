import 'package:flutter/material.dart';

class WeatherUtils {
  /// Returns a single solid background color based on weather condition
  static Color getBackgroundColor(String? condition) {
    if (condition == null) return Colors.yellow.shade700;

    final lower = condition.toLowerCase();

    switch (lower) {
      // Sunny / Clear
      case 'clear':
      case 'sunny':
        return const Color(0xFFF0ECC6); // soft warm peach

      // Cloudy / Overcast
      case 'clouds':
        return const Color(0xFFC6EEF0); // light cyan-blue

      // Rain / Drizzle / Thunderstorm
      case 'rain':
      case 'drizzle':
      case 'thunderstorm':
        return const Color(0xFF1628C5); // deep moody blue

      // Snow
      case 'snow':
        return const Color(0xFFE3F2FD); // very light blue-white

      // Fog / Mist / Haze
      case 'fog':
      case 'mist':
      case 'haze':
        return const Color(0xFFCFD8DC); // neutral grayish

      // Default fallback
      default:
        return const Color.fromARGB(255, 244, 98, 0);
    }
  }

  /// Primary text/icon color with good contrast on the background
  static Color getTextColor(String? condition) {
    if (condition == null) return Colors.white;

    final lower = condition.toLowerCase();

    // Dark backgrounds → white text
    if (lower.contains('rain') ||
        lower.contains('drizzle') ||
        lower.contains('thunderstorm')
        ) {
      return Colors.white.withOpacity(0.95);
    }

    // Light/warm backgrounds → dark text
    if (lower.contains('clear') ||
        lower.contains('sunny') ||
        lower.contains('snow') || lower.contains('clouds') ||
        lower.contains('fog') ||
        lower.contains('mist') ||
        lower.contains('haze')) {
      return Colors.black; // deep indigo/blackish for contrast
    }

    // Default fallback
    return Colors.white;
  }

  /// Secondary text color (labels, smaller info)
  static Color getSecondaryTextColor(String? condition) {
    return getTextColor(condition).withOpacity(0.75);
  }

  /// Returns path to your custom icon asset based on condition
  /// Replace the paths with your actual asset locations later
  static String getConditionIconPath(String? condition) {
    if (condition == null) return 'assets/icons/unknown.png';

    final lower = condition.toLowerCase();

    if (lower.contains('clear') || lower.contains('sunny')) {
      return 'assets/icons/Frame 1-2.png';
    }
    if (lower.contains('clouds')) {
      return 'assets/icons/Frame 1-1.png';
    }
    if (lower.contains('rain') || lower.contains('drizzle')) {
      return 'assets/icons/Rainy.png';
    }
    if (lower.contains('thunderstorm')) {
      return 'assets/icons/Storm.png';
    }
    if (lower.contains('snow')) {
      return 'assets/icons/Snow.png';
    }
    if (lower.contains('fog') || lower.contains('mist') || lower.contains('haze')) {
      return 'assets/icons/Frame 1-6.png';
    }

    // Fallback
    return 'assets/icons/unknown.png';
  }

  /// Returns specific icon size based on condition
  static double getConditionIconSize(String? condition) {
    if (condition == null) return 60.0;

    final lower = condition.toLowerCase();

    if (lower.contains('clear') || lower.contains('sunny')) {
      return 35.0; // bigger for sunny
    }
    if (lower.contains('rain') || lower.contains('thunderstorm')) {
      return 35.0; // smaller for rain
    }
    if (lower.contains('snow')) {
      return 35.0;
    }
    if (lower.contains('clouds')) {
      return 35.0;
    }

    return 35.0; // default
  }
}