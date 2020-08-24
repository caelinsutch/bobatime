import 'package:boba_time/screens/auth.screen.dart';
import 'package:boba_time/screens/screens.dart';
import 'package:get/get.dart';

class AppRoutes {
  AppRoutes._(); //this is to prevent anyone from instantiating this object
  static final routes = [
    GetPage(name: '/', page: () => RootScreen()),
    GetPage(name: '/auth', page: () => AuthScreen())
  ];
}
