import 'package:get/get.dart';
import '../models/consultation.dart'; // <-- This is the only Consultation class you should use
import 'package:http/http.dart' as http;
import 'dart:convert';

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
        Uri.parse('https://educare-backend-l6ue.onrender.com/patients/consultations/$email'),
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
}
