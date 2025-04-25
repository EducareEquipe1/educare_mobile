import 'package:get/get.dart';
import '../models/consultation.dart';

class ConsultationController extends GetxController {
  final consultations = <Consultation>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchConsultations();
  }

  void fetchConsultations() {
    isLoading.value = true;

    // Static data
    final staticConsultations = [
      Consultation(
        motif: 'Routine Checkup',
        date: '2025-04-20',
        type: 'General',
        symptomes: ['Headache', 'Fatigue'],
        observation: 'Patient appears healthy.',
        diagnostic: 'No issues detected.',
        examens: ['Blood Test'],
        hasOrdonnance: false,
      ),
      Consultation(
        motif: 'Follow-up',
        date: '2025-04-15',
        type: 'Specialist',
        symptomes: ['Back Pain'],
        observation: 'Improvement noted.',
        diagnostic: 'Continue physiotherapy.',
        examens: ['X-Ray'],
        hasOrdonnance: true,
      ),
    ];

    consultations.assignAll(staticConsultations);
    isLoading.value = false;
  }
}
