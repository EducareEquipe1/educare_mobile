import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app/routes/app_routes.dart';
import '../../widgets/custom_nav_bar.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _currentIndex = 0;

  void _onTabTapped(int index) {
    setState(() => _currentIndex = index);

    switch (index) {
      case 0:
        Get.toNamed(AppRoutes.home);
        break;
      case 1:
        Get.toNamed(AppRoutes.calendar);
        break;
      case 2:
        Get.toNamed(AppRoutes.folder);
        break;
      case 3:
        Get.toNamed(AppRoutes.notifications);
        break;
      case 4:
        Get.toNamed(AppRoutes.settings);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const SafeArea(child: SizedBox()),
      bottomNavigationBar: CustomNavBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}
