import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../models/notification_model.dart';
import '../main.dart'; // for showNotification
import 'user_controller.dart';

class NotificationController extends GetxController {
  Timer? _pollingTimer;
  int? lastNotificationId;

  @override
  void onInit() {
    super.onInit();
    fetchNotifications();
    _pollingTimer = Timer.periodic(const Duration(seconds: 30), (timer) {
      fetchNotifications();
    });
  }

  @override
  void onClose() {
    _pollingTimer?.cancel();
    super.onClose();
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

        if (loaded.isNotEmpty &&
            loaded.first.id != lastNotificationId &&
            lastNotificationId != null) {
          await showNotification(loaded.first.title, loaded.first.content);
        }
        if (loaded.isNotEmpty) {
          lastNotificationId = loaded.first.id;
        }
      }
    } catch (e) {
      // handle error
    }
  }
}
