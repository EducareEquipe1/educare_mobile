import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileImagePicker extends StatefulWidget {
  const ProfileImagePicker({Key? key}) : super(key: key);

  @override
  State<ProfileImagePicker> createState() => _ProfileImagePickerState();
}

class _ProfileImagePickerState extends State<ProfileImagePicker> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _loadSavedImage();
  }

  Future<void> _loadSavedImage() async {
    final prefs = await SharedPreferences.getInstance();
    final String? imagePath = prefs.getString('profile_image');
    if (imagePath != null) {
      setState(() {
        _imageFile = File(imagePath);
      });
    }
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 512,
      maxHeight: 512,
      imageQuality: 75,
    );

    if (image != null) {
      setState(() {
        _imageFile = File(image.path);
      });

      // Save the image path
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('profile_image', image.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: _pickImage,
          child: Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[200],
              border: Border.all(
                color: Theme.of(context).primaryColor,
                width: 2,
              ),
            ),
            child: ClipOval(
              child:
                  _imageFile != null
                      ? Image.file(_imageFile!, fit: BoxFit.cover)
                      : Icon(
                        Icons.add_a_photo,
                        size: 40,
                        color: Theme.of(context).primaryColor,
                      ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        TextButton(
          onPressed: _pickImage,
          child: const Text('Change Profile Picture'),
        ),
      ],
    );
  }
}
