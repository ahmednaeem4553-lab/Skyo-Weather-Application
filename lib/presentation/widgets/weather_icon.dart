// lib/presentation/widgets/weather_icon.dart
import 'package:flutter/material.dart';
import 'package:skyo_app_new/core/utils/weather_utils.dart';

// class WeatherIcon {
//   final String? condition;
//   final double? overrideSize;

//   const WeatherIcon({

//     required this.condition,
//     this.overrideSize,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {

//     });
//   }
// }

Widget buildWeatherIcon(String? condition, {double? overrideSize}) {
  final size = overrideSize ?? WeatherUtils.getConditionIconSize(condition);
  final path = WeatherUtils.getConditionIconPath(condition);
  return Image.asset(
    path,
    width: size,
    height: size,
    fit: BoxFit.contain,
    errorBuilder: (context, error, stackTrace) => Icon(
      Icons.error_outline_rounded,
      size: size * 0.6,
      color: Colors.redAccent,
    ),
  );
}
