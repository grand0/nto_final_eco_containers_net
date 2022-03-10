import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:nto_final_eco_containers_net/controllers/auth_controller.dart';
import 'package:nto_final_eco_containers_net/controllers/user_controller.dart';
import 'package:nto_final_eco_containers_net/models/user_model.dart';
import 'package:nto_final_eco_containers_net/screens/common/user_info.dart';
import 'package:nto_final_eco_containers_net/screens/common/user_logs.dart';

class UserPage extends StatelessWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String id = Get.parameters['id']!;

    final authController = Get.find<AuthController>();
    if (!authController.isAuthenticated ||
        !(authController.userStatus == UserStatus.admin ||
            authController.authenticatedForId == id)) {
      SchedulerBinding.instance?.addPostFrameCallback((_) {
        Get.offNamed('/');
      });
    }

    UserController userController = Get.put(UserController(id), tag: 'user');
    final fromAdmin = Get.arguments != null;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Эко-контейнеры'),
        actions: fromAdmin
            ? null
            : [
                IconButton(
                  onPressed: () {
                    Get.offNamed('/');
                  },
                  icon: const Icon(Icons.logout),
                  tooltip: 'Выйти',
                ),
              ],
      ),
      body: userController.obx(
        (model) => SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 16),
                UserInfo(
                  balance: model!.balance,
                  avatarUrl: model.avatarUrl,
                  name: model.fullName,
                  address: model.address,
                  login: model.login,
                  id: id,
                ),
                const SizedBox(height: 32),
                const Text('История', style: TextStyle(fontSize: 30)),
                const SizedBox(height: 16),
                UserLogs(actions: model.actions),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
        onEmpty: const Center(child: CircularProgressIndicator()),
        onLoading: const Center(child: CircularProgressIndicator()),
        onError: (err) => Center(child: Text('Ошибка: $err')),
      ),
    );
  }
}
