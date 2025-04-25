import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../models/ordonnance.dart';
import 'ordonnance_details_page.dart';

class OrdonnancesView extends StatelessWidget {
  const OrdonnancesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: dummyOrdonnances.length,
      itemBuilder: (context, index) {
        final ordonnance = dummyOrdonnances[index];
        return OrdonnanceCard(ordonnance: ordonnance);
      },
    );
  }
}

class OrdonnanceCard extends StatelessWidget {
  final Ordonnance ordonnance;

  const OrdonnanceCard({Key? key, required this.ordonnance}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: InkWell(
        onTap:
            () => Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (context) => OrdonnanceDetailsPage(ordonnance: ordonnance),
              ),
            ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Ordonnance du ${ordonnance.date}',
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF2D3748),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${ordonnance.patientName} ${ordonnance.patientFirstName}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF718096),
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE6FFFA),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      '${ordonnance.medications.length} méd.',
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF678E90),
                      ),
                    ),
                  ),
                ],
              ),
              if (ordonnance.medications.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(
                  ordonnance.medications.map((m) => m.name).join(' • '),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF718096),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

// Dummy data for testing
final List<Ordonnance> dummyOrdonnances = [
  Ordonnance(
    id: '1',
    patientName: 'Zerguerras',
    patientFirstName: 'Khayra Sarra',
    address: 'adresse exemple',
    date: '12/04/2025',
    age: 20,
    medications: [
      Medication(
        name: 'Paracétamol 1 G COMP.',
        dosage: '1 comprimé, chaque 6h',
        duration: '5 jours',
      ),
      Medication(
        name: 'amoxicilline 1 G COMP.',
        dosage: '1 comprimé, 3 fois/jour',
        duration: '5 jours',
      ),
    ],
  ),
  // Add more dummy ordonnances as needed
];
