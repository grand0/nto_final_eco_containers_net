import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nto_final_eco_containers_net/controllers/auth_controller.dart';
import 'package:nto_final_eco_containers_net/models/user_model.dart';

class AuthGuard extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final authController = Get.find<AuthController>();
    if ((route?.contains('/user') ?? false) &&
        !authController.isAuthenticated) {
      return const RouteSettings(name: '/');
    } else if (((route?.contains('/admin') ?? false) ||
            (route?.contains('/container') ?? false)) &&
        (!authController.isAuthenticated ||
            authController.userStatus != UserStatus.admin)) {
      return const RouteSettings(name: '/');
    }
    return null;
  }
}
