import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widgets/notification_card.dart';
import '../../../controllers/user_controller.dart';
import '../../widgets/profile_avatar.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final List<Map<String, dynamic>> notifications = [
    {
      'title': 'Demande acceptée',
      'message':
          'Votre demande de rendez-vous a été acceptée. Le médecin fixera la date prochainement.',
      'date': DateTime(2025, 4, 17, 12, 5),
      'type': NotificationType.accepted,
    },
    {
      'title': 'Demande refusée',
      'message': 'Votre demande de rendez-vous a été refusée par le médecin.',
      'date': DateTime(2025, 4, 19, 17, 30),
      'type': NotificationType.refused,
    },
    {
      'title': 'Rendez-vous programmé',
      'message': 'Un rendez-vous est prévu le 25 avril à 15:00.',
      'date': DateTime(2025, 4, 20, 10, 45),
      'type': NotificationType.scheduled,
    },
    {
      'title': 'Rendez-vous programmé',
      'message': 'Un rendez-vous est prévu le 26 avril à 15:00.',
      'date': DateTime(2025, 4, 20, 10, 45),
      'type': NotificationType.scheduled,
    },
  ];

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
                    notifications.isEmpty
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
                              title: notification['title'] as String,
                              message: notification['message'] as String,
                              date: notification['date'] as DateTime,
                              type: notification['type'] as NotificationType,
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
