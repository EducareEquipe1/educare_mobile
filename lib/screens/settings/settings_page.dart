import 'package:educare/screens/settings/account_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app/routes/app_routes.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Paramètres',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(45, 55, 72, 1),
                      ),
                    ),
                    CircleAvatar(
                      backgroundImage: const AssetImage(
                        'assets/images/profile.png',
                      ),
                      radius: 20,
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                const Text(
                  'GÉNÉRAL',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color.fromRGBO(113, 128, 150, 1),
                  ),
                ),
                const SizedBox(height: 16),
                _buildSettingsItem(
                  icon: Icons.person_outline,
                  title: 'Compte',
                  onTap: () => Get.to(() => const AccountPage()),
                ),
                _buildSettingsItem(
                  icon: Icons.lock_outline,
                  title: 'Changer mot de passe',
                  onTap: () {},
                ),
                _buildSettingsItemWithSwitch(
                  icon: Icons.notifications_outlined,
                  title: 'Notifications',
                  value: true,
                  onChanged: (value) {},
                ),
                _buildSettingsItem(
                  icon: Icons.logout,
                  title: 'Se déconnecter',
                  onTap: () => Get.offAllNamed(AppRoutes.login),
                  isDestructive: true,
                ),
                const SizedBox(height: 32),
                const Text(
                  'FEEDBACK',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color.fromRGBO(113, 128, 150, 1),
                  ),
                ),
                const SizedBox(height: 16),
                _buildSettingsItem(
                  icon: Icons.warning_outlined,
                  title: 'Signaler un bug',
                  onTap: () {},
                ),
                _buildSettingsItem(
                  icon: Icons.message_outlined,
                  title: 'Envoyer des commentaires',
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(
        icon,
        color: isDestructive ? Colors.red : const Color.fromRGBO(45, 55, 72, 1),
        size: 24,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          color:
              isDestructive ? Colors.red : const Color.fromRGBO(45, 55, 72, 1),
        ),
      ),
      trailing: const Icon(
        Icons.chevron_right,
        color: Color.fromRGBO(160, 174, 192, 1),
      ),
      onTap: onTap,
    );
  }

  Widget _buildSettingsItemWithSwitch({
    required IconData icon,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: const Color.fromRGBO(45, 55, 72, 1), size: 24),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          color: Color.fromRGBO(45, 55, 72, 1),
        ),
      ),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: Colors.white,
        activeTrackColor: const Color.fromRGBO(103, 146, 148, 1),
      ),
    );
  }
}
