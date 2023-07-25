import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mgahawa_app/includes/colors.dart';
import 'package:mgahawa_app/screen/navigation/homePage.dart';
import 'package:mgahawa_app/screen/pages/onBoarding.dart';
import 'package:mgahawa_app/services/storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      checkFirstTimeUser().then((isFirstTime) {
        if (isFirstTime) {
          // First-time user, navigate to the Introduction page.
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => OnBoarding()),
          );
        } else {
          // Returning user, navigate to the Home page.
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => OnBoarding()),
          );
        }
      });
    });
  }

  Future<bool> checkFirstTimeUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstTime = prefs.getBool('isFirstTime') ?? true;

    // If it's the first time, save the flag in shared preferences.
    if (isFirstTime) {
      await prefs.setBool('isFirstTime', false);
    }

    return isFirstTime;
  }

  @override
  Widget build(BuildContext context) {
    double fullHeight = MediaQuery.of(context).size.height;
    double fullWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        width: fullWidth,
        height: fullHeight,
        color: AppColors.primaryColor,
        child: Column(
          children: [
            Expanded(
                child: Container(
                    child: Center(
              child: Text(
                "Logo Here",
                style: TextStyle(color: Colors.white),
              ),
            ))),
            Container(
              padding: EdgeInsets.only(bottom: 10),
              child: CircularProgressIndicator(
                strokeWidth: 1,
                color: AppColors.secondaryColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
