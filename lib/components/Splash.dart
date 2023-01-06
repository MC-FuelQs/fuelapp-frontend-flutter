// ignore: file_names
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'loginScreen.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

@override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Container(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          SizedBox(
            width: 300,            
            child: Image.asset('assets/fuel-gauge-png-fuel-1680.png')
            ),
          const SizedBox(
            child: Text(
              "Fuel App",
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ]),
      ),
      //'assets/fuel-gauge-png-fuel-1680.jpg',
      nextScreen: LoginScreen(),
      splashTransition: SplashTransition.fadeTransition,
      pageTransitionType: PageTransitionType.fade,
      backgroundColor: Colors.brown.shade300,
      duration: 3000,
      
    );
  }
}
