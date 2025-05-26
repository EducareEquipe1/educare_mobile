import 'package:educare/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/consultation_controller.dart';
import '../../../models/consultation.dart';
import 'consultation_card.dart';

class ConsultationsView extends GetView<ConsultationController> {
  const ConsultationsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userEmail = Get.find<UserController>().user?.email;
    if (userEmail != null && controller.consultations.isEmpty) {
      controller.fetchConsultations(userEmail);
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          if (controller.consultations.isEmpty) {
            print('[ConsultationsView] No consultations to display.');
            return Center(
              child: Text(
                'Aucune consultation trouvée.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }
          return ListView.builder(
            itemCount: controller.consultations.length,
            itemBuilder: (context, index) {
              final consultation = controller.consultations[index];
              return ConsultationCard(consultation: consultation);
            },
          );
        }),
      ),
    );
  }
}
