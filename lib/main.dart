import 'package:boba_time/constants/routes.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'constants/constants.dart';
import 'controllers/controllers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Register controllers
  final AuthController authController =
      Get.put<AuthController>(AuthController());
  Get.put<ThemeController>(ThemeController());
  Get.put<BobaYelpController>(BobaYelpController());
  Get.put<PositionController>(PositionController());

  // Initialize local storage
  await GetStorage.init();

  String initialRoute = '/auth';
  // Check if user is logged in
  if (await authController.getUser != null) {
    initialRoute = '/';
  }
  runApp(GetMaterialApp(
    // Register themes
    theme: AppThemes.lightTheme,
    darkTheme: AppThemes.darkTheme,
    themeMode: ThemeMode.system,
    initialRoute: initialRoute,
    getPages: AppRoutes.routes,
    debugShowCheckedModeBanner: false,
    navigatorObservers: [
      FirebaseAnalyticsObserver(analytics: FirebaseAnalytics()),
    ],
  ));
}
