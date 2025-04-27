import 'package:educare/controllers/user_controller.dart';
import 'package:educare/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../app/routes/app_routes.dart';

const mainGreen = Color.fromRGBO(45, 55, 72, 1);

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isPasswordVisible = false;
  bool _isLoading = false;
  String _message = '';
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _handleLogin() async {
    setState(() {
      _isLoading = true;
      _message = '';
    });

    try {
      final response = await http.post(
        Uri.parse('https://educare-backend-l6ue.onrender.com/patients/login/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': _emailController.text,
          'password': _passwordController.text,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        // Get the UserController instance
        final userController = Get.find<UserController>();

        // Create a User instance from the response data
        final user = User(
          email: _emailController.text,
          // Set other fields as needed
        );

        // Set the user in the controller
        await userController.setUser(user);

        // Fetch complete profile
        await userController.fetchUserProfile(user.email!);

        // Navigate to home and pass the email
        Get.offAllNamed(AppRoutes.home, arguments: {'email': user.email});
      } else {
        setState(() {
          _message = data['error'] ?? 'Invalid credentials. Try again.';
        });
      }
    } catch (e) {
      setState(() {
        _message = 'An error occurred. Please try again.';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _handleLoginSuccess(Map<String, dynamic> responseData) async {
    try {
      final userController = Get.find<UserController>();

      // First set basic user data from login response
      final user = User.fromJson(responseData);
      await userController.setUser(user);

      // Then fetch complete profile
      await userController.fetchUserProfile(user.email!);

      print(
        'User data after login: ${userController.user?.toJson()}',
      ); // Add this debug line

      Get.offAllNamed(AppRoutes.home);
    } catch (e) {
      print('Error handling login success: $e');
      setState(() {
        _message = 'Error loading user data';
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
                  'Accédez à votre compte!',
                  style: TextStyle(
                    fontSize: size.width * 0.055,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: size.height * 0.04),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Email',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: size.width * 0.04,
                      ),
                    ),
                    SizedBox(height: 8),
                    TextFormField(
                      controller: _emailController,
                      style: const TextStyle(color: mainGreen),
                      cursorColor: mainGreen,
                      decoration: InputDecoration(
                        hintText: 'Saisissez votre email',
                        hintStyle: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                        ),
                        prefixIcon: const Icon(Icons.email_outlined),
                        prefixIconColor: MaterialStateColor.resolveWith((
                          states,
                        ) {
                          if (states.contains(MaterialState.focused)) {
                            return mainGreen;
                          }
                          return Colors.white.withOpacity(0.7);
                        }),
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
                          borderSide: const BorderSide(
                            color: mainGreen,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.03),
                    Text(
                      'Mot de passe',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: size.width * 0.04,
                      ),
                    ),
                    SizedBox(height: 8),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: !_isPasswordVisible,
                      style: const TextStyle(color: mainGreen),
                      cursorColor: mainGreen,
                      decoration: InputDecoration(
                        hintText: 'Saisissez votre mot de passe',
                        hintStyle: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                        ),
                        prefixIcon: const Icon(Icons.lock_outline),
                        prefixIconColor: MaterialStateColor.resolveWith((
                          states,
                        ) {
                          if (states.contains(MaterialState.focused)) {
                            return mainGreen;
                          }
                          return Colors.white.withOpacity(0.7);
                        }),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.white.withOpacity(0.7),
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
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
                          borderSide: const BorderSide(
                            color: mainGreen,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Get.toNamed(
                        AppRoutes.forgotPassword,
                      ); // Navigate to the forgot password page
                    },
                    child: Text(
                      'Mot de passe oublié ?',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: size.width * 0.035,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                if (_message.isNotEmpty)
                  Text(
                    _message,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: size.width * 0.035,
                    ),
                  ),
                SizedBox(height: size.height * 0.02),
                SizedBox(
                  width: double.infinity,
                  height: size.height * 0.065,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _handleLogin,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child:
                        _isLoading
                            ? CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                const Color.fromRGBO(103, 146, 148, 1),
                              ),
                            )
                            : Text(
                              'Se connecter',
                              style: TextStyle(
                                fontSize: size.width * 0.045,
                                color: const Color.fromRGBO(103, 146, 148, 1),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Pas de compte ? ',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: size.width * 0.035,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.toNamed(
                          AppRoutes.signUp,
                        ); // Navigate to Sign-Up Page
                      },
                      child: Text(
                        'Inscrivez-vous maintenant',
                        style: TextStyle(
                          color: mainGreen,
                          fontWeight: FontWeight.w600,
                          fontSize: size.width * 0.035,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
