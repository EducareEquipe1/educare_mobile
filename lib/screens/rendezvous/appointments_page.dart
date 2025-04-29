import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'calendar_view.dart';
import 'requests_list.dart';
import 'faire_demande_dialog.dart';
import '../../controllers/user_controller.dart';

class AppointmentsPage extends StatefulWidget {
  const AppointmentsPage({Key? key}) : super(key: key);

  @override
  State<AppointmentsPage> createState() => _AppointmentsPageState();
}

class _AppointmentsPageState extends State<AppointmentsPage> {
  final List<Map<String, dynamic>> _demandes = [];
  final String? userEmail = Get.find<UserController>().userEmail;

  void _addDemande(String motif) {
    setState(() {
      _demandes.add({
        'motif': motif,
        'date': DateTime.now(),
        'status': 'En attente',
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Rendez-vous',
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
            tabs: [Tab(text: 'Mes Rendez-vous'), Tab(text: 'Mes Demandes')],
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: TabBarView(
          children: [
            const RendezVousCalendarView(),
            RequestsList(demandes: _demandes),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (userEmail != null) {
              showFaireDemandeDialog(context, _addDemande, userEmail!);
            } else {
              // Handle case where email is not available
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Email utilisateur introuvable')),
              );
            }
          },
          backgroundColor: const Color(0xFF678E90),
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }
}
