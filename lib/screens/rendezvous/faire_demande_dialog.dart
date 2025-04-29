import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void showFaireDemandeDialog(
  BuildContext context,
  Function(String) onAddDemande,
  String email, // Pass the user's email
) {
  final TextEditingController motifController = TextEditingController();

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Erreur'),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
    );
  }

  Future<void> _submitDemande(String motif) async {
    final url = Uri.parse('http://localhost:3000/patients/demanderdv/$email');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'motif': motif}),
      );

      if (response.statusCode == 201) {
        // Successfully created the demande
        onAddDemande(motif); // Add the demande to the local list
        Navigator.pop(context);
      } else {
        // Handle errors
        final error = jsonDecode(response.body)['error'];
        _showErrorDialog(context, error ?? 'Une erreur est survenue.');
      }
    } catch (e) {
      _showErrorDialog(context, 'Impossible de se connecter au serveur.');
    }
  }

  showDialog(
    context: context,
    builder: (BuildContext context) {
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
                    'Faire une demande',
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
                'Motif de consultation',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: motifController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText:
                      'Ex : J\'ai mal à la gorge depuis quelques jours...',
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
                    final motif = motifController.text.trim();
                    if (motif.isNotEmpty) {
                      _submitDemande(motif);
                    } else {
                      _showErrorDialog(
                        context,
                        'Veuillez entrer un motif valide.',
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF678E90),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
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
    },
  );
}
