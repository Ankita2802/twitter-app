import 'package:api_withgetx/routes/app_routes.dart';
import 'package:api_withgetx/screens/auth/login_screen.dart';
import 'package:api_withgetx/screens/auth/register_screen.dart';
import 'package:api_withgetx/screens/auth/user/user_screen.dart';
import 'package:api_withgetx/screens/home/home_screen.dart';
import 'package:get/get.dart';

class AppPages {
  AppPages._();
  static const initial = AppRoutes.splashscreen;
  static final routes = [
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginScreen(),
    ),
    GetPage(
      name: AppRoutes.register,
      page: () => const RegisterScreen(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeScreen(),
    ),
    GetPage(
      name: AppRoutes.user,
      page: () => const UserScreen(
        id: 0,
      ),
    ),
  ];
}
