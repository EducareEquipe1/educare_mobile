import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RendezVousList extends StatefulWidget {
  final String email; // Pass the user's email

  const RendezVousList({Key? key, required this.email}) : super(key: key);

  @override
  State<RendezVousList> createState() => _RendezVousListState();
}

class _RendezVousListState extends State<RendezVousList> {
  List<Map<String, dynamic>> _rendezVous = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchRendezVous();
  }

  Future<void> _fetchRendezVous() async {
    final url = Uri.parse(
      ' https://educare-backend-l6ue.onrender.com/patients/listerendezvousdupatient/${widget.email}',
    );
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        setState(() {
          _rendezVous =
              data
                  .map(
                    (rendezVous) => {
                      'id_rdv': rendezVous['id_rdv'] ?? 0,
                      'motif': rendezVous['motif'] ?? 'Motif inconnu',
                      'date':
                          DateTime.tryParse(rendezVous['date'] ?? '') ??
                          DateTime.now(),
                    },
                  )
                  .toList();
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = 'Erreur lors de la récupération des rendez-vous.';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Impossible de se connecter au serveur.';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_errorMessage != null) {
      return Center(child: Text(_errorMessage!));
    }

    if (_rendezVous.isEmpty) {
      return const Center(
        child: Text(
          'Pas de rendezvous disponible',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: _rendezVous.length,
      itemBuilder: (context, index) {
        final rendezVous = _rendezVous[index];
        return _RendezVousCard(
          motif: rendezVous['motif'],
          date: rendezVous['date'],
        );
      },
    );
  }
}

class _RendezVousCard extends StatelessWidget {
  final String motif;
  final DateTime date;

  const _RendezVousCard({required this.motif, required this.date});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              motif,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            Text(
              'Date : ${_formatDate(date)}',
              style: const TextStyle(color: Color.fromRGBO(113, 128, 150, 1)),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
