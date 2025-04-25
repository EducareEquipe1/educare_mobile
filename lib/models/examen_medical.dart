class ExamenMedical {
  final String id;
  final String date;
  final ExamenPhysique examenPhysique;
  final ExamenParAppareils examenParAppareils;
  final List<String> explorationsFonctionnelles;
  final List<ExamenComplementaire> examensComplementaires;

  ExamenMedical({
    required this.id,
    required this.date,
    required this.examenPhysique,
    required this.examenParAppareils,
    required this.explorationsFonctionnelles,
    required this.examensComplementaires,
  });
}

class ExamenPhysique {
  final String poids;
  final String taille;
  final String tensionArterielle;

  ExamenPhysique({
    required this.poids,
    required this.taille,
    required this.tensionArterielle,
  });
}

class ExamenParAppareils {
  final Ophtalmologique ophtalmologique;
  final ORL orl;
  final NeurologiquePsychisme neurologiquePsychisme;
  final PeauMuqueuses peauMuqueuses;
  final AppareilLocomoteur appareilLocomoteur;
  final AppareilCardioVasculaire appareilCardioVasculaire;
  final AppareilDigestif appareilDigestif;
  final AppareilGenitoUrinaire appareilGenitoUrinaire;

  ExamenParAppareils({
    required this.ophtalmologique,
    required this.orl,
    required this.neurologiquePsychisme,
    required this.peauMuqueuses,
    required this.appareilLocomoteur,
    required this.appareilCardioVasculaire,
    required this.appareilDigestif,
    required this.appareilGenitoUrinaire,
  });
}

class Ophtalmologique {
  final String acuiteVisuelleOD;
  final String acuiteVisuelleOG;
  final List<String> symptomes;

  Ophtalmologique({
    required this.acuiteVisuelleOD,
    required this.acuiteVisuelleOG,
    required this.symptomes,
  });
}

class ORL {
  final String auditionOD;
  final String auditionOG;
  final List<String> symptomes;

  ORL({
    required this.auditionOD,
    required this.auditionOG,
    required this.symptomes,
  });
}

class NeurologiquePsychisme {
  final List<String> symptomes;

  NeurologiquePsychisme({required this.symptomes});
}

class PeauMuqueuses {
  final bool normal;
  final bool anormal;
  final List<String> symptomes;

  PeauMuqueuses({
    required this.normal,
    required this.anormal,
    required this.symptomes,
  });
}

class AppareilLocomoteur {
  final List<String> symptomes;

  AppareilLocomoteur({required this.symptomes});
}

class AppareilCardioVasculaire {
  final List<String> symptomes;

  AppareilCardioVasculaire({required this.symptomes});
}

class AppareilDigestif {
  final List<String> symptomes;

  AppareilDigestif({required this.symptomes});
}

class AppareilGenitoUrinaire {
  final List<String> symptomes;

  AppareilGenitoUrinaire({required this.symptomes});
}

class ExamenComplementaire {
  final String type;
  final String resultat;
  final bool negatif;

  ExamenComplementaire({
    required this.type,
    required this.resultat,
    required this.negatif,
  });
}
