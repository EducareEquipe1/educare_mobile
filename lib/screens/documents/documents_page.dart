import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dossier_medical/dossier_medical_view.dart';
import 'consultations/consultation_view.dart';
import '../../controllers/dossier_medical_controller.dart';
import '../../controllers/consultation_controller.dart';

class DocumentsPage extends StatelessWidget {
  const DocumentsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Initialize the controllers here
    Get.put(DossierMedicalController());
    Get.put(ConsultationController()); // Add this line

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Mes Documents',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2D3748),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: CircleAvatar(
                backgroundImage: const AssetImage(
                  'assets/images/default_pic.png',
                ),
                radius: 20,
              ),
            ),
          ],
          bottom: const TabBar(
            labelColor: Color(0xFF678E90),
            unselectedLabelColor: Color(0xFF718096),
            indicatorColor: Color(0xFF678E90),
            tabs: [Tab(text: 'Dossier Medical'), Tab(text: 'Consultations')],
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: TabBarView(children: [DossierMedicalView(), ConsultationsView()]),
      ),
    );
  }
}
