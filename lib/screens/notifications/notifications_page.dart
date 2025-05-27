import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/notification_model.dart';
import '../../widgets/notification_card.dart';
import '../../../controllers/user_controller.dart';
import '../../widgets/profile_avatar.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  List<AppNotification> notifications = [];
  bool isLoading = true;
  bool notificationsEnabled = true; // Add this

  @override
  void initState() {
    super.initState();
    _checkNotificationSetting();
  }

  Future<void> _checkNotificationSetting() async {
    final prefs = await SharedPreferences.getInstance();
    notificationsEnabled = prefs.getBool('notifications_enabled') ?? true;
    if (notificationsEnabled) {
      fetchNotifications();
    } else {
      setState(() {
        isLoading = false;
        notifications = [];
      });
    }
  }

  Future<void> fetchNotifications() async {
    final email = Get.find<UserController>().user?.email;
    if (email == null) return;
    final url =
        'https://educare-backend-l6ue.onrender.com/notifications/$email';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<AppNotification> loaded =
            (data['notifications'] as List)
                .map((n) => AppNotification.fromJson(n))
                .toList();
        setState(() {
          notifications = loaded;
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Notifications',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(45, 55, 72, 1),
                    ),
                  ),
                  Obx(
                    () => ProfileAvatar(
                      imageUrl: Get.find<UserController>().user?.profileImage,
                      radius: 20,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Expanded(
                child:
                    isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : !notificationsEnabled
                        ? const Center(
                          child: Text(
                            'Notifications désactivées',
                            style: TextStyle(
                              color: Color.fromRGBO(113, 128, 150, 1),
                              fontSize: 16,
                            ),
                          ),
                        )
                        : notifications.isEmpty
                        ? const Center(
                          child: Text(
                            'Aucune notification',
                            style: TextStyle(
                              color: Color.fromRGBO(113, 128, 150, 1),
                              fontSize: 16,
                            ),
                          ),
                        )
                        : ListView.builder(
                          itemCount: notifications.length,
                          itemBuilder: (context, index) {
                            final notification = notifications[index];
                            return NotificationCard(
                              title: notification.title,
                              message: notification.content,
                              date: notification.date,
                              type: notification.type,
                            );
                          },
                        ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
