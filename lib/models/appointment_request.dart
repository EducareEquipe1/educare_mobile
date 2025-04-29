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
  AppointmentRequest(
    motif: 'Douleur au dos persistante',
    date: DateTime(2025, 4, 25),
    status: 'Confirmé',
  ),
];
