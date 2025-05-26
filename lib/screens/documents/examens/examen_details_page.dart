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
          'Examen Médical',
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
                  _buildDetailRow('Poids', examen.poids?.toString() ?? ''),
                  _buildDetailRow('Taille', examen.taille?.toString() ?? ''),
                  _buildDetailRow('IMC', examen.imc?.toString() ?? ''),
                  _buildDetailRow('Tension', examen.tension?.toString() ?? ''),
                ],
              ),
            ),
            _buildSection(
              'OPHTALMOLOGIQUE',
              Column(
                children: [
                  _buildDetailRow(
                    'Vision OD',
                    examen.visionD?.toString() ?? '',
                  ),
                  _buildDetailRow(
                    'Vision OG',
                    examen.visionG?.toString() ?? '',
                  ),
                  _buildCheckbox('Larmoiement', examen.larmoiement == 1),
                  _buildCheckbox('Douleur', examen.douleurs == 1),
                  _buildCheckbox(
                    'Taches devant les yeux',
                    examen.tachesYeux == 1,
                  ),
                ],
              ),
            ),
            _buildSection(
              'ORL',
              Column(
                children: [
                  _buildDetailRow(
                    'Audition OD',
                    examen.auditionD?.toString() ?? '',
                  ),
                  _buildDetailRow(
                    'Audition OG',
                    examen.auditionG?.toString() ?? '',
                  ),
                  _buildCheckbox('Sifflements', examen.sifflements == 1),
                  _buildCheckbox('Angines répétées', examen.angines == 1),
                  _buildCheckbox('Épistaxis', examen.epistaxis == 1),
                  _buildCheckbox('Rhinorrhée', examen.rhinorrhee == 1),
                ],
              ),
            ),
            _buildSection(
              'NEUROLOGIQUE ET PSYCHISME',
              Column(
                children: [
                  _buildCheckbox('Céphalées', examen.cephalies == 1),
                  _buildCheckbox('Vertiges', examen.vertiges == 1),
                  _buildCheckbox(
                    'Troubles du sommeil',
                    examen.troublesSommeil == 1,
                  ),
                ],
              ),
            ),
            _buildSection(
              'PEAU ET MUQUEUSES',
              Column(
                children: [
                  _buildCheckbox('Normal', examen.peauNormal == 1),
                  _buildCheckbox('Anormal', examen.peauAnormale == 1),
                ],
              ),
            ),
            _buildSection(
              'APPAREIL LOCOMOTEUR',
              Column(
                children: [
                  _buildCheckbox(
                    'Douleurs Musculaires',
                    examen.douleursMusculaires == 1,
                  ),
                  _buildCheckbox(
                    'Douleurs Articulaires',
                    examen.douleursArticulaires == 1,
                  ),
                  _buildCheckbox(
                    'Douleurs Neurologiques',
                    examen.douleursNeurologiques == 1,
                  ),
                ],
              ),
            ),
            _buildSection(
              'APPAREIL RESPIRATOIRE',
              Column(
                children: [
                  _buildCheckbox('Toux', examen.toux == 1),
                  _buildCheckbox('Dyspnée', examen.dyspnee == 1),
                  _buildDetailRow(
                    'Fonction respiratoire',
                    examen.fonctionRespiratoire ?? '',
                  ),
                ],
              ),
            ),
            _buildSection(
              'APPAREIL CARDIO-VASCULAIRE',
              Column(
                children: [
                  _buildCheckbox(
                    'Douleurs thoraciques',
                    examen.douleursThoraciques == 1,
                  ),
                  _buildCheckbox('Palpitations', examen.palpitations == 1),
                  _buildCheckbox('Œdèmes', examen.oedemes == 1),
                  _buildCheckbox('Cyanose', examen.cyanose == 1),
                  _buildDetailRow(
                    'Fonction circulatoire',
                    examen.fonctionCirculatoire ?? '',
                  ),
                ],
              ),
            ),
            _buildSection(
              'APPAREIL DIGESTIF',
              Column(
                children: [
                  _buildCheckbox('Pyrosis', examen.pyrosis == 1),
                  _buildCheckbox('Vomissements', examen.vomissements == 1),
                  _buildCheckbox(
                    'Douleurs abdominales',
                    examen.douleursAbdominales == 1,
                  ),
                ],
              ),
            ),
            _buildSection(
              'APPAREIL GÉNITO-URINAIRE',
              Column(
                children: [
                  _buildCheckbox('Dysurie', examen.dysurie == 1),
                  _buildCheckbox('Hématurie', examen.hematurie == 1),
                  _buildCheckbox(
                    'Cycles irréguliers',
                    examen.cyclesIrreguliers == 1,
                  ),
                  _buildDetailRow(
                    'Fonction motrice',
                    examen.fonctionMotrice ?? '',
                  ),
                ],
              ),
            ),
            _buildSection(
              'EXAMENS COMPLÉMENTAIRES',
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if ((examen.sanguins ?? '').isNotEmpty)
                    _buildDetailRow('Sanguins', examen.sanguins!),
                  if ((examen.urinaires ?? '').isNotEmpty)
                    _buildDetailRow('Urinaires', examen.urinaires!),
                  if ((examen.radiologiques ?? '').isNotEmpty)
                    _buildDetailRow('Radiologiques', examen.radiologiques!),
                  _buildCheckbox('Hépatites positif', examen.hepatitesPos == 1),
                  _buildCheckbox('Hépatites négatif', examen.hepatitesNeg == 1),
                  _buildCheckbox('Syphilis positif', examen.syphilisPos == 1),
                  _buildCheckbox('Syphilis négatif', examen.syphilisNeg == 1),
                  _buildCheckbox('VIH positif', examen.vihPos == 1),
                  _buildCheckbox('VIH négatif', examen.vihNeg == 1),
                ],
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
            width: 150,
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
}
