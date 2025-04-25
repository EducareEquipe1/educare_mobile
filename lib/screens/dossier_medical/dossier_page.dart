import 'package:flutter/material.dart';

class DossierPage extends StatelessWidget {
  const DossierPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dossier Médical')),
      body: const Center(child: Text('Dossier Médical Page')),
    );
  }
}
