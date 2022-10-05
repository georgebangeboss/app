import 'package:find_my_id/decor/palette.dart';
import 'package:find_my_id/decor/text_styles.dart';
import 'package:find_my_id/routes/routes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      initialRoute: RouteManager.splash,
      onGenerateRoute: RouteManager.generateRoute,
      theme: ThemeData(
        textTheme: TextTheme(
          bodyMedium: genTxt,
        ),
        primarySwatch: Colors.blue,
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            padding: EdgeInsets.all(8.0),
            foregroundColor: Colors.white60,
            backgroundColor: colorPrimaryVariant,
            elevation: 3.0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: colorWhiteBackground,
          foregroundColor: colorPrimary,
        ),
        scaffoldBackgroundColor: colorBackground,
      ),
      navigatorKey: GlobalKey<NavigatorState>(),
      scaffoldMessengerKey: GlobalKey<ScaffoldMessengerState>(),
    );
  }
}
