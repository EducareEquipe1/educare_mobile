import 'package:educare/screens/auth/sign_up_page.dart';
import 'package:educare/screens/documents/documents_page.dart';
import 'package:get/get.dart';
import '../../screens/splash/splash_screen.dart';
import '../../screens/home/bottom_nav.dart';
import '../../screens/greeting/greeting_page.dart';
import '../../screens/auth/login_page.dart';
import '../../screens/rendezvous/calendar_view.dart';
import '../../screens/notifications/notifications_page.dart';
import '../../screens/settings/settings_page.dart';
import 'app_routes.dart';
import '../../bindings/consultation_binding.dart';
import '../../screens/documents/consultations/consultation_view.dart';
import 'package:educare/screens/auth/reset_password_page.dart';
import 'package:educare/screens/auth/password_changed_page.dart';
import 'package:educare/screens/auth/forgot_password_page.dart';
import 'package:educare/screens/auth/email_sent_page.dart';

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
    GetPage(name: AppRoutes.folder, page: () => const DocumentsPage()),
    GetPage(
      name: AppRoutes.notifications,
      page: () => const NotificationsPage(),
    ),
    GetPage(name: AppRoutes.settings, page: () => const SettingsPage()),
    GetPage(
      name: AppRoutes.resetPassword,
      page: () => ResetPasswordPage(), // Add token handling if required
    ),
    GetPage(name: AppRoutes.passwordChanged, page: () => PasswordChangedPage()),
    GetPage(name: AppRoutes.forgotPassword, page: () => ForgotPasswordPage()),
    GetPage(name: AppRoutes.emailSent, page: () => EmailSentPage()),
        GetPage(name: AppRoutes.signUp, page: () => const SignUpPage()), // Add this

  ];
}
