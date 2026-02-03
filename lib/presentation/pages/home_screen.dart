import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart'; // ← add this import
import 'package:skyo_app_new/core/errors/error_view.dart';
import 'package:skyo_app_new/core/utils/weather_utils.dart';
import 'package:skyo_app_new/presentation/controllers/search_bar_controller.dart';
import '../controllers/home_controller.dart';
import '../widgets/custom_search_bar.dart';
import '../widgets/current_weather_section.dart';
import '../widgets/forecast_weather_section.dart';
import '../controllers/current_weather_controller.dart';
import '../controllers/forecast_controller.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final condition = controller.weatherResponse.value?.current.condition;
      final bgColor = WeatherUtils.getBackgroundColor(condition);
      final textColor = WeatherUtils.getTextColor(condition);
      final secondaryColor = WeatherUtils.getSecondaryTextColor(condition);

      final currentWeather = controller.weatherResponse.value?.current;
      final forecastDays =
          controller.weatherResponse.value?.dailyForecast ?? [];

      return Scaffold(
        backgroundColor: bgColor,
        body: RefreshIndicator(
          onRefresh: controller.refreshWeather,
          color: textColor,
          backgroundColor: bgColor.withOpacity(0.9),
          displacement: 40,
          child: Stack(
            children: [
              // Background
              Container(
                color: bgColor,
                width: double.infinity,
                height: double.infinity,
              ),

              SafeArea(
                child: Column(
                  children: [
                    // Search bar
                    GetBuilder<CustomSearchBarController>(
                      init: Get.put(CustomSearchBarController()),
                      builder: (_) => CustomSearchBar(
                        onSearch: controller.searchCity,
                        bgColor: bgColor,
                        textColor: textColor,
                        secondaryColor: secondaryColor,
                      ),
                    ),

                    Expanded(
                      child: controller.isLoading.value
                          ? Shimmer.fromColors(
                              baseColor: Color(0xff333333),
                              highlightColor: Color(0xff666666),
                              child: SingleChildScrollView(
                                physics: const AlwaysScrollableScrollPhysics(),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                  ),
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 30),

                                      // Temperature placeholder
                                      Container(
                                        height: 140,
                                        width: 200,

                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                          color: Colors.white,
                                        ),
                                      ),

                                      const SizedBox(height: 20),

                                      // Updated text placeholder
                                      Container(
                                        height: 20,
                                        width: 150,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                          color: Colors.white,
                                        ),
                                      ),

                                      const SizedBox(height: 20),

                                      // Location + icon placeholder
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            height: 30,
                                            width: 30,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: Colors.white,
                                            ),
                                          ),
                                          const SizedBox(width: 12),
                                          Container(
                                            height: 40,
                                            width: 180,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),

                                      const SizedBox(height: 16),

                                      // Description placeholder
                                      Container(
                                        height: 24,
                                        width: 140,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                          color: Colors.white,
                                        ),
                                      ),

                                      const SizedBox(height: 50),

                                      // Details row placeholder
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Column(
                                            children: [
                                              Container(
                                                height: 40,
                                                width: 80,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  color: Colors.white,
                                                ),
                                              ),
                                              const SizedBox(height: 8),
                                              Container(
                                                height: 20,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Container(
                                                height: 40,
                                                width: 80,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  color: Colors.white,
                                                ),
                                              ),
                                              const SizedBox(height: 8),
                                              Container(
                                                height: 20,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),

                                      const SizedBox(height: 40),

                                      // Big image placeholder
                                      Container(
                                        height: 300,
                                        width: 300,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(height: 40),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : controller.errorMessage.isNotEmpty
                          ? ErrorSection(
                              textColor: textColor,
                              secondaryColor: secondaryColor,
                            )
                          : currentWeather == null
                          ? Center(
                              child: Text(
                                'No weather data',
                                style: GoogleFonts.inter(
                                  color: textColor,
                                  fontSize: 20,
                                ),
                              ),
                            )
                          : SingleChildScrollView(
                              physics: const AlwaysScrollableScrollPhysics(),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                      24,
                                      8,
                                      24,
                                      8,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          DateFormat(
                                            'hh:mm a',
                                          ).format(DateTime.now()),
                                          style: GoogleFonts.inter(
                                            fontSize: 16,
                                            color: secondaryColor,
                                          ),
                                        ),
                                        // IconButton(
                                        //   icon: Icon(
                                        //     Icons.refresh_rounded,
                                        //     color: textColor,
                                        //     size: 28,
                                        //   ),
                                        //   onPressed: controller.isLoading.value
                                        //       ? null
                                        //       : controller.refreshWeather,
                                        // ),
                                      ],
                                    ),
                                  ),
                                  // Current weather section
                                  GetBuilder<CurrentWeatherController>(
                                    init: Get.put(
                                      CurrentWeatherController()
                                        ..updateFromWeather(currentWeather),
                                    ),
                                    builder: (_) => CurrentWeatherSection(
                                      textColor: textColor,
                                      secondaryColor: secondaryColor,
                                    ),
                                  ),

                                  // Forecast section
                                  GetBuilder<ForecastController>(
                                    init: Get.put(
                                      ForecastController()
                                        ..updateFromForecast(forecastDays),
                                    ),
                                    builder: (_) => ForecastSection(
                                      textColor: textColor,
                                      secondaryColor: secondaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
