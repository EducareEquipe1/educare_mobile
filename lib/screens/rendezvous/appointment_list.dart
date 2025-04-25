import 'package:flutter/material.dart';

class AppointmentList extends StatelessWidget {
  const AppointmentList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: dummyAppointments.length,
      itemBuilder: (context, index) {
        return _AppointmentCard(appointment: dummyAppointments[index]);
      },
    );
  }
}

class Appointment {
  final String type;
  final String motif;
  final AppointmentStatus status;
  final DateTime date;

  Appointment({
    required this.type,
    required this.motif,
    required this.status,
    required this.date,
  });
}

enum AppointmentStatus { scheduled, completed, cancelled }

// Dummy data for testing
final List<Appointment> dummyAppointments = [
  Appointment(
    type: 'Consultation',
    motif: 'Maux de tête et fièvre légère depuis 3 jours',
    status: AppointmentStatus.scheduled,
    date: DateTime(2025, 4, 22, 10, 0),
  ),
  Appointment(
    type: 'Consultation',
    motif: 'Suivi traitement',
    status: AppointmentStatus.completed,
    date: DateTime(2025, 4, 20, 15, 30),
  ),
];

class _AppointmentCard extends StatelessWidget {
  final Appointment appointment;

  const _AppointmentCard({required this.appointment});

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  appointment.type,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildStatusButton(appointment.status),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              appointment.motif,
              style: const TextStyle(color: Color.fromRGBO(113, 128, 150, 1)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusButton(AppointmentStatus status) {
    Color color;
    String text;

    switch (status) {
      case AppointmentStatus.scheduled:
        color = const Color.fromRGBO(103, 146, 148, 1);
        text = 'Programmé';
        break;
      case AppointmentStatus.completed:
        color = const Color.fromRGBO(72, 187, 120, 1);
        text = 'Terminé';
        break;
      case AppointmentStatus.cancelled:
        color = const Color.fromRGBO(229, 62, 62, 1);
        text = 'Annulé';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
