import 'package:get/get.dart';
import '../models/consultation.dart';
import '../models/ordonnance.dart';
import '../models/examen_medical.dart'; // Import your ExamenMedical model
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'user_controller.dart'; // Add this import

class ConsultationController extends GetxController {
  var consultations = <Consultation>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    // fetchConsultations();
  }

  Future<void> fetchConsultations(String email) async {
    isLoading.value = true;
    try {
      print('[ConsultationController] Fetching consultations for $email');
      final response = await http.get(
        Uri.parse(
          'https://educare-backend-l6ue.onrender.com/patients/consultations/$email',
        ),
      );
      print('[ConsultationController] Response status: ${response.statusCode}');
      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);
        if (data.isEmpty) {
          print('[ConsultationController] No consultations found for $email');
        } else {
          print(
            '[ConsultationController] ${data.length} consultations loaded for $email',
          );
        }
        consultations.value =
            data.map((e) => Consultation.fromJson(e)).toList();
      } else {
        print('[ConsultationController] Error: ${response.body}');
        consultations.clear();
      }
    } catch (e) {
      print('[ConsultationController] Exception: $e');
      consultations.clear();
    }
    isLoading.value = false;
  }

  int _calculateAge(String? birthDateString) {
    if (birthDateString == null || birthDateString.isEmpty) return 0;
    final birthDate = DateTime.tryParse(birthDateString);
    if (birthDate == null) return 0;
    final now = DateTime.now();
    int age = now.year - birthDate.year;
    if (now.month < birthDate.month ||
        (now.month == birthDate.month && now.day < birthDate.day)) {
      age--;
    }
    return age;
  }

  Future<Ordonnance?> fetchOrdonnanceForConsultation(
    String consultationId,
  ) async {
    try {
      final userController = Get.find<UserController>();
      var user = userController.user;

      final age = _calculateAge(user?.birthDate);

      // If address is not set, fetch dossier medical first
      if ((userController.address == null || userController.address!.isEmpty) &&
          user?.email != null) {
        await userController.fetchDossierMedical(user!.email!);
      }
      final address = userController.address ?? '';
      final patientName = user?.lastName ?? '';
      final patientFirstName = user?.firstName ?? '';

      final token =
          await userController.getToken(); // Implement this to get your JWT
      final response = await http.get(
        Uri.parse(
          'https://educare-backend-l6ue.onrender.com/patients/ordonnance/by-consultation/$consultationId',
        ),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List meds = data['medicaments'] ?? [];
        return Ordonnance(
          id: data['ordonnance_id'].toString(),
          patientName: patientName,
          patientFirstName: patientFirstName,
          address: address,
          date: data['ordonnance_date'] ?? '',
          age: age,
          medications:
              meds
                  .map(
                    (m) => Medication(
                      name: m['nom'] ?? '',
                      dosage: m['dosage'] ?? '',
                      duration: m['duree'] ?? '',
                    ),
                  )
                  .toList(),
        );
      } else {
        print(
          '[ConsultationController] Failed to fetch ordonnance: ${response.body}',
        );
        return null;
      }
    } catch (e) {
      print('[ConsultationController] Exception fetching ordonnance: $e');
      return null;
    }
  }

  Future<ExamenMedical?> fetchExamenMedicalForConsultation(
    String consultationId,
  ) async {
    try {
      final userController = Get.find<UserController>();
      final token = await userController.getToken();
      final response = await http.get(
        Uri.parse(
          'https://educare-backend-l6ue.onrender.com/patients/examen-medical/by-consultation/$consultationId',
        ),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return ExamenMedical.fromJson(data['data']);
      } else {
        print(
          '[ConsultationController] Failed to fetch examen medical: ${response.body}',
        );
        return null;
      }
    } catch (e) {
      print('[ConsultationController] Exception fetching examen medical: $e');
      return null;
    }
  }
}
