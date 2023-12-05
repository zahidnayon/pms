import 'package:flutter/material.dart';
import 'package:pms/screen/splash_screen.dart';

class PmsApp extends StatelessWidget {
  const PmsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
