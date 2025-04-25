import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'app/routes/app_pages.dart';
import 'app/routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('fr_FR', null);

  runApp(const EduCareApp());
}

class EduCareApp extends StatelessWidget {
  const EduCareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'EduCare',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontSize: 16),
          bodyMedium: TextStyle(fontSize: 14),
        ),
      ),
      initialRoute: AppRoutes.splash,
      getPages: AppPages.routes,
    );
  }
}
