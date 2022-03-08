import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nto_final_eco_containers_net/controllers/user_controller.dart';
import 'package:nto_final_eco_containers_net/screens/common/user_info.dart';
import 'package:nto_final_eco_containers_net/screens/common/user_logs.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserController userController =
        Get.put(UserController(Get.parameters['id']!));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Эко-контейнеры'),
        actions: [
          IconButton(
            onPressed: () {
              userController.loadData();
            },
            icon: const Icon(Icons.replay),
            tooltip: 'Обновить',
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
        onLoading: const Center(child: CircularProgressIndicator()),
        onError: (err) => Center(child: Text('ERROR: $err')),
      ),
    );
  }
}
