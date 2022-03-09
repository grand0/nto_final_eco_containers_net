import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nto_final_eco_containers_net/controllers/user_controller.dart';
import 'package:nto_final_eco_containers_net/screens/common/user_info.dart';
import 'package:nto_final_eco_containers_net/screens/common/user_logs.dart';

class UserPage extends StatelessWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserController userController =
        Get.put(UserController(Get.parameters['id']!));
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
          child: Column(
            children: [
              UserInfo(
                balance: model!.balance,
                avatarUrl: model.avatarUrl,
                name: model.fullName,
                address: model.address,
              ),
              const SizedBox(height: 32),
              UserLogs(actions: model.actions),
            ],
          ),
        ),
        onEmpty: const Center(child: CircularProgressIndicator()),
        onLoading: const Center(child: CircularProgressIndicator()),
        onError: (err) => Center(child: Text('Ошибка: $err')),
      ),
    );
  }
}
