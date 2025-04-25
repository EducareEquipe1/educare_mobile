import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // Header with back button
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Color.fromRGBO(45, 55, 72, 1),
                      ),
                      onPressed: () => Get.back(),
                    ),
                    const Text(
                      'Compte',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(45, 55, 72, 1),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                // Profile Image Section
                Column(
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('assets/images/profile.png'),
                    ),
                    const SizedBox(height: 8),
                    TextButton(
                      onPressed: () {
                        // TODO: Implement photo modification
                      },
                      child: const Text(
                        'Modifier Photo',
                        style: TextStyle(
                          color: Color.fromRGBO(103, 146, 148, 1),
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                // Form Fields
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInputField(label: 'Nom', value: 'Brahmi'),
                    const SizedBox(height: 20),
                    _buildInputField(label: 'Prenom', value: 'Sarah Dorsaf'),
                    const SizedBox(height: 20),
                    _buildInputField(
                      label: 'Téléphone',
                      value: '0558216381',
                      keyboardType: TextInputType.phone,
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                // Save Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      // TODO: Implement save functionality
                      Get.back();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(103, 146, 148, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Sauvegarder',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
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

  Widget _buildInputField({
    required String label,
    required String value,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            color: Color.fromRGBO(45, 55, 72, 1),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          initialValue: value,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color.fromRGBO(203, 213, 224, 1),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color.fromRGBO(203, 213, 224, 1),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color.fromRGBO(103, 146, 148, 1),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
