import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileImageHelper {
  static Future<ImageProvider> getProfileImage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? imagePath = prefs.getString('profile_image');

      if (imagePath != null) {
        final file = File(imagePath);
        if (await file.exists()) {
          return FileImage(file);
        }
      }
      return const AssetImage('assets/images/default_profile.png');
    } catch (e) {
      return const AssetImage('assets/images/default_profile.png');
    }
  }
}
