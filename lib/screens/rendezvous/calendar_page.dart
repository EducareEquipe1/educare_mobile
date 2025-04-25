import 'package:flutter/material.dart';

class RendezVousCalendarPage extends StatelessWidget {
  const RendezVousCalendarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rendez-vous')),
      body: const Center(child: Text('Rendez-vous Calendar Page')),
    );
  }
}
