class Ordonnance {
  final String id;
  final String patientName;
  final String patientFirstName;
  final String address;
  final String date;
  final int age;
  final List<Medication> medications;

  Ordonnance({
    required this.id,
    required this.patientName,
    required this.patientFirstName,
    required this.address,
    required this.date,
    required this.age,
    required this.medications,
  });
}

class Medication {
  final String name;
  final String dosage;
  final String duration;

  Medication({
    required this.name,
    required this.dosage,
    required this.duration,
  });
}
