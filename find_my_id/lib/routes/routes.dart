import 'package:find_my_id/major_tabs/home_notifications_profile.dart';
import 'package:find_my_id/major_tabs/report_found_page.dart';
import 'package:find_my_id/major_tabs/report_lost_page.dart';
import 'package:find_my_id/major_tabs/search_page.dart';
import 'package:find_my_id/major_tabs/splash.dart';
import 'package:flutter/material.dart';

class RouteManager {
  static const String splash = "/";
  static const String home = "/home";
  static const String snap = "/snap";
  static const String logIn = "/login";
  static const String signUp = "/signup";
  static const String confirmPopup = '/confirmPopup';
  static const String reportLost = '/reportLost';
  static const String reportFound = '/reportFound';
  static const String searchPage = '/searchPage';


  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (context) => Splash());
      case home:
        return MaterialPageRoute(
            builder: (context) => HomeNotificationsProfile());
      case reportLost:
        return MaterialPageRoute(
            builder: (context) => ReportLostPage());
      case reportFound:
        return MaterialPageRoute(
            builder: (context) => ReportFoundPage());
      case searchPage:
        return MaterialPageRoute(
            builder: (context) => SearchPage());
      default:
        throw FormatException("Route does not exist");
    }
  }
}
