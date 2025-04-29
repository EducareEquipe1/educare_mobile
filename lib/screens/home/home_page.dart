import 'package:educare/controllers/user_controller.dart';
import 'package:educare/screens/rendezvous/appointments_page.dart';
import 'package:educare/screens/rendezvous/faire_demande_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'health_tips.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final UserController userController = Get.find<UserController>();
  String? userEmail;
  String greetingMessage = 'Bonjour';

  @override
  void initState() {
    super.initState();
    // Retrieve the email from arguments
    userEmail = Get.arguments?['email'];
    if (userEmail != null) {
      _fetchUserData(userEmail!);
    }
  }

  Future<void> _fetchUserData(String email) async {
    try {
      await userController.fetchUserProfile(email);
      final user = userController.user;
      if (user != null) {
        setState(() {
          greetingMessage =
              'Bonjour ${user.firstName ?? ''} ${user.lastName ?? ''}';
        });
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset('assets/images/dark_logo.png', height: 40),
                  CircleAvatar(
                    backgroundImage: const AssetImage(
                      'assets/images/default_pic.png',
                    ),
                    radius: 20,
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Text(
                greetingMessage,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(45, 55, 72, 1),
                ),
              ),
              const SizedBox(height: 24),
              _buildCard('Conseil santé du jour', HealthTips.getRandomTip()),
              const SizedBox(height: 16),
              _buildAppointmentCard(),
              const SizedBox(height: 16),
              _buildQuickActionsCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard(String title, String content) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(241, 245, 249, 1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(45, 55, 72, 1),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: const TextStyle(
              fontSize: 14,
              color: Color.fromRGBO(113, 128, 150, 1),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppointmentCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(241, 245, 249, 1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Prochain rendez-vous',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(45, 55, 72, 1),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '17 avril 2025 à 14:30',
            style: const TextStyle(
              fontSize: 14,
              color: Color.fromRGBO(113, 128, 150, 1),
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Compte à rebours',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(45, 55, 72, 1),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildCountdownItem('7', 'Jours'),
              _buildCountdownItem('19', 'Heures'),
              _buildCountdownItem('45', 'Minutes'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCountdownItem(String value, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: const Color.fromRGBO(45, 55, 72, 1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Color.fromRGBO(113, 128, 150, 1),
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActionsCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(241, 245, 249, 1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Actions rapides',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(45, 55, 72, 1),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildActionButton('Demandez un\nRendez-vous', () {
                // Navigate to the "Faire une demande" dialog
                showFaireDemandeDialog(
                  context,
                  (demande) {
                    // Handle the new demande if needed
                  },
                  userEmail ?? '', // Pass the user's email
                );
              }),
              _buildActionButton('Voir mes\nrendez-vous', () {
                // Navigate to the AppointmentsPage
                Get.to(() => const AppointmentsPage());
              }),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(String text, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromRGBO(225, 240, 240, 1),
        foregroundColor: const Color.fromRGBO(45, 55, 72, 1),
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 14),
      ),
    );
  }
}
