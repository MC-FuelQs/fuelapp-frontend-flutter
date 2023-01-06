import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fuel_app/components/Splash.dart';
import 'package:fuel_app/components/loginScreen.dart';
import 'package:fuel_app/components/mySheds.dart';
import 'package:fuel_app/components/registerScreen.dart';
import 'package:fuel_app/components/homePage.dart';

Future<void> main() async {
  await dotenv.load();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splash(),
    );
  }
}
