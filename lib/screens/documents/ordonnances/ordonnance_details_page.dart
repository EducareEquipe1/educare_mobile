import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../models/ordonnance.dart';
import '../../../controllers/user_controller.dart';

class OrdonnanceDetailsPage extends StatelessWidget {
  final Ordonnance ordonnance;

  const OrdonnanceDetailsPage({Key? key, required this.ordonnance})
    : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    // Get patient info from UserController
    final userController = Get.find<UserController>();
    final address = userController.address ?? '';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF2D3748)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Cabinet Medical ESI SBA',
                              style: TextStyle(
                                fontSize: 14, // Reduced from 16
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF2D3748),
                              ),
                            ),
                            Text(
                              'Consultation, Soins, Certificats Medicaux, Urgences',
                              style: TextStyle(
                                fontSize: 11, // Reduced from 12
                                color: Color(0xFF718096),
                              ),
                            ),
                            Text(
                              'École Supérieure en Informatique, Sidi Bel Abbes',
                              style: TextStyle(
                                fontSize: 11, // Reduced from 12
                                color: Color(0xFF718096),
                              ),
                            ),
                            SizedBox(height: 2), // Reduced from 4
                            Text(
                              '05 55123456 / 05 55789021',
                              style: TextStyle(
                                fontSize: 11, // Reduced from 12
                                color: Color(0xFF718096),
                              ),
                            ),
                            Text(
                              'cabinet.medical@esi-sba.dz',
                              style: TextStyle(
                                fontSize: 11, // Reduced from 12
                                color: Color(0xFF718096),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Image.asset('assets/images/esi_logo.png', height: 60),
                    ],
                  ),
                  const Divider(height: 32),
                  const Center(
                    child: Text(
                      'ORDONNANCE',
                      style: TextStyle(
                        fontSize: 16, // Reduced from 20
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16), // Reduced from 24
                  // Patient details
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildDetailRow(
                              'Nom',
                              userController.user?.lastName ?? '',
                            ),
                            _buildDetailRow(
                              'Prenom',
                              userController.user?.firstName ?? '',
                            ),
                            _buildDetailRow('Adresse', address),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildDetailRow('Date', ordonnance.date),
                            _buildDetailRow('Age', '${ordonnance.age} ans'),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  // Medications
                  ...ordonnance.medications.map(
                    (med) => Padding(
                      padding: const EdgeInsets.only(
                        bottom: 16,
                      ), // Reduced from 24
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            med.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 12, // Reduced from 14
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 2), // Reduced from 4
                          Text(
                            med.dosage,
                            style: const TextStyle(
                              fontSize: 11, // Reduced from 14
                              color: Color(0xFF4A5568),
                            ),
                          ),
                          Text(
                            'QSP ${med.duration}',
                            style: const TextStyle(
                              fontSize: 11, // Reduced from 14
                              color: Color(0xFF4A5568),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6), // Reduced from 8
      child: Row(
        children: [
          Text(
            '$label: ',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 12, // Added font size
            ),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 12), // Added font size
          ),
        ],
      ),
    );
  }
}
