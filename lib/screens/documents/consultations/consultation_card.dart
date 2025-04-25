import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../models/consultation.dart';
import 'consultation_details_view.dart';

class ConsultationCard extends StatelessWidget {
  final Consultation consultation;

  const ConsultationCard({Key? key, required this.consultation})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => ConsultationDetailsView(consultation: consultation));
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                consultation.motif,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2D3748),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(
                    Icons.calendar_today,
                    size: 16,
                    color: Color(0xFF718096),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    consultation.date,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF718096),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
