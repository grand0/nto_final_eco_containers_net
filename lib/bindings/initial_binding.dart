import 'package:get/get.dart';
import 'package:nto_final_eco_containers_net/controllers/auth_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
  }
}