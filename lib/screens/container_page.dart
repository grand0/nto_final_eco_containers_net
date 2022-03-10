import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:nto_final_eco_containers_net/controllers/auth_controller.dart';
import 'package:nto_final_eco_containers_net/controllers/container_controller.dart';
import 'package:nto_final_eco_containers_net/excel_helper.dart';
import 'package:nto_final_eco_containers_net/models/user_model.dart';
import 'package:nto_final_eco_containers_net/screens/common/circle_light.dart';
import 'package:nto_final_eco_containers_net/screens/common/container_logs.dart';
import 'package:nto_final_eco_containers_net/screens/common/container_reports.dart';

import 'common/rounded_button.dart';

class ContainerPage extends StatelessWidget {
  const ContainerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    if (!authController.isAuthenticated ||
        authController.userStatus != UserStatus.admin) {
      SchedulerBinding.instance?.addPostFrameCallback((_) {
        Get.offNamed('/');
      });
    }

    final id = Get.parameters['id']!;
    final controller = Get.put(ContainerController(id));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Эко-контейнеры'),
      ),
      body: controller.obx(
        (model) => SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  'Контейнер #$id',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                  ),
                ),
              ),
              model?.locked ?? false
                  ? const Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Text(
                        'Заблокирован',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 18,
                        ),
                      ),
                    )
                  : Container(),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Tooltip(
                    message: model!.redFull
                        ? 'Красный отсек переполнен'
                        : 'Красный отсек активен',
                    child: CircleLight(
                      enabledColor: Colors.red,
                      disabledColor: Colors.red.shade100,
                      enabled: model.redFull,
                      enabledIcon: const Icon(Icons.error, color: Colors.white),
                      disabledIcon:
                          const Icon(Icons.check, color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 32),
                  Tooltip(
                    message: model.greenFull
                        ? 'Зеленый отсек переполнен'
                        : 'Зеленый отсек активен',
                    child: CircleLight(
                      enabledColor: Colors.green,
                      disabledColor: Colors.green.shade100,
                      enabled: model.greenFull,
                      enabledIcon: const Icon(Icons.error, color: Colors.white),
                      disabledIcon:
                          const Icon(Icons.check, color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 32),
                  Tooltip(
                    message: model.blueFull
                        ? 'Синий отсек переполнен'
                        : 'Синий отсек активен',
                    child: CircleLight(
                      enabledColor: Colors.blue,
                      disabledColor: Colors.blue.shade100,
                      enabled: model.blueFull,
                      enabledIcon: const Icon(Icons.error, color: Colors.white),
                      disabledIcon:
                          const Icon(Icons.check, color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              !model.changingLock
                  ? RoundedButton(
                      onPressed: () {
                        controller.toggleLock();
                      },
                      icon: model.locked
                          ? const Icon(Icons.lock_open)
                          : const Icon(Icons.lock),
                      label: model.locked ? 'Разблокировать' : 'Заблокировать',
                    )
                  : const CircularProgressIndicator(),
              const SizedBox(height: 32),
              const Text(
                'История',
                style: TextStyle(fontSize: 30),
              ),
              const SizedBox(height: 16),
              ContainerLogs(actions: model.actions),
              const SizedBox(height: 32),
              const Text(
                'Отчёты',
                style: TextStyle(fontSize: 30),
              ),
              const SizedBox(height: 16),
              RoundedButton(
                label: 'Загрузить таблицу с отчётами',
                icon: const Icon(Icons.download),
                onPressed: () => createAndDownloadExcelReport(model.reports),
              ),
              const SizedBox(height: 16),
              ContainerReports(reports: model.reports),
              const SizedBox(height: 32),
            ],
          ),
        ),
        onEmpty: const Center(child: CircularProgressIndicator()),
        onLoading: const Center(child: CircularProgressIndicator()),
        onError: (err) => Center(child: Text('ERROR: $err')),
      ),
    );
  }
}
