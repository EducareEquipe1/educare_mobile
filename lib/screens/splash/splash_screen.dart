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
  late Animation<double> _bounceAnimation;
  late Animation<double> _gradientAnimation;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    // Initialize the animation controller
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    // Define bounce animation
    _bounceAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(
          begin: 0.5,
          end: 1.2,
        ).chain(CurveTween(curve: Curves.easeOut)),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: Tween(
          begin: 1.2,
          end: 0.9,
        ).chain(CurveTween(curve: Curves.easeIn)),
        weight: 30,
      ),
      TweenSequenceItem(
        tween: Tween(
          begin: 0.9,
          end: 1.0,
        ).chain(CurveTween(curve: Curves.easeOut)),
        weight: 20,
      ),
    ]).animate(_controller);

    // Define gradient animation (0.0 to 1.0 for blending)
    _gradientAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    // Start the animation
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
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Scaffold(
          body: Container(
            decoration: BoxDecoration(
              gradient:
                  _gradientAnimation.value < 1.0
                      ? LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color.lerp(
                            const Color.fromRGBO(
                              103,
                              146,
                              148,
                              1,
                            ), // Start as green
                            const Color.fromRGBO(
                              103,
                              146,
                              148,
                              1,
                            ), // Transition to gradient
                            _gradientAnimation.value,
                          )!,
                          Color.lerp(
                            const Color.fromRGBO(
                              103,
                              146,
                              148,
                              1,
                            ), // Start as green
                            Colors.white, // Transition to white
                            _gradientAnimation.value,
                          )!,
                        ],
                      )
                      : LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          const Color.fromRGBO(
                            103,
                            146,
                            148,
                            1,
                          ), // Lighter shade at the bottom
                          Colors.white, // White at the top
                        ],
                      ),
            ),
            child: Center(
              child: Transform.scale(
                scale: _bounceAnimation.value,
                child: Image.asset(
                  'assets/images/white_logo.png', // Ensure this path is correct
                  height: 150,
                  width: 150,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
