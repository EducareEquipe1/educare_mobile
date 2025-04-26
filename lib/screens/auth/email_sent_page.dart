import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app/routes/app_routes.dart';

const mainGreen = Color.fromRGBO(45, 55, 72, 1);

class EmailSentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/auth_bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/white_logo.png',
                height: size.height * 0.08,
              ),
              SizedBox(height: size.height * 0.04),
              Text(
                'E-mail envoyé !',
                style: TextStyle(
                  fontSize: size.width * 0.055,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: size.height * 0.02),
              Text(
                'Nous avons envoyé un e-mail à\nu.example@esi-sba.dz !\nCliquez sur le lien dans l’e-mail pour réinitialiser votre compte.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: size.width * 0.04, color: mainGreen),
              ),
              SizedBox(height: size.height * 0.04),
              SizedBox(
                width: size.width * 0.6,
                height: size.height * 0.065,
                child: ElevatedButton(
                  onPressed: () {
                    // Retry sending the email
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Réessayer',
                    style: TextStyle(
                      fontSize: size.width * 0.045,
                      color: const Color.fromRGBO(103, 146, 148, 1),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.02),
              SizedBox(
                width: size.width * 0.6,
                height: size.height * 0.065,
                child: ElevatedButton(
                  onPressed: () {
                    Get.offAllNamed(AppRoutes.login); // Navigate back to login
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: mainGreen,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Retour à la connexion',
                    style: TextStyle(
                      fontSize: size.width * 0.045,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _sendResetLink() {
    // Simulate sending a reset link
    Get.toNamed(AppRoutes.emailSent); // Navigate to the email sent page
  }
}
