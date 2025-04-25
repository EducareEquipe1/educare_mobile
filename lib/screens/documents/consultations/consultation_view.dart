import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/consultation_controller.dart';
import 'consultation_card.dart';

class ConsultationsView extends GetView<ConsultationController> {
  const ConsultationsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
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
