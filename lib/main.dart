import 'package:flutter/material.dart';
import 'package:foodshelf/screens/auth/login.dart';
import 'package:foodshelf/utility/brand_colors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          accentColor: BrandColors.colorAccent,
          cursorColor: BrandColors.colorAccent,
          focusColor: BrandColors.colorAccent,
          primaryColor: BrandColors.colorAccent),
      title: 'Food Shelf',
      home: LoginPage(),
    );
  }
}
