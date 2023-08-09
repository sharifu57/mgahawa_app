import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mgahawa_app/includes/colors.dart';
import 'package:mgahawa_app/screen/pages/routes.dart';
import 'package:mgahawa_app/screen/utilities/splash.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter ',
        debugShowCheckedModeBanner: false,
        routes: route,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
          useMaterial3: true,
          inputDecorationTheme: InputDecorationTheme(
            hintStyle: TextStyle(
              color: Colors.white, // Set the desired color here
            ),
          ),
        ),
        home: SplashScreen());
  }
}
