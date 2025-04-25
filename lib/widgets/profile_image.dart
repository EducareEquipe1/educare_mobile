import 'dart:io';
import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  final File? imageFile;
  final double size;
  final VoidCallback? onTap;

  const ProfileImage({Key? key, this.imageFile, this.size = 80, this.onTap})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFFEDF2F7),
        ),
        child:
            imageFile != null
                ? ClipOval(child: Image.file(imageFile!, fit: BoxFit.cover))
                : const Icon(Icons.person, size: 40, color: Colors.grey),
      ),
    );
  }
}
