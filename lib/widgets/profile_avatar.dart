import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  final String? imageUrl;
  final double radius;

  const ProfileAvatar({Key? key, required this.imageUrl, this.radius = 20})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundImage:
          imageUrl != null && imageUrl!.isNotEmpty
              ? NetworkImage(imageUrl!)
              : const AssetImage('assets/images/default_picture.png')
                  as ImageProvider,
    );
  }
}
