import 'package:get/get.dart';

abstract class AppRoutes {
  static const splash = '/';
  static const greeting = '/greeting';
  static const login = '/login';
  static const signUp = '/sign-up';
  static const checkEmail = '/check-email';

  static const home = '/home';
  static const calendar = '/calendar';
  static const folder = '/folder';
  static const notifications = '/notifications';
  static const settings = '/settings';
  static const resetPassword = '/reset-password';
  static const passwordChanged = '/password-changed';
  static const forgotPassword = '/forgot-password';
  static const emailSent = '/email-sent';
  static const verifyEmail = '/verify-email/:token';
}
