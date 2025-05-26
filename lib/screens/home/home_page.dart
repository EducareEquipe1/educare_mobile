import 'package:educare/controllers/user_controller.dart';
import 'package:educare/screens/rendezvous/appointments_page.dart';
import 'package:educare/screens/rendezvous/faire_demande_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'health_tips.dart';
import 'package:educare/widgets/profile_avatar.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';
import 'package:educare/screens/documents/consultations/consultation_view.dart';
import 'package:educare/controllers/consultation_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final UserController userController = Get.find<UserController>();
  String? userEmail;
  String greetingMessage = 'Bonjour';

  DateTime? nextRdvDate;
  Timer? countdownTimer;
  Duration timeLeft = Duration.zero;
  bool isLoadingRdv = true;

  String? conseilDuJour;
  DateTime? conseilDate;

  @override
  void initState() {
    super.initState();
    userEmail = Get.arguments?['email'];
    if (userEmail != null) {
      _fetchUserData(userEmail!);
      _fetchNextRendezVous(userEmail!);
    }
    _setConseilDuJour();
  }

  @override
  void dispose() {
    countdownTimer?.cancel();
    super.dispose();
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

  Future<void> _fetchNextRendezVous(String email) async {
    setState(() {
      isLoadingRdv = true;
    });
    try {
      final response = await http.get(
        Uri.parse(
          'https://educare-backend-l6ue.onrender.com/patients/next-rendezvous/$email',
        ),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final dateStr = data['date']; // Adjust field name as per your backend
        nextRdvDate = DateTime.parse(dateStr);
        _startCountdown();
      } else {
        nextRdvDate = null;
      }
    } catch (e) {
      nextRdvDate = null;
    }
    setState(() {
      isLoadingRdv = false;
    });
  }

  void _startCountdown() {
    countdownTimer?.cancel();
    if (nextRdvDate == null) return;
    setState(() {
      timeLeft = nextRdvDate!.difference(DateTime.now());
    });
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final diff = nextRdvDate!.difference(DateTime.now());
      if (diff.isNegative) {
        timer.cancel();
        setState(() {
          timeLeft = Duration.zero;
        });
      } else {
        setState(() {
          timeLeft = diff;
        });
      }
    });
  }

  void _setConseilDuJour() {
    final now = DateTime.now();
    if (conseilDate == null ||
        conseilDate!.day != now.day ||
        conseilDate!.month != now.month ||
        conseilDate!.year != now.year) {
      // Use the date as a seed so it's stable for the day
      final tips =
          HealthTips.tips; // Make sure HealthTips.tips is a List<String>
      if (tips.isNotEmpty) {
        final seed = int.parse('${now.year}${now.month}${now.day}');
        final random = Random(seed);
        conseilDuJour = tips[random.nextInt(tips.length)];
        conseilDate = now;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _setConseilDuJour(); // Ensure conseil is up-to-date if day changes while app is open

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
                  Obx(
                    () => ProfileAvatar(
                      imageUrl: userController.user?.profileImage,
                      radius: 20,
                    ),
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
              _buildCard('Conseil santé du jour', conseilDuJour ?? ''),
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
    if (isLoadingRdv) {
      return Center(child: CircularProgressIndicator());
    }
    if (nextRdvDate == null) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(241, 245, 249, 1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Text(
          'Aucun rendez-vous à venir',
          style: TextStyle(fontSize: 16, color: Color.fromRGBO(45, 55, 72, 1)),
        ),
      );
    }

    final days = timeLeft.inDays;
    final hours = timeLeft.inHours % 24;
    final minutes = timeLeft.inMinutes % 60;
    final seconds = timeLeft.inSeconds % 60;

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
            DateFormat('d MMMM yyyy à HH:mm', 'fr_FR').format(nextRdvDate!),
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
              _buildAnimatedCountdownItem('$days', 'Jours'),
              _buildAnimatedCountdownItem('$hours', 'Heures'),
              _buildAnimatedCountdownItem('$minutes', 'Minutes'),
              _buildAnimatedCountdownItem('$seconds', 'Secondes'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedCountdownItem(String value, String label) {
    return Column(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: const Color.fromRGBO(45, 55, 72, 1),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.blueAccent.withOpacity(0.4),
                blurRadius: 12,
                spreadRadius: 2,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 22,
              shadows: [
                Shadow(
                  blurRadius: 8,
                  color: Colors.blueAccent,
                  offset: Offset(0, 0),
                ),
              ],
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
                showFaireDemandeDialog(context, (demande) {}, userEmail ?? '');
              }),
              _buildActionButton('Voir mes\nrendez-vous', () {
                Get.to(() => const AppointmentsPage());
              }),
              _buildActionButton('Voir mes\nconsultations', () {
                Get.toNamed('/consultations');
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
