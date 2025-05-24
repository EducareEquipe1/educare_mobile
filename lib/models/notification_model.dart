enum NotificationType { accepted, refused, scheduled, other }

class AppNotification {
  final String title;
  final String content;
  final DateTime date;
  final NotificationType type;

  AppNotification({
    required this.title,
    required this.content,
    required this.date,
    required this.type,
  });

  factory AppNotification.fromJson(Map<String, dynamic> json) {
    NotificationType type;
    switch (json['type']) {
      case 'accepted':
        type = NotificationType.accepted;
        break;
      case 'refused':
        type = NotificationType.refused;
        break;
      case 'scheduled':
        type = NotificationType.scheduled;
        break;
      default:
        type = NotificationType.other;
    }
    return AppNotification(
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      date: DateTime.parse(json['created_at']),
      type: type,
    );
  }
}
