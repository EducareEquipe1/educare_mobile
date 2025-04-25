import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../ordonnances/ordonnance_details_page.dart';
import '../examens/examen_details_page.dart';
import '../../../models/consultation.dart';
import '../../../models/ordonnance.dart';
import '../../../models/examen_medical.dart';

class ConsultationDetailsView extends StatelessWidget {
  final Consultation consultation;

  const ConsultationDetailsView({Key? key, required this.consultation})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Consultation Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Motif: ${consultation.motif}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('Date: ${consultation.date}'),
            const SizedBox(height: 8),
            Text('Type: ${consultation.type}'),
            const SizedBox(height: 16),
            const Text(
              'Symptômes:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            ...consultation.symptomes.map((symptom) => Text('- $symptom')),
            const SizedBox(height: 16),
            const Text(
              'Observation:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(consultation.observation),
            const SizedBox(height: 16),
            const Text(
              'Diagnostic:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(consultation.diagnostic),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                // Navigate to OrdonnanceDetailsPage with dummy data
                Get.to(
                  () => OrdonnanceDetailsPage(
                    ordonnance: Ordonnance(
                      patientName: 'Zerguerras',
                      patientFirstName: 'Khayra Sarra',
                      address: 'Adresse Exemple',
                      date: consultation.date,
                      age: 20,
                      medications: [
                        Medication(
                          name: 'Paracétamol 1 G COMP.',
                          dosage: '1 comprimé, chaque 6h',
                          duration: '5 jours',
                        ),
                        Medication(
                          name: 'Amoxicilline 1 G COMP.',
                          dosage: '1 comprimé, 3 fois/jour',
                          duration: '5 jours',
                        ),
                      ],
                      id: '1',
                    ),
                  ),
                );
              },
              child: const Text(
                'Ordonnance',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Examens:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            ...consultation.examens.map(
              (examen) => GestureDetector(
                onTap: () {
                  // Navigate to ExamenDetailsPage with dummy data
                  Get.to(
                    () => ExamenDetailsPage(
                      examen: ExamenMedical(
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
                          peauMuqueuses: PeauMuqueuses(
                            normal: true,
                            anormal: false,
                            symptomes: [],
                          ),
                          appareilLocomoteur: AppareilLocomoteur(
                            symptomes: ['Marche', 'Mobilité articulaire'],
                          ),
                          appareilCardioVasculaire: AppareilCardioVasculaire(
                            symptomes: ['Fréquence cardiaque', 'Auscultation'],
                          ),
                          appareilDigestif: AppareilDigestif(
                            symptomes: ['Palpation abdominale'],
                          ),
                          appareilGenitoUrinaire: AppareilGenitoUrinaire(
                            symptomes: [],
                          ),
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
                        id: '1',
                        date: '15/03/2025',
                      ),
                    ),
                  );
                },
                child: Text(
                  '- $examen',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
