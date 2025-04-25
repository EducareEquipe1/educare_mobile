enum AppointmentStatus { scheduled, completed, cancelled }

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

  // Add these methods for future backend integration
  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      type: json['type'],
      motif: json['motif'],
      status: AppointmentStatus.values.firstWhere(
        (e) => e.toString() == 'AppointmentStatus.${json['status']}',
      ),
      date: DateTime.parse(json['date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'motif': motif,
      'status': status.toString().split('.').last,
      'date': date.toIso8601String(),
    };
  }
}
