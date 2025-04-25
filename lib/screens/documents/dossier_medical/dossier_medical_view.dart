import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/dossier_medical_controller.dart';

class DossierMedicalView extends StatelessWidget {
  DossierMedicalView({Key? key}) : super(key: key) {
    Get.put(DossierMedicalController());
  }

  final controller = Get.find<DossierMedicalController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      return SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection(
              'DÉTAILS PERSONNELS',
              controller.personalDetails.entries
                  .map((e) => _buildDetailItem(e.key, e.value))
                  .toList(),
            ),
            const SizedBox(height: 24),
            _buildSection(
              'DONNÉES BIOMÉTRIQUES',
              controller.biometricData.entries
                  .map((e) => _buildDetailItem(e.key, e.value))
                  .toList(),
            ),
            const SizedBox(height: 24),
            _buildAntecedentsSection(controller.personalHistory),
            const SizedBox(height: 24),
            _buildMedicalHistorySection(controller.medicalHistory),
          ],
        ),
      );
    });
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4A5568),
              ),
            ),
            const SizedBox(height: 16),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: const TextStyle(
              color: Color(0xFF718096),
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(value, style: const TextStyle(color: Color(0xFF2D3748))),
        ],
      ),
    );
  }

  Widget _buildAntecedentsSection(Map<String, dynamic> history) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'ANTÉCÉDENTS PERSONNELS',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4A5568),
              ),
            ),
            const SizedBox(height: 16),
            _buildCheckItem('à fumer', false),
            _buildCheckItem('à chiquer', false),
            _buildCheckItem('à prise', false),
            _buildCheckItem('Ancien fumeur', false),
            const SizedBox(height: 8),
            _buildDetailItem('Alcool', 'Jamais Consommé'),
            _buildDetailItem('Médicaments', 'Aucune Prise Régulière'),
            _buildDetailItem('Autres', 'Aucun Antécédent Notable'),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckItem(String label, bool value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(color: Color(0xFF718096), fontSize: 14),
            ),
          ),
          const SizedBox(width: 16),
          Row(
            children: [
              Text(
                'Oui',
                style: TextStyle(
                  color: value ? Colors.black87 : const Color(0xFF718096),
                  fontSize: 14,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFF718096), width: 1),
                  borderRadius: BorderRadius.circular(2),
                ),
                child:
                    value
                        ? const Icon(
                          Icons.check,
                          size: 12,
                          color: Color(0xFF718096),
                        )
                        : null,
              ),
              const SizedBox(width: 24),
              Text(
                'Non',
                style: TextStyle(
                  color: !value ? Colors.black87 : const Color(0xFF718096),
                  fontSize: 14,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFF718096), width: 1),
                  borderRadius: BorderRadius.circular(2),
                ),
                child:
                    !value
                        ? const Icon(
                          Icons.check,
                          size: 12,
                          color: Color(0xFF718096),
                        )
                        : null,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMedicalHistorySection(Map<String, List<String>> history) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'ANTÉCÉDENTS MÉDICO-CHIRURGICAUX',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4A5568),
              ),
            ),
            const SizedBox(height: 16),
            ...history.entries.map(
              (e) => _buildMedicalHistoryItem(e.key, e.value),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMedicalHistoryItem(String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF4A5568),
          ),
        ),
        const SizedBox(height: 8),
        ...items.map(
          (item) => Padding(
            padding: const EdgeInsets.only(left: 16, bottom: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '• ',
                  style: TextStyle(
                    color: Color(0xFF718096),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  child: Text(
                    item,
                    style: const TextStyle(color: Color(0xFF718096)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
