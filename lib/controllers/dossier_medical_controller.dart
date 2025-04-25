import 'dart:ui';

import 'package:get/get.dart';

class DossierMedicalController extends GetxController {
  final isLoading = true.obs;
  final personalDetails = RxMap<String, String>();
  final biometricData = RxMap<String, String>();
  final personalHistory = RxMap<String, dynamic>();
  final medicalHistory = RxMap<String, List<String>>();

  @override
  void onInit() {
    super.onInit();
    fetchDossierMedical();
  }

  Future<void> fetchDossierMedical() async {
    try {
      isLoading.value = true;
      // TODO: Implement API call to fetch medical file
      await Future.delayed(const Duration(seconds: 2)); // Simulate API call

      // Simulate data from backend
      personalDetails.value = {
        'N° Dossier': '54556',
        'Groupe Sanguin': 'O+',
        'Date de Naissance': '12/04/1995',
        // ...other details
      };

      biometricData.value = {'Taille': '168 cm', 'Poids': '62 Kg'};

      personalHistory.value = {
        'à fumer': false,
        'à chiquer': false,
        'à prise': false,
        'Ancien fumeur': false,
        'Alcool': 'Jamais Consommé',
        'Médicaments': 'Aucune Prise Régulière',
        'Autres': 'Aucun Antécédent Notable',
      };

      medicalHistory.value = {
        'Affections congénitales': [
          'Syndactylie (Deuxième Et Troisième Orteils Fusionnés, Asymptomatique)',
          'Légère Scoliose Détectée À l\'adolescence, Non Évolutive',
        ],
        // ...other medical history
      };
    } catch (e) {
      Get.snackbar(
        'Erreur',
        'Impossible de charger le dossier médical',
        backgroundColor: const Color(0xFFFFE6E6),
        colorText: const Color(0xFF9B1C1C),
      );
    } finally {
      isLoading.value = false;
    }
  }
}
