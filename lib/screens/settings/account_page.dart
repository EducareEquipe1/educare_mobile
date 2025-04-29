import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:educare/widgets/profile_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../controllers/user_controller.dart';
import '../../models/user_model.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final UserController userController = Get.find<UserController>();
  final RxBool _isLoading = true.obs;
  final RxBool _hasError = false.obs;
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _prenomController = TextEditingController();
  final TextEditingController _telephoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _matriculeController = TextEditingController();
  final TextEditingController _categorieController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() async {
    _isLoading.value = true;
    _hasError.value = false;

    if (userController.user?.email != null) {
      try {
        print('Fetching profile for: ${userController.user!.email}');

        // Fetch user info
        final profileResponse = await http.get(
          Uri.parse(
            'https://educare-backend-l6ue.onrender.com/patients/profile/${userController.user!.email}',
          ),
        );

        print('Profile response status: ${profileResponse.statusCode}');
        print('Profile response body: ${profileResponse.body}');

        if (profileResponse.statusCode == 200) {
          final data = jsonDecode(profileResponse.body)['data'];
          setState(() {
            _nomController.text = data['lastName'] ?? '';
            _prenomController.text = data['firstName'] ?? '';
            _telephoneController.text = data['phone'] ?? '';
            _emailController.text = data['email'] ?? '';

            // Set profile image or default image
            userController.user?.profileImage =
                data['profileImage']?.isNotEmpty == true
                    ? data['profileImage']
                    : 'assets/images/default_pic.png';
          });
        } else {
          _hasError.value = true;
        }
      } catch (e) {
        print('Error loading user data: $e');
        _hasError.value = true;
      } finally {
        _isLoading.value = false;
      }
    } else {
      _isLoading.value = false;
    }
  }

  Future<void> _fetchProfileImage(String imageId) async {
    try {
      print('Fetching profile image with ID: $imageId');

      final imageResponse = await http.get(
        Uri.parse('http://localhost:3000/patients/upload-id-photo/$imageId'),
      );

      print('Image response status: ${imageResponse.statusCode}');

      if (imageResponse.statusCode == 200) {
        final imageData = jsonDecode(imageResponse.body);
        setState(() {
          userController.user?.profileImage = imageData['url'] ?? '';
        });
      } else {
        print('Failed to fetch profile image: ${imageResponse.body}');
      }
    } catch (e) {
      print('Error fetching profile image: $e');
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> _updateProfile() async {
    try {
      Get.dialog(
        const Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );

      final result = await userController.updateUserProfile(
        nom: _nomController.text,
        prenom: _prenomController.text,
        email: userController.user?.email ?? '',
        num_tel: _telephoneController.text,
        newEmail:
            _emailController.text != userController.user!.email
                ? _emailController.text
                : null,
      );

      Get.back();

      if (result) {
        Get.snackbar(
          'Succès',
          'Profil mis à jour avec succès',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          'Erreur',
          'Échec de la mise à jour du profil',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }

      print('Error updating profile: $e');
      Get.snackbar(
        'Erreur',
        'Une erreur s\'est produite lors de la mise à jour. Veuillez réessayer.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 5),
        mainButton: TextButton(
          onPressed: _updateProfile,
          child: const Text('Réessayer', style: TextStyle(color: Colors.white)),
        ),
      );
    }
  }

  Future<void> _changeProfilePicture() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      try {
        Get.dialog(
          const Center(child: CircularProgressIndicator()),
          barrierDismissible: false,
        );

        // Read the file as bytes
        final fileBytes = await pickedFile.readAsBytes();

        // Create multipart request
        final request = http.MultipartRequest(
          'POST',
          Uri.parse('http://localhost:3000/patients/upload-id-photo'),
        );

        // Add file to request
        request.files.add(
          http.MultipartFile.fromBytes(
            'image',
            fileBytes,
            filename: pickedFile.name,
          ),
        );

        // Add email parameter if needed
        if (userController.user?.email != null) {
          request.fields['email'] = userController.user!.email!;
        }

        // Send request
        final response = await request.send();
        final responseBody = await response.stream.bytesToString();
        final data = jsonDecode(responseBody);

        Get.back();

        if (response.statusCode == 200) {
          if (data['data']['url'] != null) {
            setState(() {
              userController.user?.profileImage = data['data']['url'];
            });
          } else if (data['data']['imageId'] != null) {
            await _fetchProfileImage(data['data']['imageId']);
          }

          Get.snackbar(
            'Succès',
            'Photo de profil mise à jour avec succès',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
        } else {
          Get.snackbar(
            'Erreur',
            'Échec de la mise à jour de la photo de profil: ${data['message'] ?? 'Unknown error'}',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      } catch (e) {
        if (Get.isDialogOpen ?? false) {
          Get.back();
        }

        print('Error uploading profile picture: $e');
        Get.snackbar(
          'Erreur',
          'Une erreur s\'est produite lors de la mise à jour. Veuillez réessayer.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mon Compte')),
      body: Obx(() {
        if (_isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (_hasError.value) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Failed to load user data'),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _loadUserData,
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        if (userController.user == null) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              _buildProfileHeader(),
              const SizedBox(height: 24),
              _buildInfoField('Nom', _nomController),
              _buildInfoField('Prénom', _prenomController),
              _buildInfoField('Email', _emailController, enabled: false),
              _buildInfoField('Téléphone', _telephoneController),
              _buildInfoField(
                'Matricule',
                _matriculeController,
                enabled: false,
              ),
              _buildInfoField(
                'Catégorie',
                _categorieController,
                enabled: false,
              ),
              const SizedBox(height: 32),
              _buildSaveButton(),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildProfileHeader() {
    return Center(
      child: Column(
        children: [
          Obx(() {
            final imageUrl = userController.user?.profileImage;
            return CircleAvatar(
              radius: 50,
              backgroundImage:
                  imageUrl != null && imageUrl.startsWith('http')
                      ? NetworkImage(imageUrl)
                      : const AssetImage('assets/images/default_pic.png')
                          as ImageProvider,
            );
          }),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _changeProfilePicture,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF678E90),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Modifier la photo',
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoField(
    String label,
    TextEditingController controller, {
    bool enabled = true,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF4A5568),
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          enabled: enabled,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFEDF2F7),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _updateProfile,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF678E90),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: const Text(
          'Sauvegarder',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}
