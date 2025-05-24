import 'dart:ui';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:educare/controllers/user_controller.dart';
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
    final user = Get.find<UserController>().user;
    final email = user?.email;
    if (email == null) return;

    // Get token from storage
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(
      'token',
    ); // Make sure you save the token at login

    final url =
        'https://educare-backend-l6ue.onrender.com/patients/dossier-medical/$email';

    try {
      isLoading.value = true;
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      print('Status: ${response.statusCode}');
      print('Body: ${response.body}');
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Map flat fields to your sections
        personalDetails.value = {
          'Nom': data['nom'] ?? '',
          'Prénom': data['prenom'] ?? '',
          'Date de naissance': data['date_naissance'] ?? '',
          'Adresse': data['adresse'] ?? '',
          'Situation familiale': data['situation_famille'] ?? '',
          'Numéro de téléphone': data['num_tel'] ?? '',
          'Numéro sécurité sociale': data['numSecuriteSociale'] ?? '',
          'Statut': data['statut'] ?? '',
        };

        biometricData.value = {
          'Taille': data['taille']?.toString() ?? '',
          'Poids': data['poids']?.toString() ?? '',
          'Groupe sanguin': data['groupeSanguin'] ?? '',
        };

        personalHistory.value = {
          'Tabac fume': data['tabac_fume'] == 1,
          'Tabac fume nombre': data['tabac_fume_nombre'] ?? 0,
          'Tabac chique': data['tabac_chique'] == 1,
          'Tabac chique nombre': data['tabac_chique_nombre'] ?? 0,
          'Tabac pris': data['tabac_pris'] == 1,
          'Tabac pris nombre': data['tabac_pris_nombre'] ?? 0,
          'Age pris': data['age_pris'] ?? 0,
          'Ancien fumeur': data['ancien_fume'] == 1,
          'Période exposition': data['periode_exposition'] ?? 0,
          'Alcool': data['alcool'] == 1,
        };

        medicalHistory.value = {
          'Médicaments': [data['medicaments'] ?? ''],
          'Affections congénitales': [data['affectionsCongenitales'] ?? ''],
          'Maladies générales': [data['maladiesGenerales'] ?? ''],
          'Interventions chirurgicales': [
            data['interventionsChirurgicales'] ?? '',
          ],
          'Réactions allergiques': [data['reactionsAllergiques'] ?? ''],
          'Notes': [data['notes'] ?? ''],
        };
      } else {
        Get.snackbar(
          'Erreur',
          'Impossible de charger le dossier médical',
          backgroundColor: const Color(0xFFFFE6E6),
          colorText: const Color(0xFF9B1C1C),
        );
      }
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
