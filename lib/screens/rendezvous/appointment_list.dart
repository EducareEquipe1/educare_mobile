import 'package:educare/screens/documents/dossier_medical/dossier_medical_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/dossier_medical_controller.dart';
import '../../models/appointment.dart';

class DocumentsPage extends StatelessWidget {
  const DocumentsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(DossierMedicalController());

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Mes Documents',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2D3748),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: CircleAvatar(
                backgroundImage: const AssetImage(
                  'assets/images/default_pic.png',
                ),
                radius: 20,
              ),
            ),
          ],
          bottom: const TabBar(
            tabs: [Tab(text: 'Dossier'), Tab(text: 'Consultations')],
            labelColor: Color(0xFF2D3748),
            unselectedLabelColor: Color(0xFF718096),
            indicatorColor: Color(0xFF679294),
          ),
        ),
        body: TabBarView(
          children: [DossierMedicalView(), const ConsultationsView()],
        ),
      ),
    );
  }
}

class AppointmentList extends StatelessWidget {
  const AppointmentList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: dummyAppointments.length,
      itemBuilder: (context, index) {
        return AppointmentCard(appointment: dummyAppointments[index]);
      },
    );
  }
}

class AppointmentCard extends StatelessWidget {
  final Appointment appointment;

  const AppointmentCard({Key? key, required this.appointment})
    : super(key: key);

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
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2D3748),
                  ),
                ),
                _buildStatusChip(appointment.status),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              appointment.motif,
              style: const TextStyle(fontSize: 14, color: Color(0xFF718096)),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(
                  Icons.calendar_today,
                  size: 16,
                  color: Color(0xFF718096),
                ),
                const SizedBox(width: 8),
                Text(
                  _formatDateTime(appointment.date),
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF718096),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(AppointmentStatus status) {
    Color backgroundColor;
    Color textColor;
    String text;

    switch (status) {
      case AppointmentStatus.scheduled:
        backgroundColor = const Color(0xFFE6FFE6);
        textColor = const Color(0xFF22543D);
        text = 'Programmé';
        break;
      case AppointmentStatus.completed:
        backgroundColor = const Color(0xFFE6E6FF);
        textColor = const Color(0xFF3730A3);
        text = 'Terminé';
        break;
      case AppointmentStatus.cancelled:
        backgroundColor = const Color(0xFFFFE6E6);
        textColor = const Color(0xFF9B1C1C);
        text = 'Annulé';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    final day = dateTime.day.toString().padLeft(2, '0');
    final month = dateTime.month.toString().padLeft(2, '0');
    final year = dateTime.year;
    final hour = dateTime.hour.toString().padLeft(2, '0');
    final minute = dateTime.minute.toString().padLeft(2, '0');

    return '$day/$month/$year à $hour:$minute';
  }
}

class Consultation {
  final String motif;
  final String date;
  final String type;
  final List<String> symptomes;
  final String observation;
  final String diagnostic;
  final List<String> examens;
  final bool hasOrdonnance;

  Consultation({
    required this.motif,
    required this.date,
    required this.type,
    required this.symptomes,
    required this.observation,
    required this.diagnostic,
    required this.examens,
    required this.hasOrdonnance,
  });
}

// TODO: Move this to a service or repository later
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

class ConsultationsView extends StatelessWidget {
  const ConsultationsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: dummyConsultations.length,
      itemBuilder: (context, index) {
        return ConsultationCard(consultation: dummyConsultations[index]);
      },
    );
  }
}

class ConsultationCard extends StatelessWidget {
  final Consultation consultation;

  const ConsultationCard({Key? key, required this.consultation})
    : super(key: key);

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
                  consultation.motif,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2D3748),
                  ),
                ),
                _buildTypeChip(consultation.type),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(
                  Icons.calendar_today,
                  size: 16,
                  color: Color(0xFF718096),
                ),
                const SizedBox(width: 8),
                Text(
                  consultation.date,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF718096),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Symptômes rapportés',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2D3748),
              ),
            ),
            const SizedBox(height: 8),
            ...consultation.symptomes.map(
              (symptom) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  children: [
                    const Icon(Icons.circle, size: 6, color: Color(0xFF718096)),
                    const SizedBox(width: 8),
                    Text(
                      symptom,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF718096),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (consultation.hasOrdonnance) ...[
              const SizedBox(height: 16),
              OutlinedButton.icon(
                onPressed: () {
                  // TODO: Navigate to ordonnance details
                },
                icon: const Icon(Icons.description_outlined),
                label: const Text('Voir l\'ordonnance'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF679294),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildTypeChip(String type) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFE6FFFA),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        type,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: Color(0xFF679294),
        ),
      ),
    );
  }
}

// Dummy data for testing
final List<Consultation> dummyConsultations = [
  Consultation(
    motif: 'Maux de tête',
    date: '08 Avril 2025',
    type: 'Urgence',
    symptomes: ['Maux de tête', 'Fièvre modérée', 'Fatigue générale'],
    observation:
        'L\'étudiante présente des maux de tête persistants depuis 3 jours avec une température de 38.2°C',
    diagnostic: 'Syndrome grippal bénin',
    examens: ['Examen clinique', 'Dépistage COVID'],
    hasOrdonnance: true,
  ),
];
