import 'package:get/get.dart';
import '../../screens/splash/splash_screen.dart';
import '../../screens/home/bottom_nav.dart';
import '../../screens/greeting/greeting_page.dart';
import '../../screens/auth/login_page.dart';
import '../../screens/rendezvous/calendar_view.dart';
import '../../screens/dossier_medical/dossier_page.dart';
import '../../screens/notifications/notifications_page.dart';
import '../../screens/settings/settings_page.dart';
import 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(name: AppRoutes.splash, page: () => const SplashScreen()),
    GetPage(name: AppRoutes.greeting, page: () => const GreetingPage()),
    GetPage(name: AppRoutes.login, page: () => const LoginPage()),
    GetPage(name: AppRoutes.home, page: () => const BottomNav()),
    GetPage(
      name: AppRoutes.calendar,
      page: () => const RendezVousCalendarView(),
    ),
    GetPage(name: AppRoutes.folder, page: () => const DossierPage()),
    GetPage(
      name: AppRoutes.notifications,
      page: () => const NotificationsPage(),
    ),
    GetPage(name: AppRoutes.settings, page: () => const SettingsPage()),
  ];
}
