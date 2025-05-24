import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RequestsList extends StatefulWidget {
  final String email; // Pass the user's email

  const RequestsList({Key? key, required this.email}) : super(key: key);

  @override
  State<RequestsList> createState() => _RequestsListState();
}

class _RequestsListState extends State<RequestsList> {
  List<Map<String, dynamic>> _demandes = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchDemandes();
  }

  Future<void> _fetchDemandes() async {
    final url = Uri.parse(
      'https://educare-backend-l6ue.onrender.com/patients/demandes/${widget.email}',
    );
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        setState(() {
          _demandes =
              data
                  .map(
                    (demande) => {
                      'id_rdv': demande['id_rdv'] ?? 0, // Default to 0 if null
                      'motif': demande['motif'] ?? 'Motif inconnu',
                      'date':
                          DateTime.tryParse(demande['date_depot'] ?? '') ??
                          DateTime.now(), // Default to current date if parsing fails
                      'status': 'En attente', // Default status for demandes
                    },
                  )
                  .toList();
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = 'Erreur lors de la récupération des demandes.';
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

    if (_demandes.isEmpty) {
      return const Center(
        child: Text(
          'Pas de demandes',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: _demandes.length,
      itemBuilder: (context, index) {
        final demande = _demandes[index];
        return _RequestCard(
          motif: demande['motif'],
          date: demande['date'],
          status: demande['status'],
        );
      },
    );
  }
}

class _RequestCard extends StatelessWidget {
  final String motif;
  final DateTime date;
  final String status;

  const _RequestCard({
    required this.motif,
    required this.date,
    required this.status,
  });

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
              'Demandé le ${_formatDate(date)}',
              style: const TextStyle(color: Color.fromRGBO(113, 128, 150, 1)),
            ),
            const SizedBox(height: 8),
            Text(
              'Statut : $status',
              style: const TextStyle(color: Color(0xFF718096)),
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
