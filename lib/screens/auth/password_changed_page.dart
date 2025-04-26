import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app/routes/app_routes.dart';

const mainGreen = Color.fromRGBO(45, 55, 72, 1);

class PasswordChangedPage extends StatelessWidget {
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
                'Mot de passe modifié !',
                style: TextStyle(
                  fontSize: size.width * 0.055,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: size.height * 0.02),
              Text(
                'Votre mot de passe a été modifié avec succès !\nPassez à la connexion.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: size.width * 0.04,
                  color: mainGreen.withOpacity(
                    0.8,
                  ), // Use mainGreen instead of white
                ),
              ),
              SizedBox(height: size.height * 0.04),
              SizedBox(
                width: size.width * 0.6,
                height: size.height * 0.065,
                child: ElevatedButton(
                  onPressed: () {
                    Get.offAllNamed(
                      AppRoutes.login,
                    ); // Navigate to the login page
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Se connecter',
                    style: TextStyle(
                      fontSize: size.width * 0.045,
                      color: const Color.fromRGBO(103, 146, 148, 1),
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
}
