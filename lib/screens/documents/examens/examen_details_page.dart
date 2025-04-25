import 'package:flutter/material.dart';
import '../../../models/examen_medical.dart';

class ExamenDetailsPage extends StatelessWidget {
  final ExamenMedical examen;

  const ExamenDetailsPage({Key? key, required this.examen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF2D3748)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Examen Medical',
          style: TextStyle(
            color: Color(0xFF2D3748),
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildSection(
              'EXAMEN PHYSIQUE',
              Column(
                children: [
                  _buildDetailRow('Poids', examen.examenPhysique.poids),
                  _buildDetailRow('Taille', examen.examenPhysique.taille),
                  _buildDetailRow(
                    'Tension Artérielle',
                    examen.examenPhysique.tensionArterielle,
                  ),
                ],
              ),
            ),
            _buildSection(
              'EXAMEN PAR APPAREILS',
              _buildAppareilsSection(examen.examenParAppareils),
            ),
            if (examen.explorationsFonctionnelles.isNotEmpty)
              _buildSection(
                'EXPLORATIONS FONCTIONNELLES',
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:
                      examen.explorationsFonctionnelles
                          .map((e) => _buildBulletPoint(e))
                          .toList(),
                ),
              ),
            if (examen.examensComplementaires.isNotEmpty)
              _buildSection(
                'EXAMENS COMPLÉMENTAIRES',
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:
                      examen.examensComplementaires
                          .map((e) => _buildComplementaireItem(e))
                          .toList(),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, Widget content) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF2D3748),
            ),
          ),
          const SizedBox(height: 16),
          content,
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(fontSize: 12, color: Color(0xFF718096)),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 12, color: Color(0xFF2D3748)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppareilsSection(ExamenParAppareils appareils) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildOphtalmologique(appareils.ophtalmologique),
        _buildORL(appareils.orl),
        _buildSymptomesGroup(
          'NEUROLOGIQUE ET PSYCHISME',
          appareils.neurologiquePsychisme.symptomes,
          ['Céphalées', 'Vertiges', 'Troubles du sommeil'],
        ),
        _buildPeauMuqueuses(appareils.peauMuqueuses),
        _buildSymptomesGroup(
          'APPAREIL LOCOMOTEUR',
          appareils.appareilLocomoteur.symptomes,
          [
            'Douleurs Musculaires',
            'Douleurs Articulaires',
            'Douleurs Neurologiques',
          ],
        ),
        _buildSymptomesGroup(
          'APPAREIL CARDIO-VASCULAIRE',
          appareils.appareilCardioVasculaire.symptomes,
          ['Palpitations', 'Œdèmes', 'Cyanose'],
        ),
        _buildSymptomesGroup(
          'APPAREIL DIGESTIF',
          appareils.appareilDigestif.symptomes,
          ['Pyrosis', 'Vomissements', 'Douleurs abdominales'],
        ),
        _buildSymptomesGroup(
          'APPAREIL GÉNITO-URINAIRE',
          appareils.appareilGenitoUrinaire.symptomes,
          ['Dysurie', 'Hématurie', 'Cycles irréguliers'],
        ),
      ],
    );
  }

  Widget _buildOphtalmologique(Ophtalmologique ophtalmologique) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'OPHTALMOLOGIQUE',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Color(0xFF2D3748),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Acuité Visuelle',
                    style: TextStyle(fontSize: 11, color: Color(0xFFF6AD55)),
                  ),
                  _buildVisualAcuity('OD:', ophtalmologique.acuiteVisuelleOD),
                  _buildVisualAcuity('OG:', ophtalmologique.acuiteVisuelleOG),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Symptômes',
                    style: TextStyle(fontSize: 11, color: Color(0xFF718096)),
                  ),
                  ...['Larmoiement', 'Douleur', 'Taches devant les yeux'].map(
                    (symptom) => _buildCheckbox(
                      symptom,
                      ophtalmologique.symptomes.contains(symptom),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildVisualAcuity(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 11, color: Color(0xFF718096)),
          ),
          const SizedBox(width: 4),
          Text(
            value,
            style: const TextStyle(fontSize: 11, color: Color(0xFF2D3748)),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckbox(String label, bool checked) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, bottom: 4),
      child: Row(
        children: [
          SizedBox(
            width: 16,
            height: 16,
            child: Checkbox(
              value: checked,
              onChanged: null,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              visualDensity: VisualDensity.compact,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontSize: 11, color: Color(0xFF718096)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSymptomesGroup(
    String title,
    List<String> symptomes,
    List<String> labels,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0xFF2D3748),
            ),
          ),
          const SizedBox(height: 8),
          ...labels.map(
            (label) => _buildCheckbox(label, symptomes.contains(label)),
          ),
        ],
      ),
    );
  }

  Widget _buildPeauMuqueuses(PeauMuqueuses peauMuqueuses) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'PEAU ET MUQUEUSES',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Color(0xFF2D3748),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCheckbox('Normal', peauMuqueuses.normal),
                  _buildCheckbox('Anormal', peauMuqueuses.anormal),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                    peauMuqueuses.symptomes
                        .map((symptom) => _buildCheckbox(symptom, true))
                        .toList(),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '• ',
            style: TextStyle(color: Color(0xFF718096), fontSize: 11),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 11, color: Color(0xFF718096)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComplementaireItem(ExamenComplementaire examen) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            examen.type,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0xFF2D3748),
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Expanded(
                child: Text(
                  examen.resultat,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF718096),
                  ),
                ),
              ),
              if (examen.negatif)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE6FFFA),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    'Négatif',
                    style: TextStyle(fontSize: 11, color: Color(0xFF678E90)),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildORL(ORL orl) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'ORL',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Color(0xFF2D3748),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Audition',
                    style: TextStyle(fontSize: 11, color: Color(0xFFF6AD55)),
                  ),
                  _buildAudition('OD:', orl.auditionOD),
                  _buildAudition('OG:', orl.auditionOG),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Symptômes',
                    style: TextStyle(fontSize: 11, color: Color(0xFF718096)),
                  ),
                  ...[
                    'Sifflements',
                    'Angines répétées',
                    'Épistaxis',
                    'Rhinorrhée',
                  ].map(
                    (symptom) => _buildCheckbox(
                      symptom,
                      orl.symptomes.contains(symptom),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildAudition(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 11, color: Color(0xFF718096)),
          ),
          const SizedBox(width: 4),
          Text(
            value,
            style: const TextStyle(fontSize: 11, color: Color(0xFF2D3748)),
          ),
        ],
      ),
    );
  }
}
