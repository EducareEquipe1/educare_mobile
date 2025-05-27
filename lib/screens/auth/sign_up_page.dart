import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../app/routes/app_routes.dart';

const mainGreen = Color.fromRGBO(45, 55, 72, 1);

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _matriculeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _selectedRole = 'Etudiant';
  String? _selectedSex; // Add this line
  bool _isPasswordVisible = false;
  bool _isLoading = false;
  String _message = '';

  Future<void> _handleSignUp() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _message = '';
    });

    try {
      final response = await http.post(
        Uri.parse(
          'https://educare-backend-l6ue.onrender.com/patients/register',
        ),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'first_name': _firstNameController.text,
          'last_name': _lastNameController.text,
          'birth_date': _birthDateController.text,
          'phone': _phoneController.text,
          'matricule': _matriculeController.text,
          'email': _emailController.text,
          'password': _passwordController.text,
          'categorie': _selectedRole,
          'sex': _selectedSex,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 201) {
        setState(() {
          _message = 'Account created successfully!';
        });
        Get.toNamed(
          AppRoutes.checkEmail,
          arguments: {
            'email': _emailController.text,
          }, // Pass email to CheckEmailPage
        );
      } else {
        setState(() {
          _message = data['error'] ?? 'Error signing up. Try again.';
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
            child: Form(
              key: _formKey,
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
                      Expanded(
                        child: _buildTextField(
                          'Nom',
                          Icons.person,
                          _firstNameController,
                          size,
                        ),
                      ),
                      SizedBox(width: size.width * 0.04),
                      Expanded(
                        child: _buildTextField(
                          'Prénom',
                          Icons.person_outline,
                          _lastNameController,
                          size,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.02),

                  // Date of Birth with calendar picker
                  TextFormField(
                    controller: _birthDateController,
                    readOnly: true,
                    style: const TextStyle(color: mainGreen),
                    cursorColor: mainGreen,
                    decoration: InputDecoration(
                      hintText: 'Date de naissance (YYYY-MM-DD)',
                      hintStyle: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                      ),
                      prefixIcon: Icon(Icons.calendar_today),
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
                    onTap: () async {
                      FocusScope.of(context).requestFocus(FocusNode());
                      DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now().subtract(
                          const Duration(days: 365 * 18),
                        ),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                        builder: (context, child) {
                          return Theme(
                            data: Theme.of(context).copyWith(
                              colorScheme: ColorScheme.light(
                                primary: mainGreen,
                                onPrimary: Colors.white,
                                onSurface: mainGreen,
                              ),
                              textButtonTheme: TextButtonThemeData(
                                style: TextButton.styleFrom(
                                  foregroundColor: mainGreen,
                                ),
                              ),
                            ),
                            child: child!,
                          );
                        },
                      );
                      if (picked != null) {
                        _birthDateController.text =
                            "${picked.year.toString().padLeft(4, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
                      }
                    },
                    validator:
                        (value) =>
                            value == null || value.isEmpty
                                ? 'Veuillez sélectionner la date de naissance'
                                : null,
                  ),
                  SizedBox(height: size.height * 0.02),

                  // Sexe Dropdown with green selected text
                  DropdownButtonFormField<String>(
                    value: _selectedSex,
                    decoration: InputDecoration(
                      hintText: 'Sexe',
                      hintStyle: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                      ),
                      prefixIcon: Icon(Icons.wc),
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
                    dropdownColor: Colors.white,
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.white.withOpacity(0.7),
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: 'Male',
                        child: Text(
                          'Homme',
                          style: TextStyle(color: mainGreen),
                        ),
                      ),
                      DropdownMenuItem(
                        value: 'Female',
                        child: Text(
                          'Femme',
                          style: TextStyle(color: mainGreen),
                        ),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _selectedSex = value;
                      });
                    },
                    validator:
                        (value) =>
                            value == null
                                ? 'Veuillez sélectionner le sexe'
                                : null,
                    style: const TextStyle(color: mainGreen),
                  ),
                  SizedBox(height: size.height * 0.02),

                  // Phone and Matricule
                  Row(
                    children: [
                      Expanded(
                        child: _buildTextField(
                          'Téléphone',
                          Icons.phone,
                          _phoneController,
                          size,
                        ),
                      ),
                      SizedBox(width: size.width * 0.04),
                      Expanded(
                        child: _buildTextField(
                          'Matricule',
                          Icons.badge,
                          _matriculeController,
                          size,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.02),

                  // Email
                  _buildTextField('Email', Icons.email, _emailController, size),
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
                      onPressed: _isLoading ? null : _handleSignUp,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        _isLoading ? 'Création...' : 'Créer',
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
                          Get.toNamed(AppRoutes.login);
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

                  // Error or Success Message
                  if (_message.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        _message,
                        style: TextStyle(
                          color:
                              _message.contains('successfully')
                                  ? Colors.green
                                  : Colors.red,
                          fontSize: size.width * 0.035,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    String hint,
    IconData icon,
    TextEditingController controller,
    Size size, {
    bool obscureText = false,
  }) {
    return TextFormField(
      controller: controller,
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
      controller: _passwordController,
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
                  child: Text(role, style: const TextStyle(color: mainGreen)),
                ),
              )
              .toList(),
      onChanged: (value) {
        setState(() {
          _selectedRole = value;
        });
      },
      style: const TextStyle(color: mainGreen),
    );
  }
}
