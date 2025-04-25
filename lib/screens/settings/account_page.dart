import 'dart:io';
import 'package:educare/widgets/profile_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _nomController = TextEditingController(
    text: 'Brahmi',
  );
  final TextEditingController _prenomController = TextEditingController(
    text: 'Sarah Dorsaf',
  );
  final TextEditingController _telephoneController = TextEditingController(
    text: '0558216381',
  );

  @override
  void initState() {
    super.initState();
    _loadProfileImage();
  }

  Future<void> _loadProfileImage() async {
    final prefs = await SharedPreferences.getInstance();
    final String? imagePath = prefs.getString('profile_image');
    if (imagePath != null) {
      final file = File(imagePath);
      if (await file.exists()) {
        setState(() {
          _imageFile = file;
        });
      }
    }
  }

  Future<void> _updateProfileImage() async {
    try {
      // Request permission first
      final permission = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxWidth: 512,
        maxHeight: 512,
        imageQuality: 75,
      );

      if (permission != null) {
        final File imageFile = File(permission.path);

        setState(() {
          _imageFile = imageFile;
        });

        // Save the image path
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('profile_image', imageFile.path);

        // Show success message
        Get.snackbar(
          'Succès',
          'Photo de profil mise à jour',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green[100],
        );
      }
    } catch (e) {
      print('Error picking image: $e'); // For debugging
      Get.snackbar(
        'Erreur',
        'Impossible de mettre à jour la photo',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[100],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        title: const Text('Compte'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    ProfileImage(
                      imageFile: _imageFile,
                      onTap: _updateProfileImage,
                    ),
                    TextButton(
                      onPressed: _updateProfileImage,
                      child: const Text(
                        'Modifier Photo',
                        style: TextStyle(
                          color: Color(0xFF678E90),
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              _buildInputField(label: 'Nom', controller: _nomController),
              const SizedBox(height: 16),
              _buildInputField(label: 'Prenom', controller: _prenomController),
              const SizedBox(height: 16),
              _buildInputField(
                label: 'Téléphone',
                controller: _telephoneController,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Save changes
                    Get.back();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF678E90),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Sauvegarder',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, color: Color(0xFF4A5568)),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            filled: true,
            fillColor: const Color(0xFFEDF2F7),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
