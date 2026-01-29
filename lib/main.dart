import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skyo_app_new/core/constants/routes.dart';
import 'package:skyo_app_new/presentation/bindings/detail_forecast_binding.dart';
import 'package:skyo_app_new/presentation/bindings/home_binding.dart';
import 'package:skyo_app_new/presentation/controllers/home_controller.dart';
import 'package:skyo_app_new/presentation/pages/detail_forecast_screen.dart';
import 'package:skyo_app_new/presentation/pages/home_screen.dart';
import 'package:skyo_app_new/presentation/pages/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Skyo App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      initialRoute: Routes.home,
      getPages: [
        GetPage(
          name: '/home',
          page: () => const HomeScreen(),
          binding: HomeBinding(),
        ),
        GetPage(
          name: '/detail_forecast',
          page: () => const DetailForecastScreen(),
          binding: DetailForecastBinding(),
        ),
      ],
    );
  }
}
