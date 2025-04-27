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
        print(
          'Fetching profile for: ${userController.user!.email}',
        ); // Debug log

        final response = await http.get(
          Uri.parse(
            'http://10.0.2.2:3000/patients/profile/${userController.user!.email}',
          ),
        );

        print('Response status: ${response.statusCode}'); // Debug log
        print('Response body: ${response.body}'); // Debug log

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body)['data'];
          setState(() {
            _nomController.text = data['lastName'] ?? '';
            _prenomController.text = data['firstName'] ?? '';
            _telephoneController.text = data['phone'] ?? '';
            _emailController.text = data['email'] ?? '';
          });
        } else {
          _hasError.value = true;
        }
      } catch (e) {
        print('Error loading user data: $e'); // Debug log
        _hasError.value = true;
      }
    }
    _isLoading.value = false;
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
          CircleAvatar(
            radius: 50,
            backgroundImage:
                userController.user?.profileImage != null
                    ? NetworkImage(userController.user!.profileImage!)
                    : const AssetImage('assets/images/default_pic.png')
                        as ImageProvider,
          ),
          const SizedBox(height: 16),
          Text(
            '${userController.user?.firstName} ${userController.user?.lastName}',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
        onPressed: () {
          // Save changes logic
        },
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
