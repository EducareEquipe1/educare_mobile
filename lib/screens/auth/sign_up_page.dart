import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app/routes/app_routes.dart';

const mainGreen = Color.fromRGBO(45, 55, 72, 1);

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String? _selectedRole; // Variable to store the selected role
  bool _isPasswordVisible = false; // Variable to toggle password visibility

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
                // EduCare Logo
                Image.asset(
                  'assets/images/white_logo.png',
                  height: size.height * 0.08,
                ),
                SizedBox(height: size.height * 0.02),

                // Title
                Text(
                  'Créer un compte!',
                  style: TextStyle(
                    fontSize: size.width * 0.055,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: size.height * 0.04),

                // Name and Surname
                Row(
                  children: [
                    Expanded(child: _buildTextField('Nom', Icons.person, size)),
                    SizedBox(width: size.width * 0.04),
                    Expanded(
                      child: _buildTextField(
                        'Prénom',
                        Icons.person_outline,
                        size,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.02),

                // Date of Birth
                _buildTextField(
                  'Date de naissance',
                  Icons.calendar_today,
                  size,
                ),
                SizedBox(height: size.height * 0.02),

                // Phone and Matricule
                Row(
                  children: [
                    Expanded(
                      child: _buildTextField('Téléphone', Icons.phone, size),
                    ),
                    SizedBox(width: size.width * 0.04),
                    Expanded(
                      child: _buildTextField('Matricule', Icons.badge, size),
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.02),

                // Email
                _buildTextField('Email', Icons.email, size),
                SizedBox(height: size.height * 0.02),

                // Password with Eye Icon
                _buildPasswordField(size),
                SizedBox(height: size.height * 0.02),

                // Role Dropdown
                _buildRoleDropdown(size),
                SizedBox(height: size.height * 0.04),

                // Create Button
                SizedBox(
                  width: double.infinity,
                  height: size.height * 0.065,
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle sign-up logic
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Créer',
                      style: TextStyle(
                        fontSize: size.width * 0.045,
                        color: const Color.fromRGBO(103, 146, 148, 1),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.02),

                // Navigate to Login
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Vous avez déjà un compte ? ',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: size.width * 0.035,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.toNamed(AppRoutes.login); // Navigate to Login Page
                      },
                      child: Text(
                        'Connectez-vous',
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

  Widget _buildTextField(
    String hint,
    IconData icon,
    Size size, {
    bool obscureText = false,
  }) {
    return TextFormField(
      obscureText: obscureText,
      style: const TextStyle(color: mainGreen),
      cursorColor: mainGreen,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
        prefixIcon: Icon(icon),
        prefixIconColor: MaterialStateColor.resolveWith((states) {
          if (states.contains(MaterialState.focused)) {
            return mainGreen;
          }
          return Colors.white.withOpacity(0.7);
        }),
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: mainGreen, width: 2),
        ),
      ),
    );
  }

  Widget _buildPasswordField(Size size) {
    return TextFormField(
      obscureText: !_isPasswordVisible,
      style: const TextStyle(color: mainGreen),
      cursorColor: mainGreen,
      decoration: InputDecoration(
        hintText: 'Mot de passe',
        hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
        prefixIcon: Icon(Icons.lock),
        prefixIconColor: MaterialStateColor.resolveWith((states) {
          if (states.contains(MaterialState.focused)) {
            return mainGreen;
          }
          return Colors.white.withOpacity(0.7);
        }),
        suffixIcon: IconButton(
          icon: Icon(
            _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
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
          borderSide: BorderSide(color: Colors.white.withOpacity(0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: mainGreen, width: 2),
        ),
      ),
    );
  }

  Widget _buildRoleDropdown(Size size) {
    return DropdownButtonFormField<String>(
      value: _selectedRole,
      decoration: InputDecoration(
        hintText: 'Role',
        hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
        prefixIcon: Icon(Icons.person_search),
        prefixIconColor: MaterialStateColor.resolveWith((states) {
          if (states.contains(MaterialState.focused)) {
            return mainGreen;
          }
          return Colors.white.withOpacity(0.7);
        }),
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: mainGreen, width: 2),
        ),
      ),
      dropdownColor: Colors.white,
      icon: Icon(Icons.arrow_drop_down, color: Colors.white.withOpacity(0.7)),
      items:
          ['Etudiant', 'Enseignant', 'ATS']
              .map(
                (role) => DropdownMenuItem<String>(
                  value: role,
                  child: Text(
                    role,
                    style: TextStyle(
                      color: mainGreen, // Always white for dropdown items
                    ),
                  ),
                ),
              )
              .toList(),
      onChanged: (value) {
        setState(() {
          _selectedRole = value;
        });
      },
      style: const TextStyle(color: mainGreen), // Selected item turns mainGreen
    );
  }
}
