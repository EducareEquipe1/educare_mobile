import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../ordonnances/ordonnance_details_page.dart';
import '../examens/examen_details_page.dart';
import '../../../models/consultation.dart';
import '../../../models/ordonnance.dart';
import '../../../models/examen_medical.dart'
    show
        ExamenMedical,
        ExamenParAppareils,
        ExamenPhysique,
        Ophtalmologique,
        ORL,
        NeurologiquePsychisme,
        PeauMuqueuses,
        AppareilLocomoteur,
        AppareilCardioVasculaire,
        AppareilDigestif,
        AppareilGenitoUrinaire;

class ConsultationDetailsView extends StatelessWidget {
  final Consultation consultation;

  const ConsultationDetailsView({Key? key, required this.consultation})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Détails de la Consultation'),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Motif, Date, and Type
            _buildHeaderSection(),
            const SizedBox(height: 16),

            // Symptômes rapportés
            _buildSection(
              title: 'Symptômes rapportés',
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                    consultation.symptomes
                        .map((symptom) => Text('• $symptom'))
                        .toList(),
              ),
            ),
            const SizedBox(height: 16),

            // Observations du médecin
            _buildSection(
              title: 'Observations du médecin',
              content: Text(consultation.observation),
            ),
            const SizedBox(height: 16),

            // Diagnostic
            _buildSection(
              title: 'Diagnostic',
              content: Text('• ${consultation.diagnostic}'),
            ),
            const SizedBox(height: 16),

            // Examens Médicaux
            _buildSection(
              title: 'Examens Médicaux',
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                    consultation.examens.map((examen) {
                      return GestureDetector(
                        onTap: () {
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
                                    symptomes: [
                                      'État de conscience',
                                      'Orientation',
                                    ],
                                  ),
                                  peauMuqueuses: PeauMuqueuses(
                                    normal: true,
                                    anormal: false,
                                    symptomes: [],
                                  ),
                                  appareilLocomoteur: AppareilLocomoteur(
                                    symptomes: [
                                      'Marche',
                                      'Mobilité articulaire',
                                    ],
                                  ),
                                  appareilCardioVasculaire:
                                      AppareilCardioVasculaire(
                                        symptomes: [
                                          'Fréquence cardiaque',
                                          'Auscultation',
                                        ],
                                      ),
                                  appareilDigestif: AppareilDigestif(
                                    symptomes: ['Palpation abdominale'],
                                  ),
                                  appareilGenitoUrinaire:
                                      AppareilGenitoUrinaire(symptomes: []),
                                ),
                                explorationsFonctionnelles: [],
                                examensComplementaires: [],
                                id: '1',
                                date: '15/03/2025',
                              ),
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            const Icon(
                              Icons.description_outlined,
                              color: Colors.blue,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              examen,
                              style: const TextStyle(
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
              ),
            ),
            const SizedBox(height: 16),

            // Ordonnance
            _buildSection(
              title: 'Ordonnance',
              content: GestureDetector(
                onTap: () {
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
                child: Row(
                  children: [
                    const Icon(Icons.description_outlined, color: Colors.blue),
                    const SizedBox(width: 8),
                    const Text(
                      'Voir l\'ordonnance complète',
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Pièces Jointes
            _buildSection(
              title: 'Pièces Jointes',
              content: GestureDetector(
                onTap: () {
                  // Handle file opening logic here
                },
                child: Row(
                  children: [
                    const Icon(Icons.picture_as_pdf, color: Colors.red),
                    const SizedBox(width: 8),
                    const Text(
                      'rapport-examen.pdf',
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Motif : ${consultation.motif}',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Text(
              'Date : ${consultation.date}',
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(width: 16),
            Row(
              children: [
                const Icon(
                  Icons.warning_amber_rounded,
                  size: 16,
                  color: Colors.orange,
                ),
                const SizedBox(width: 4),
                Text(
                  consultation.type,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSection({required String title, required Widget content}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        content,
      ],
    );
  }
}
