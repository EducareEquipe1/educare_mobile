import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../home/home_page.dart';
import '../rendezvous/appointments_page.dart';
import '../documents/documents_page.dart';
import '../notifications/notifications_page.dart';
import '../settings/settings_page.dart';
import '../../widgets/custom_nav_bar.dart';

class BottomNav extends StatefulWidget {
  final int initialTab;
  const BottomNav({Key? key, this.initialTab = 0}) : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  late int _selectedIndex;

  final List<Widget> _pages = [
    HomePage(),
    const AppointmentsPage(),
    const DocumentsPage(), // Changed from DossierPage to DocumentsPage
    const NotificationsPage(),
    const SettingsPage(),
  ];

  @override
  void initState() {
    super.initState();
    // Use argument if provided
    final args = Get.arguments as Map<String, dynamic>?;
    _selectedIndex =
        args != null && args['tab'] != null
            ? args['tab'] as int
            : widget.initialTab;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: CustomNavBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
