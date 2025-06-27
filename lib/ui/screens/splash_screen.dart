import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:recipe_book/ui/screens/login_screen.dart';
import 'main_recipe_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: const CircleAvatar(
        radius: 70,
        backgroundColor: Colors.blue,
        child: CircleAvatar(
          backgroundImage: AssetImage('images/food_logo.png'),
          radius: 40,
        ),
      ),
      nextScreen: const LoginPage(),
      splashTransition: SplashTransition.rotationTransition,
      backgroundColor: Color.fromRGBO(27, 56, 74, 1),
    );
  }
}
