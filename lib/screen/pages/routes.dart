import 'package:flutter/material.dart';
import 'package:mgahawa_app/screen/navigation/screen.dart';
import 'package:mgahawa_app/screen/pages/category/view_category.dart';
import 'package:mgahawa_app/screen/pages/onBoarding.dart';
import 'package:mgahawa_app/screen/utilities/splash.dart';

final route = {
  '/splash': (BuildContext context) => SplashScreen(),
  '/screen': (BuildContext context) => Screen(),
};
