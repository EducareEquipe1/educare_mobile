import 'package:flutter/material.dart';

class AppointmentRequestDialog extends StatelessWidget {
  final TextEditingController _motifController = TextEditingController();

  AppointmentRequestDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Demande de rendez-vous',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Expliquez brièvement la raison de votre demande.\nLe médecin fixera la date et l\'heure du rendez-vous.',
              style: TextStyle(color: Color.fromRGBO(113, 128, 150, 1)),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _motifController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Ex : J\'ai mal à la gorge depuis quelques jours...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Handle appointment request
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(103, 146, 148, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'Envoyer la demande',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
