import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skyo_app_new/presentation/controllers/home_controller.dart';

class ErrorSection extends GetView<HomeController> {
  final Color textColor;
  final Color secondaryColor;
  const ErrorSection({super.key, required this.textColor, required this.secondaryColor});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Error: ${controller.errorMessage.value}',
              style: GoogleFonts.inter(color: textColor, fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: controller.refreshWeather,
              icon: Icon(Icons.refresh, color: textColor),
              label: Text('Retry', style: TextStyle(color: textColor)),
              style: ElevatedButton.styleFrom(
                backgroundColor: textColor.withOpacity(0.15),
                foregroundColor: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}