import 'package:educare/screens/settings/account_page.dart';
import 'package:educare/screens/settings/change_password_page.dart';
import 'package:educare/widgets/profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app/routes/app_routes.dart';
import 'profile_image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../controllers/user_controller.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final UserController userController = Get.find<UserController>();
  final RxBool _notificationsEnabled = true.obs;
  final RxBool _isLoading = true.obs;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    try {
      await Future.wait([_loadUserData(), _loadSettings()]);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load user data',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> _loadUserData() async {
    try {
      await userController.refreshUserProfile();
    } catch (e) {
      print('Error loading user data: $e');
      rethrow;
    }
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _notificationsEnabled.value =
        prefs.getBool('notifications_enabled') ?? true;
  }

  Future<void> _saveNotificationSetting(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notifications_enabled', value);
    _notificationsEnabled.value = value;
  }

  Future<void> _handleLogout() async {
    await userController.clearUser();
    await Get.offAllNamed(AppRoutes.login);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (_isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final user = userController.user;
        if (user == null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Failed to load user data'),
                ElevatedButton(
                  onPressed: _initializeData,
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Paramètres'),
                      Text('${user.firstName} ${user.lastName}'),
                    ],
                  ),
                  GestureDetector(
                    onTap: _showProfileImagePicker,
                    child: Obx(
                      () => ProfileAvatar(
                        imageUrl: userController.user?.profileImage,
                        radius: 28,
                      ),
                    ),
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
                onTap: () => Get.to(() => const ChangePasswordPage()),
              ),
              Obx(
                () => _buildSettingsItemWithSwitch(
                  icon: Icons.notifications_outlined,
                  title: 'Notifications',
                  value: _notificationsEnabled.value,
                  onChanged: _saveNotificationSetting,
                ),
              ),
              _buildSettingsItem(
                icon: Icons.logout,
                title: 'Se déconnecter',
                onTap: _handleLogout,
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
                onTap: _reportBug,
              ),
              _buildSettingsItem(
                icon: Icons.message_outlined,
                title: 'Envoyer des commentaires',
                onTap: _sendFeedback,
              ),
            ],
          ),
        );
      }),
    );
  }

  void _showProfileImagePicker() {
    showModalBottomSheet(
      context: context,
      builder: (context) => const ProfileImagePicker(),
    );
  }

  void _reportBug() {
    // Implement bug reporting functionality
    Get.snackbar(
      'Rapport de bug',
      'Cette fonctionnalité sera bientôt disponible',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void _sendFeedback() {
    // Implement feedback functionality
    Get.snackbar(
      'Feedback',
      'Cette fonctionnalité sera bientôt disponible',
      snackPosition: SnackPosition.BOTTOM,
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
