import 'package:flutter/material.dart';

class RequestsList extends StatelessWidget {
  const RequestsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: dummyRequests.length,
      itemBuilder: (context, index) {
        return _RequestCard(request: dummyRequests[index]);
      },
    );
  }
}

class AppointmentRequest {
  final String motif;
  final DateTime date;
  final String status;

  AppointmentRequest({
    required this.motif,
    required this.date,
    required this.status,
  });
}

final List<AppointmentRequest> dummyRequests = [
  AppointmentRequest(
    motif: 'Maux de tête et fièvre légère depuis 3 jours',
    date: DateTime(2025, 4, 22),
    status: 'En attente',
  ),
];

class _RequestCard extends StatelessWidget {
  final AppointmentRequest request;

  const _RequestCard({required this.request});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              request.motif,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            Text(
              'Demandé le ${_formatDate(request.date)}',
              style: const TextStyle(color: Color.fromRGBO(113, 128, 150, 1)),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
