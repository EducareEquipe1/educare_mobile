import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/consultation_controller.dart';
import '../ordonnances/ordonnance_details_page.dart';
import '../../../models/consultation.dart';
import '../../../models/ordonnance.dart';

class ConsultationDetailsView extends StatefulWidget {
  final Consultation consultation;

  const ConsultationDetailsView({Key? key, required this.consultation})
    : super(key: key);

  @override
  State<ConsultationDetailsView> createState() =>
      _ConsultationDetailsViewState();
}

class _ConsultationDetailsViewState extends State<ConsultationDetailsView> {
  Future<Ordonnance?>? _ordonnanceFuture;

  @override
  void initState() {
    super.initState();
    // Fetch ordonnance when opening the details page
    _ordonnanceFuture = Get.find<ConsultationController>()
        .fetchOrdonnanceForConsultation(widget.consultation.id);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Détails de la Consultation'),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionCard(
              context,
              icon: Icons.info_outline,
              title: 'Informations principales',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _infoRow('Motif', widget.consultation.motif),
                  _infoRow('Date', widget.consultation.date),
                  _infoRow('Type', widget.consultation.type),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _sectionCard(
              context,
              icon: Icons.sick_outlined,
              title: 'Symptômes rapportés',
              child:
                  widget.consultation.symptomes.isNotEmpty
                      ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:
                            widget.consultation.symptomes
                                .map(
                                  (symptom) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 2,
                                    ),
                                    child: Text(
                                      '• $symptom',
                                      style: theme.textTheme.bodyMedium,
                                    ),
                                  ),
                                )
                                .toList(),
                      )
                      : Text(
                        'Aucun symptôme rapporté.',
                        style: theme.textTheme.bodyMedium!.copyWith(
                          color: Colors.grey,
                        ),
                      ),
            ),
            const SizedBox(height: 16),
            _sectionCard(
              context,
              icon: Icons.visibility_outlined,
              title: 'Observations du médecin',
              child: Text(
                widget.consultation.observation.isNotEmpty
                    ? widget.consultation.observation
                    : 'Aucune observation.',
                style: theme.textTheme.bodyMedium,
              ),
            ),
            const SizedBox(height: 16),
            _sectionCard(
              context,
              icon: Icons.medical_services_outlined,
              title: 'Diagnostic',
              child: Text(
                widget.consultation.diagnostic.isNotEmpty
                    ? widget.consultation.diagnostic
                    : 'Aucun diagnostic.',
                style: theme.textTheme.bodyMedium,
              ),
            ),
            const SizedBox(height: 16),
            _sectionCard(
              context,
              icon: Icons.science_outlined,
              title: 'Examens médicaux',
              child:
                  widget.consultation.examens.isNotEmpty
                      ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:
                            widget.consultation.examens
                                .map(
                                  (examen) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 2,
                                    ),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.description_outlined,
                                          color: Colors.blue,
                                          size: 18,
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          examen,
                                          style: theme.textTheme.bodyMedium!
                                              .copyWith(
                                                color: Colors.blue,
                                                decoration:
                                                    TextDecoration.underline,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                                .toList(),
                      )
                      : Text(
                        'Aucun examen médical.',
                        style: theme.textTheme.bodyMedium!.copyWith(
                          color: Colors.grey,
                        ),
                      ),
            ),
            const SizedBox(height: 16),
            _sectionCard(
              context,
              icon: Icons.receipt_long_outlined,
              title: 'Ordonnance',
              child: FutureBuilder<Ordonnance?>(
                future: _ordonnanceFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasError) {
                    return Text(
                      'Erreur lors de la vérification de l\'ordonnance.',
                      style: theme.textTheme.bodyMedium!.copyWith(
                        color: Colors.red,
                      ),
                    );
                  }
                  final ordonnance = snapshot.data;
                  if (ordonnance != null) {
                    return GestureDetector(
                      onTap: () {
                        Get.to(
                          () => OrdonnanceDetailsPage(ordonnance: ordonnance),
                        );
                      },
                      child: Row(
                        children: [
                          const Icon(
                            Icons.description_outlined,
                            color: Colors.blue,
                            size: 18,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Voir l\'ordonnance complète',
                            style: theme.textTheme.bodyMedium!.copyWith(
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Text(
                      'Aucune ordonnance associée.',
                      style: theme.textTheme.bodyMedium!.copyWith(
                        color: Colors.grey,
                      ),
                    );
                  }
                },
              ),
            ),
            const SizedBox(height: 16),
            _sectionCard(
              context,
              icon: Icons.attach_file_outlined,
              title: 'Pièces jointes',
              child: GestureDetector(
                onTap: () {
                  // TODO: Handle file opening logic here
                },
                child: Row(
                  children: [
                    const Icon(
                      Icons.picture_as_pdf,
                      color: Colors.red,
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'rapport-examen.pdf',
                      style: theme.textTheme.bodyMedium!.copyWith(
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

  Widget _sectionCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required Widget child,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      color: const Color(0xFFF7FAFC),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: const Color(0xFF2D3748)),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xFF2D3748),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            child,
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Text(
            '$label : ',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Color(0xFF718096),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                color: Color(0xFF2D3748),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
