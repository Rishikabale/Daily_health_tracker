// lib/routes/app_pages.dart
import 'package:get/get.dart';
import '../views/login_view.dart';
import 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: Routes.LOGIN,
      page: () => const LoginView(),
      
    )
  ];
}