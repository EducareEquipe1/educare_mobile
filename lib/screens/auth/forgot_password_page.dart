import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../app/routes/app_routes.dart';

const mainGreen = Color.fromRGBO(45, 55, 72, 1);

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();
  bool _isLoading = false;
  String _message = '';

  Future<void> _sendResetLink() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
      _message = '';
    });

    try {
      final response = await http.post(
        Uri.parse(
          'https://educare-backend-l6ue.onrender.com/patients/forgot-password',
        ),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': _emailController.text}),
      );

      if (response.statusCode == 200) {
        // Navigate to email sent page with email argument
        Get.toNamed(
          AppRoutes.emailSent,
          arguments: {'email': _emailController.text},
        );
      } else {
        final data = jsonDecode(response.body);
        setState(() {
          _message =
              data['error'] ?? 'Error sending reset link. Please try again.';
        });
      }
    } catch (e) {
      setState(() {
        _message = 'Network error. Please try again later.';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

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
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.08,
              vertical: size.height * 0.04,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: size.height * 0.08),
                Image.asset(
                  'assets/images/white_logo.png',
                  height: size.height * 0.08,
                ),
                SizedBox(height: size.height * 0.04),
                Text(
                  'Mot de passe oublié',
                  style: TextStyle(
                    fontSize: size.width * 0.055,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                Text(
                  'Entrez votre adresse e-mail et nous vous enverrons\nun lien pour réinitialiser votre mot de passe.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: size.width * 0.04,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
                SizedBox(height: size.height * 0.04),
                TextFormField(
                  controller: _emailController,
                  style: const TextStyle(color: mainGreen),
                  decoration: InputDecoration(
                    hintText: 'Email',
                    hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
                    prefixIcon: Icon(Icons.email),
                    prefixIconColor: Colors.white.withOpacity(0.7),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.1),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Colors.white.withOpacity(0.3),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: mainGreen, width: 2),
                    ),
                  ),
                ),
                if (_message.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.only(top: size.height * 0.02),
                    child: Text(
                      _message,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: size.width * 0.035,
                      ),
                    ),
                  ),
                SizedBox(height: size.height * 0.04),
                SizedBox(
                  width: double.infinity,
                  height: size.height * 0.065,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _sendResetLink,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child:
                        _isLoading
                            ? const CircularProgressIndicator()
                            : Text(
                              'Envoyer',
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

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
}
