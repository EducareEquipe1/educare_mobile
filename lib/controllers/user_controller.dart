import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';

class UserController extends GetxController {
  final Rx<User?> _user = Rx<User?>(null);
  User? get user => _user.value;

  final String baseUrl = 'https://educare-backend-l6ue.onrender.com';

  @override
  void onInit() {
    super.onInit();
    loadUserFromStorage();
  }

  Future<void> setUser(User user) async {
    _user.value = user;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_data', jsonEncode(user.toJson()));
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
      final response = await http.get(
        Uri.parse('$baseUrl/patients/profile/$email'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['data'];

        // Update the user data with the profile information
        final updatedUser = User(
          id: data['id'],
          email: data['email'],
          firstName: data['firstName'],
          lastName: data['lastName'],
          phone: data['phone'],
          matricule: data['matricule'],
          category: data['categorie'],
        );

        await setUser(updatedUser);
      } else {
        print('Failed to fetch user profile: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching user profile: $e');
    }
  }

  Future<bool> updateUserProfile({
    required String nom,
    required String prenom,
    required String email,
    required String newEmail,
    required String numTel,
  }) async {
    try {
      final response = await http.patch(
        Uri.parse('$baseUrl/patients/modify-profile/$email'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'nom': nom,
          'prenom': prenom,
          'new_email': newEmail,
          'num_tel': numTel,
        }),
      );

      if (response.statusCode == 200) {
        await fetchUserProfile(newEmail);
        return true;
      }
      print('Failed to update profile: ${response.statusCode}');
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
          matricule: _user.value?.matricule,
          category: _user.value?.category,
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
}
