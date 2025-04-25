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

  factory Consultation.fromJson(Map<String, dynamic> json) {
    return Consultation(
      motif: json['motif'] ?? '',
      date: json['date'] ?? '',
      type: json['type'] ?? '',
      symptomes: List<String>.from(json['symptomes'] ?? []),
      observation: json['observation'] ?? '',
      diagnostic: json['diagnostic'] ?? '',
      examens: List<String>.from(json['examens'] ?? []),
      hasOrdonnance: json['hasOrdonnance'] ?? false,
    );
  }
}
