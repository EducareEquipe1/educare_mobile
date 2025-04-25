import 'package:flutter/material.dart';
import '../../../models/examen_medical.dart';
import 'examen_details_page.dart';

final List<ExamenMedical> dummyExamens = [
  ExamenMedical(
    id: '1',
    date: '25/04/2025',
    examenPhysique: ExamenPhysique(
      poids: '60 Kg',
      taille: '168 Cm',
      tensionArterielle: '120/80',
    ),
    examenParAppareils: ExamenParAppareils(
      ophtalmologique: Ophtalmologique(
        acuiteVisuelleOD: '10/10',
        acuiteVisuelleOG: '10/10',
        symptomes: ['Larmoiement'],
      ),
      orl: ORL(
        auditionOD: 'Normale',
        auditionOG: 'Normale',
        symptomes: ['Rhinorrhée'],
      ),
      neurologiquePsychisme: NeurologiquePsychisme(
        symptomes: ['État de conscience', 'Orientation'],
      ),
      peauMuqueuses: PeauMuqueuses(normal: true, anormal: false, symptomes: []),
      appareilLocomoteur: AppareilLocomoteur(
        symptomes: ['Marche', 'Mobilité articulaire'],
      ),
      appareilCardioVasculaire: AppareilCardioVasculaire(
        symptomes: ['Fréquence cardiaque', 'Auscultation'],
      ),
      appareilDigestif: AppareilDigestif(symptomes: ['Palpation abdominale']),
      appareilGenitoUrinaire: AppareilGenitoUrinaire(symptomes: []),
    ),
    explorationsFonctionnelles: [
      'ECG: Rythme sinusal régulier',
      'Spirométrie: Normale',
    ],
    examensComplementaires: [
      ExamenComplementaire(
        type: 'Sérologie',
        resultat: 'Absence d\'anticorps spécifiques',
        negatif: true,
      ),
      ExamenComplementaire(
        type: 'Radiographie Thoracique',
        resultat: 'Absence d\'anomalies significatives',
        negatif: true,
      ),
    ],
  ),
  ExamenMedical(
    id: '2',
    date: '15/03/2025',
    examenPhysique: ExamenPhysique(
      poids: '59.5 Kg',
      taille: '168 Cm',
      tensionArterielle: '118/78',
    ),
    examenParAppareils: ExamenParAppareils(
      ophtalmologique: Ophtalmologique(
        acuiteVisuelleOD: '9/10',
        acuiteVisuelleOG: '10/10',
        symptomes: [],
      ),
      orl: ORL(
        auditionOD: 'Normale',
        auditionOG: 'Normale',
        symptomes: ['Rhinoscopie'],
      ),
      neurologiquePsychisme: NeurologiquePsychisme(
        symptomes: ['Mémoire', 'Attention'],
      ),
      peauMuqueuses: PeauMuqueuses(normal: true, anormal: false, symptomes: []),
      appareilLocomoteur: AppareilLocomoteur(
        symptomes: ['Rachis', 'Force musculaire'],
      ),
      appareilCardioVasculaire: AppareilCardioVasculaire(
        symptomes: ['Pouls périphériques'],
      ),
      appareilDigestif: AppareilDigestif(symptomes: ['Transit', 'Foie']),
      appareilGenitoUrinaire: AppareilGenitoUrinaire(symptomes: []),
    ),
    explorationsFonctionnelles: ['Test d\'effort: Normal'],
    examensComplementaires: [
      ExamenComplementaire(
        type: 'Bilan sanguin',
        resultat: 'Valeurs dans les normes',
        negatif: true,
      ),
    ],
  ),
];

class ExamensMedicauxView extends StatelessWidget {
  const ExamensMedicauxView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: dummyExamens.length,
      itemBuilder: (context, index) {
        final examen = dummyExamens[index];
        return ExamenCard(examen: examen);
      },
    );
  }
}

class ExamenCard extends StatelessWidget {
  final ExamenMedical examen;

  const ExamenCard({Key? key, required this.examen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade100, width: 1),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap:
            () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ExamenDetailsPage(examen: examen),
              ),
            ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE6FFFA),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.medical_services_outlined,
                      color: Color(0xFF678E90),
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Examen du ${examen.date}',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF2D3748),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Poids: ${examen.examenPhysique.poids} • Taille: ${examen.examenPhysique.taille}',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildTag('Examen Physique', Icons.accessibility_new),
                    const SizedBox(width: 8),
                    _buildTag('Appareils', Icons.medical_information),
                    if (examen.examensComplementaires.isNotEmpty) ...[
                      const SizedBox(width: 8),
                      _buildTag('Examens Comp.', Icons.science_outlined),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTag(String text, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFE6FFFA).withOpacity(0.7),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF678E90).withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: const Color(0xFF678E90)),
          const SizedBox(width: 6),
          Text(
            text,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Color(0xFF678E90),
            ),
          ),
        ],
      ),
    );
  }
}
