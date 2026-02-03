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
          backgroundColor: bgColor.withOpacity(0.2),
          elevation: 0,
          iconTheme: IconThemeData(color: textColor),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header: Main temp + condition + icon
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Min Temp: ${model.maxTemp.toStringAsFixed(0)}°\nMax Temp: ${model.minTemp.toStringAsFixed(0)}°',
                          style: GoogleFonts.inter(
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                            color: textColor,
                          ),
                        ),
                        Text(
                          model.condition.toUpperCase(),
                          style: GoogleFonts.inter(
                            fontSize: 18,
                            color: secondaryColor,
                          ),
                        ),
                      ],
                    ),
                    buildWeatherIcon(model.condition, overrideSize: 60),
                  ],
                ),
                const SizedBox(height: 32),

                // Card 1: Temperature Breakdown
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  color: bgColor,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Temperature Breakdown',
                          style: GoogleFonts.inter(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: textColor,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _TempTile(
                              'Morning',
                              model.morningTemp,
                              textColor,
                              secondaryColor,
                            ),
                            _TempTile(
                              'Afternoon',
                              model.afternoonTemp,
                              textColor,
                              secondaryColor,
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _TempTile(
                              'Evening',
                              model.eveningTemp,
                              textColor,
                              secondaryColor,
                            ),
                            _TempTile(
                              'Night',
                              model.nightTemp,
                              textColor,
                              secondaryColor,
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _TempTile(
                              'Min',
                              model.minTemp,
                              textColor,
                              secondaryColor,
                            ),
                            _TempTile(
                              'Max',
                              model.maxTemp,
                              textColor,
                              secondaryColor,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Card 2: Other Weather Details
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  color: bgColor,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Weather Details',
                          style: GoogleFonts.inter(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: textColor,
                          ),
                        ),
                        const SizedBox(height: 16),
                        GridView.count(
                          padding: EdgeInsets.zero,
                          crossAxisCount: 2,
                          childAspectRatio: 1.8,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisSpacing: 0,
                          mainAxisSpacing: 0,
                          children: [
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
                            _DetailTile(
                              'Wind',
                              '${model.windSpeed.toStringAsFixed(1)} km/h',
                              textColor,
                              secondaryColor,
                            ),
                            _DetailTile(
                              'Pressure',
                              '${model.pressure} hPa',
                              textColor,
                              secondaryColor,
                            ),
                            _DetailTile(
                              'Visibility',
                              '${model.visibility.toStringAsFixed(1)} km',
                              textColor,
                              secondaryColor,
                            ),
                            _DetailTile(
                              'UV Index',
                              model.uvIndex.toString(),
                              textColor,
                              secondaryColor,
                            ),
                            _DetailTile(
                              'Air Quality',
                              '${model.airQuality} AQI',
                              textColor,
                              secondaryColor,
                            ),
                            _DetailTile(
                              'Chance of Rain',
                              '${model.chanceOfRain}%',
                              textColor,
                              secondaryColor,
                            ),
                            _DetailTile(
                              'Dew Point',
                              '${model.dewPoint.toStringAsFixed(0)}°',
                              textColor,
                              secondaryColor,
                            ),
                            _DetailTile(
                              'Sunrise',
                              model.sunrise,
                              textColor,
                              secondaryColor,
                            ),
                            _DetailTile(
                              'Sunset',
                              model.sunset,
                              textColor,
                              secondaryColor,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _TempTile(String label, double temp, Color primary, Color secondary) {
    return Column(
      children: [
        Text(
          '${temp.toStringAsFixed(0)}°',
          style: GoogleFonts.inter(
            fontSize: 32,
            fontWeight: FontWeight.w500,
            color: primary,
          ),
        ),
        Text(label, style: GoogleFonts.inter(fontSize: 14, color: secondary)),
      ],
    );
  }

  Widget _DetailTile(
    String label,
    String value,
    Color primary,
    Color secondary,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: GoogleFonts.inter(
            fontSize: 24,
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
