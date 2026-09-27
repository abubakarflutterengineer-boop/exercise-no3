import 'package:crud/routes/app_pages.dart';
import 'package:crud/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Crud extends StatelessWidget {
  const Crud({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Crud App",
      initialRoute: AppRoutes.home,
      getPages: AppPages.routes,
    );
  }
}