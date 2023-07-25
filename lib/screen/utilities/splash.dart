import 'package:flutter/material.dart';
import 'package:mgahawa_app/includes/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    double fullHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: fullHeight,
        color: AppColors.primaryColor,
      ),
    );
  }
}
