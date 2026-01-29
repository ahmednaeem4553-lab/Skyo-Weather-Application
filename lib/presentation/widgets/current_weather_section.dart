import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skyo_app_new/presentation/controllers/current_weather_controller.dart';

class CurrentWeatherSection extends GetView<CurrentWeatherController> {
  final Color textColor;
  final Color secondaryColor;

  const CurrentWeatherSection({
    super.key,
    required this.textColor,
    required this.secondaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final model = controller.model.value;
      if (model == null) return const SizedBox.shrink();

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const SizedBox(height: 30),

            // Temperature – prominent
            Text(
              '${model.temperature.toStringAsFixed(0)}°',
              style: GoogleFonts.inter(
                fontSize: 140,
                fontWeight: FontWeight.w200,
                color: textColor,
                height: 0.9,
              ),
            ),

            const SizedBox(height: 4),

            // Blinking "Updated ago" text
            AnimatedOpacity(
              opacity: controller.shouldBlink ? 1.0 : 0.5,
              duration: const Duration(milliseconds: 800),
              child: Text(
                controller.updatedText,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: secondaryColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Location
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.location_on_rounded, color: textColor, size: 28),
                const SizedBox(width: 8),
                Text(
                  model.cityName,
                  style: GoogleFonts.inter(
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                    color: textColor,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Description
            Text(
              model.description.toUpperCase(),
              style: GoogleFonts.inter(
                fontSize: 20,
                color: secondaryColor,
                letterSpacing: 1.2,
              ),
            ),

            const SizedBox(height: 50),

            // Details row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _DetailItem(
                  label: 'Feels like',
                  value: '${model.feelsLike.toStringAsFixed(0)}°',
                  primary: textColor,
                  secondary: secondaryColor,
                ),
                _DetailItem(
                  label: 'Humidity',
                  value: '${model.humidity}%',
                  primary: textColor,
                  secondary: secondaryColor,
                ),
              ],
            ),

            const SizedBox(height: 30),

            // Custom image
            Image.asset('assets/icons/Group 1.png', width: 300),

            const SizedBox(height: 30),
          ],
        ),
      );
    });
  }
}

class _DetailItem extends StatelessWidget {
  final String label;
  final String value;
  final Color primary;
  final Color secondary;

  const _DetailItem({
    super.key,
    required this.label,
    required this.value,
    required this.primary,
    required this.secondary,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.inter(
            fontSize: 26,
            fontWeight: FontWeight.w500,
            color: primary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: GoogleFonts.inter(fontSize: 14, color: secondary),
        ),
      ],
    );
  }
}