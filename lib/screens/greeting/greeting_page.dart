import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app/routes/app_routes.dart';

const mainGreen = Color.fromRGBO(45, 55, 72, 1);

class GreetingPage extends StatelessWidget {
  const GreetingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final imageHeight = size.height * 0.3;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(103, 146, 148, 1), // Lighter shade at the bottom
              Colors.white, // White at the top
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.08,
              vertical: size.height * 0.04,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: size.height * 0.05),
                Image.asset(
                  'assets/images/greeting.png',
                  height: imageHeight,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: size.height * 0.05),
                Text(
                  'Votre santé, toujours à\nportée de main',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: size.width * 0.06,
                    fontWeight: FontWeight.bold,
                    color:  mainGreen // #679294
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                Text(
                  'Accédez facilement à votre dossier médical et à vos rendez-vous depuis votre mobile.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: size.width * 0.04,
                    color: const Color.fromRGBO(
                      46,
                      61,
                      64,
                      0.58,
                    ), // #2E3D40 with 58% opacity
                  ),
                ),
                SizedBox(height: size.height * 0.05),
                SizedBox(
                  width: double.infinity,
                  height: size.height * 0.07,
                  child: ElevatedButton(
                    onPressed: () => Get.toNamed(AppRoutes.login),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: mainGreen,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      "C'est parti !",
                      style: TextStyle(
                        fontSize: size.width * 0.045,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.02),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
