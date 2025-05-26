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
    // Handle symptomes as String or List
    final rawSymptomes = json['symptomes'];
    List<String> symptomesList;
    if (rawSymptomes == null) {
      symptomesList = [];
    } else if (rawSymptomes is String) {
      // If comma-separated, split; otherwise, wrap in a list
      symptomesList =
          rawSymptomes.trim().isEmpty
              ? []
              : rawSymptomes.contains(',')
              ? rawSymptomes.split(',').map((s) => s.trim()).toList()
              : [rawSymptomes.trim()];
    } else if (rawSymptomes is Iterable) {
      symptomesList = rawSymptomes.map((e) => e.toString()).toList();
    } else {
      symptomesList = [];
    }

    return Consultation(
      motif: json['motif'] ?? '',
      date: json['date'] ?? '',
      type: json['type'] ?? '',
      symptomes: symptomesList,
      observation: json['observation'] ?? '',
      diagnostic: json['diagnostic'] ?? '',
      examens: List<String>.from(json['examens'] ?? []),
      hasOrdonnance: json['hasOrdonnance'] ?? false,
    );
  }
}
