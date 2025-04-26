import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../app/routes/app_routes.dart';

class CheckEmailPage extends StatefulWidget {
  @override
  State<CheckEmailPage> createState() => _CheckEmailPageState();
}

class _CheckEmailPageState extends State<CheckEmailPage> {
  late String userEmail;
  bool _isChecking = false;
  bool _isVerified = false;

  Timer? _verificationCheckTimer;

  @override
  void initState() {
    super.initState();
    final args = Get.arguments as Map<String, dynamic>?;
    userEmail = args?['email'] ?? '';

    // Start polling to check if the account is verified
    _startVerificationCheck();
  }

  void _startVerificationCheck() {
    _verificationCheckTimer = Timer.periodic(const Duration(seconds: 10), (_) {
      _checkVerificationStatus();
    });
  }

  Future<void> _checkVerificationStatus() async {
    try {
      final response = await http.get(
        Uri.parse(
          'https://educare-backend-l6ue.onrender.com/patients/check-verification?email=$userEmail',
        ),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['verified'] == true) {
          // User is verified, navigate to home page
          Get.offAllNamed(AppRoutes.home);
        } else {
          // User is not verified, stay on verification page
          setState(() {
            _isVerified = false;
          });
        }
      }
    } catch (e) {
      print('Error checking verification status: $e');
    }
  }

  Future<void> _resendVerificationEmail() async {
    if (_isChecking) return;

    setState(() {
      _isChecking = true;
    });

    try {
      final response = await http.post(
        Uri.parse(
          'https://educare-backend-l6ue.onrender.com/patients/send-email-verification',
        ),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': userEmail}),
      );

      if (response.statusCode == 200) {
        Get.snackbar(
          'E-mail envoyé',
          'Un nouvel e-mail de vérification a été envoyé à votre adresse.',
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        Get.snackbar(
          'Erreur',
          'Impossible d\'envoyer l\'e-mail de vérification.',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Erreur',
        'Une erreur s\'est produite lors de l\'envoi de l\'e-mail.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      setState(() {
        _isChecking = false;
      });
    }
  }

  @override
  void dispose() {
    _verificationCheckTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async => false, // Prevent back navigation
      child: Scaffold(
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
                  'Vérifiez votre E-mail !',
                  style: TextStyle(
                    fontSize: size.width * 0.055,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                Text(
                  'Nous venons d\'envoyer un e-mail à\n$userEmail\nCliquez sur le lien dans l\'e-mail pour vérifier votre compte.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: size.width * 0.04,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: size.height * 0.04),
                if (_isVerified)
                  SizedBox(
                    width: size.width * 0.6,
                    height: size.height * 0.065,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.offAllNamed(
                          AppRoutes.home,
                        ); // Navigate to the homepage
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        'Aller à la page d\'accueil',
                        style: TextStyle(
                          fontSize: size.width * 0.045,
                          color: const Color.fromRGBO(103, 146, 148, 1),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  )
                else if (_isChecking)
                  const CircularProgressIndicator(color: Colors.white)
                else
                  SizedBox(
                    width: size.width * 0.6,
                    height: size.height * 0.065,
                    child: ElevatedButton(
                      onPressed: _resendVerificationEmail,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        'Renvoyer l\'e-mail',
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
      ),
    );
  }
}
