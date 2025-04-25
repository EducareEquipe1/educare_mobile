import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum NotificationType { accepted, refused, scheduled }

class NotificationCard extends StatelessWidget {
  final String title;
  final String message;
  final DateTime date;
  final NotificationType type;

  const NotificationCard({
    Key? key,
    required this.title,
    required this.message,
    required this.date,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 0,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: _getColorForType(type),
                  ),
                ),
                Text(
                  _formatDate(date),
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color.fromRGBO(113, 128, 150, 1),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: const TextStyle(
                fontSize: 14,
                color: Color.fromRGBO(45, 55, 72, 1),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getColorForType(NotificationType type) {
    switch (type) {
      case NotificationType.accepted:
        return const Color.fromRGBO(72, 187, 120, 1);
      case NotificationType.refused:
        return const Color.fromRGBO(229, 62, 62, 1);
      case NotificationType.scheduled:
        return const Color.fromRGBO(66, 153, 225, 1);
    }
  }

  String _formatDate(DateTime date) {
    final formatter = DateFormat('dd MMMM yyyy à HH:mm', 'fr_FR');
    return formatter.format(date);
  }
}
