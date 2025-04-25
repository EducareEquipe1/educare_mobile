import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import '../../screens/greeting/greeting_page.dart'; // Ensure this import is correct

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  Animation<double>? _animation;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    // Initialize the animation controller
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    );

    // Define a scaling animation
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);

    // Start the animation
    _controller.addListener(() {
      print('Animation value: \${_controller.value}');
      setState(() {});
    });
    _controller.forward();

    // Navigate to the GreetingPage after the animation completes
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const GreetingPage()),
      );
    });
  }

  @override
  void dispose() {
    // Dispose of the animation controller
    _controller.dispose();

    // Restore system UI overlays when the splash screen is disposed
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color.fromARGB(255, 103, 146, 148), Colors.white],
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
          ),
        ),
        child: ScaleTransition(
          scale: _animation ?? AlwaysStoppedAnimation(1.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/white_logo.png', // Ensure this path is correct
                height: 150,
                width: 150,
                fit: BoxFit.contain,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
