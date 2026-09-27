import 'package:crud/screens/add_screen.dart';
import 'package:crud/screens/home_screen.dart';
import 'package:crud/screens/update_screen.dart';
import 'package:get/get.dart';

import 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(name: AppRoutes.home, page: () => const HomeScreen()),
    GetPage(
      name: AppRoutes.add,
      page: () => const AddScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.edit,
      page: () {
        final arguments = Get.arguments;
        if (arguments is Map<String, dynamic>) {
          return UpdateScreen(student: arguments);
        }
        return const HomeScreen();
      },
      transition: Transition.zoom,
    ),
  ];
}
