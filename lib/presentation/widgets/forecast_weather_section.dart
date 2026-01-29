import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skyo_app_new/core/utils/weather_utils.dart';
import 'package:skyo_app_new/data/models/detail_forecast_model.dart';
import 'package:skyo_app_new/presentation/controllers/forecast_controller.dart';
import 'package:skyo_app_new/presentation/pages/detail_forecast_screen.dart';
import 'package:skyo_app_new/presentation/widgets/weather_icon.dart';

class ForecastSection extends GetView<ForecastController> {
  final Color textColor;
  final Color secondaryColor;

  const ForecastSection({
    super.key,
    required this.textColor,
    required this.secondaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Next 5 Days',
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
            ),
            // const SizedBox(height: 12),
            SizedBox(
              height: 160,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: controller.days.length,
                itemBuilder: (context, index) {
                  final day = controller.days[index];
                  return Container(
                    width: 80, // wider card for better readability & touch
                    margin: const EdgeInsets.only(right: 12),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          day.dayName,
                          style: GoogleFonts.inter(
                            fontSize: 14, // slightly larger for visibility
                            fontWeight: FontWeight.w600,
                            color: textColor,
                          ),
                        ),
                        SizedBox(height: 8),
                        GestureDetector(
                          onTap: () {
                            final day = controller.days[index];

                            final detailData = DetailForecastModel(
                              dayName: day.dayName,
                              morningTemp:
                                  day.minTemp +
                                  3, // ← replace with real API values
                              afternoonTemp: day.maxTemp - 1,
                              eveningTemp: day.minTemp + 1,
                              nightTemp: day.minTemp - 2,
                              minTemp: day.minTemp,
                              maxTemp: day.maxTemp,
                              humidity: 70,
                              feelsLike: day.minTemp + 3,
                              condition: day.condition,
                              description: day.condition,
                              iconPath: day.iconPath,
                              windSpeed: 12.5,
                              windDirection: 'WSW',
                              pressure: 1013,
                              uvIndex: 6,
                              airQuality: 45,
                              visibility: 10.0,
                              sunrise: '06:15 AM',
                              sunset: '07:45 PM',
                              dewPoint: 18.0,
                              chanceOfRain: 20,
                            );

                            Get.toNamed(
                              '/detail_forecast',
                              arguments: detailData,
                            );
                          },
                          child: buildWeatherIcon(
                            day.condition,
                            // overrideSize: 28,
                          ),
                          // child: Image.asset(
                          //   day.iconPath,

                          //   width: WeatherUtils.getConditionIconSize(
                          //     day.condition,
                          //   ), // ← uses specific size from controller/utils
                          //   height: WeatherUtils.getConditionIconSize(
                          //     day.condition,
                          //   ),
                          //   fit: BoxFit.contain,
                          // ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '${day.minTemp.toStringAsFixed(0)}° / ${day.maxTemp.toStringAsFixed(0)}°',
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: textColor,
                          ),
                        ),
                        Text(
                          day.condition,
                          style: GoogleFonts.inter(
                            fontSize: 11,
                            color: secondaryColor,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
