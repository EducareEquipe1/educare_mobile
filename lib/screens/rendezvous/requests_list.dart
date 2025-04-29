import 'package:flutter/material.dart';

class RequestsList extends StatelessWidget {
  final List<Map<String, dynamic>> demandes;

  const RequestsList({Key? key, required this.demandes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: demandes.length,
      itemBuilder: (context, index) {
        final demande = demandes[index];
        return _RequestCard(
          motif: demande['motif'],
          date: demande['date'],
          status: demande['status'],
        );
      },
    );
  }
}

class _RequestCard extends StatelessWidget {
  final String motif;
  final DateTime date;
  final String status;

  const _RequestCard({
    required this.motif,
    required this.date,
    required this.status,
  });

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
              motif,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            Text(
              'Demandé le ${_formatDate(date)}',
              style: const TextStyle(color: Color.fromRGBO(113, 128, 150, 1)),
            ),
            const SizedBox(height: 8),
            Text(
              'Statut : $status',
              style: const TextStyle(color: Color(0xFF718096)),
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
