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
