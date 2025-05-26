import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';

class UserController extends GetxController {
  final Rx<User?> _user = Rx<User?>(null);
  User? get user => _user.value;

  final String baseUrl = 'https://educare-backend-l6ue.onrender.com';

  // New field to store address
  String? address;

  @override
  void onInit() {
    super.onInit();
    loadUserFromStorage();
  }

  Future<void> setUser(User user) async {
    _user.value = user;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_data', jsonEncode(user.toJson()));
    update();
  }

  Future<void> loadUserFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString('user_data');
    if (userData != null) {
      try {
        _user.value = User.fromJson(jsonDecode(userData));
      } catch (e) {
        print('Error loading user data: $e');
      }
    }
  }

  Future<void> clearUser() async {
    _user.value = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_data');
  }

  Future<void> fetchUserProfile(String email) async {
    try {
      final token = await getToken();
      final response = await http.get(
        Uri.parse('$baseUrl/patients/profile/$email'),
        headers: {
          'Content-Type': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['data'];
        // Fetch the profile image URL
        final imageResponse = await http.get(
          Uri.parse('$baseUrl/patients/get-patient-photo/$email'),
        );
        String? profileImage;
        if (imageResponse.statusCode == 200) {
          final imageData = jsonDecode(imageResponse.body);
          profileImage = imageData['image'];
        }
        _user.value = User(
          email: data['email'],
          firstName: data['firstName'],
          lastName: data['lastName'],
          phone: data['phone'],
          profileImage: profileImage,
          birthDate: data['date_naissance'], // <-- Add this line
        );
        update();
      } else {
        print('Failed to fetch user profile: ${response.body}');
      }
    } catch (e) {
      print('Error fetching user profile: $e');
      throw e;
    }
  }

  Future<bool> updateUserProfile({
    required String nom, // Changed from lastName
    required String prenom, // Changed from firstName
    required String email,
    String? newEmail,
    required String num_tel, // Changed from phone
  }) async {
    try {
      print('Attempting to update profile for: $email');
      print(
        'Request payload: ${jsonEncode({
          'nom': nom,
          'prenom': prenom,
          'num_tel': num_tel,
          if (newEmail != null && newEmail != email) 'new_email': newEmail, // Use new_email for email updates
          'email': email, // Keep email for identifying the user
        })}',
      );

      final response = await http
          .patch(
            Uri.parse(
              '$baseUrl/patients/modify-profile/${Uri.encodeComponent(email)}',
            ),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'nom': nom,
              'prenom': prenom,
              'num_tel': num_tel,
              if (newEmail != null && newEmail != email)
                'new_email': newEmail, // Use new_email for email updates
              'email': email, // Keep email for identifying the user
            }),
          )
          .timeout(const Duration(seconds: 15));

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        _user.value = _user.value?.copyWith(
          firstName: prenom,
          lastName: nom,
          email: newEmail ?? email,
          phone: num_tel,
        );
        update();
        await fetchUserProfile(newEmail ?? email);
        return true;
      }

      throw Exception('Server returned status code: ${response.statusCode}');
    } on TimeoutException {
      print('Update request timed out');
      return false;
    } catch (e) {
      print('Error updating profile: $e');
      return false;
    }
  }

  Future<void> refreshUserProfile() async {
    try {
      if (_user.value?.email == null) {
        throw Exception('No user email available');
      }

      final response = await http.get(
        Uri.parse('$baseUrl/patients/profile/${_user.value!.email}'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['data'];
        final updatedUser = User(
          id: _user.value?.id,
          email: data['email'],
          firstName: data['firstName'],
          lastName: data['lastName'],
          phone: data['phone'],
          profileImage: _user.value?.profileImage,
          isActive: _user.value?.isActive,
          birthDate: _user.value?.birthDate,
        );
        await setUser(updatedUser);
      } else {
        throw Exception('Failed to refresh user profile');
      }
    } catch (e) {
      print('Error refreshing user profile: $e');
      rethrow;
    }
  }

  Future<bool> uploadProfileImage(File imageFile) async {
    try {
      final user = _user.value;
      if (user == null || user.email == null)
        throw Exception('No user logged in');
      final uri = Uri.parse('$baseUrl/patients/upload-id-photo');
      final request = http.MultipartRequest('POST', uri);
      request.files.add(
        await http.MultipartFile.fromPath('image', imageFile.path),
      );
      request.fields['email'] = user.email!;
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode == 200) {
        await fetchUserProfile(user.email!);
        return true;
      }
      return false;
    } catch (e) {
      print('Error uploading profile image: $e');
      return false;
    }
  }

  String? getProfileImageUrl() {
    final user = _user.value;
    if (user == null || user.email == null) return null;
    return '$baseUrl/patients/get-patient-photo/${user.email}';
  }

  String? get userEmail => _user.value?.email;

  Future<void> fetchDossierMedical(String email) async {
    try {
      final token = await getToken();
      final response = await http.get(
        Uri.parse(
          'https://educare-backend-l6ue.onrender.com/patients/dossier-medical/$email',
        ),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        address = data['adresse'] ?? '';
        // If user exists, update birthDate; else, create user from dossier data
        if (user != null) {
          _user.value = user!.copyWith(
            birthDate: data['date_naissance'],
            firstName: user!.firstName ?? data['prenom'],
            lastName: user!.lastName ?? data['nom'],
            phone: user!.phone ?? data['num_tel'],
          );
        } else {
          _user.value = User(
            email: email,
            firstName: data['prenom'],
            lastName: data['nom'],
            phone: data['num_tel'],
            birthDate: data['date_naissance'],
          );
        }
        update();
      } else {
        print('Failed to fetch dossier medical: ${response.body}');
      }
    } catch (e) {
      print('Error fetching dossier medical: $e');
    }
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token'); // Use 'token' everywhere
  }
}
