// lib/presentation/screens/detail_forecast_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skyo_app_new/presentation/controllers/detail_forecast_controller.dart';
import 'package:skyo_app_new/presentation/widgets/weather_icon.dart';

class DetailForecastScreen extends GetView<DetailForecastController> {
  const DetailForecastScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final model = controller.detail.value;
      if (model == null)
        return const Scaffold(body: Center(child: Text('No data')));

      final bgColor = controller.getBackgroundColor();
      final textColor = controller.getTextColor();
      final secondaryColor = controller.getSecondaryTextColor();

      return Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          title: Text(
            model.dayName,
            style: GoogleFonts.inter(color: textColor),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: textColor),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            // padding: const EdgeInsets.all(24),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${model.maxTemp.toStringAsFixed(0)}° / ${model.minTemp.toStringAsFixed(0)}°',
                        style: GoogleFonts.inter(
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                          color: textColor,
                        ),
                      ),
                      buildWeatherIcon(model.condition, overrideSize: 70),
                      // Image.asset(
                      //   controller.getConditionIcon(),
                      //   width: 40,
                      //   height: 40,
                      // ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    model.condition.toUpperCase(),
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      color: secondaryColor,
                    ),
                  ),
                  const SizedBox(height: 8),

                  const SizedBox(height: 40),
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 24,
                    children: [
                      _DetailTile(
                        'Morning',
                        '${model.morningTemp.toStringAsFixed(0)}°',
                        textColor,
                        secondaryColor,
                      ),
                      _DetailTile(
                        'Afternoon',
                        '${model.afternoonTemp.toStringAsFixed(0)}°',
                        textColor,
                        secondaryColor,
                      ),
                      _DetailTile(
                        'Evening',
                        '${model.eveningTemp.toStringAsFixed(0)}°',
                        textColor,
                        secondaryColor,
                      ),
                      _DetailTile(
                        'Night',
                        '${model.nightTemp.toStringAsFixed(0)}°',
                        textColor,
                        secondaryColor,
                      ),
                      _DetailTile(
                        'Feels Like',
                        '${model.feelsLike.toStringAsFixed(0)}°',
                        textColor,
                        secondaryColor,
                      ),
                      _DetailTile(
                        'Humidity',
                        '${model.humidity}%',
                        textColor,
                        secondaryColor,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _DetailTile(
    String label,
    String value,
    Color primary,
    Color secondary,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: GoogleFonts.inter(
            fontSize: 28,
            fontWeight: FontWeight.w500,
            color: primary,
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: GoogleFonts.inter(fontSize: 14, color: secondary)),
      ],
    );
  }
}
