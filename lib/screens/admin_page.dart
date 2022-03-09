import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:nto_final_eco_containers_net/controllers/change_balance_controller.dart';
import 'package:nto_final_eco_containers_net/controllers/check_user_controller.dart';
import 'package:nto_final_eco_containers_net/models/change_balance_status.dart';
import 'package:nto_final_eco_containers_net/models/user_model.dart';
import 'package:nto_final_eco_containers_net/screens/common/expandable_button.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(CheckUserController());
    Get.put(ChangeBalanceController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Эко-контейнеры'),
        actions: [
          IconButton(
            onPressed: () {
              Get.offNamed('/');
            },
            icon: const Icon(Icons.logout),
            tooltip: 'Выйти',
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: const [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Админ-панель',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 16),
              ExpandableButton(
                icon: Icon(Icons.person),
                label: Text('Информация о пользователе'),
                contents: _UserCheckWidget(),
              ),
              SizedBox(height: 16),
              ExpandableButton(
                icon: Icon(MdiIcons.handCoin),
                label: Text('Изменить баланс пользователя'),
                contents: _BalanceChangeWidget(),
              ),
              SizedBox(height: 16),
              ExpandableButton(
                icon: Icon(MdiIcons.trashCan),
                label: Text('Информация о контейнерах'),
                contents: _CheckContainerWidget(),
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class _UserCheckWidget extends StatelessWidget {
  const _UserCheckWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginEditingController = TextEditingController();
    final controller = Get.find<CheckUserController>();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 24.0),
          child: TextField(
            controller: loginEditingController,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Имя пользователя',
              prefixIcon: Icon(Icons.person),
            ),
          ),
        ),
        controller.obx(
          (id) {
            if (id != null) {
              SchedulerBinding.instance?.addPostFrameCallback(
                  (_) => Get.toNamed('/user/$id', arguments: true));
            }

            return Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  if (loginEditingController.text.isNotEmpty) {
                    controller.getIdByLogin(loginEditingController.text);
                  }
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Перейти'),
                ),
              ),
            );
          },
          onLoading: const Padding(
            padding: EdgeInsets.only(bottom: 16.0),
            child: CircularProgressIndicator(),
          ),
          onError: (err) {
            String errText = 'Ошибка: $err';
            if (err == 'no user') {
              errText = 'Такого пользователя не существует';
            }
            return Column(
              children: [
                Text(
                  errText,
                  style: const TextStyle(color: Colors.red),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (loginEditingController.text.isNotEmpty) {
                        controller.getIdByLogin(loginEditingController.text);
                      }
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Перейти'),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class _BalanceChangeWidget extends StatefulWidget {
  const _BalanceChangeWidget({Key? key}) : super(key: key);

  @override
  _BalanceChangeWidgetState createState() => _BalanceChangeWidgetState();
}

class _BalanceChangeWidgetState extends State<_BalanceChangeWidget> {
  UserAction? balanceAction = UserAction.add;
  final balanceLoginEditingController = TextEditingController();
  final balanceAmountEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ChangeBalanceController>();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 16.0),
          child: TextField(
            controller: balanceLoginEditingController,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Имя пользователя',
              prefixIcon: Icon(Icons.person),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  balanceAction = UserAction.add;
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Radio<UserAction>(
                    value: UserAction.add,
                    groupValue: balanceAction,
                    onChanged: (value) {
                      setState(() {
                        balanceAction = value;
                      });
                    },
                  ),
                  const Text('Начислить'),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  balanceAction = UserAction.delete;
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Radio<UserAction>(
                    value: UserAction.delete,
                    groupValue: balanceAction,
                    onChanged: (value) {
                      setState(() {
                        balanceAction = value;
                      });
                    },
                  ),
                  const Text('Списать'),
                ],
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 24.0),
          child: TextField(
            controller: balanceAmountEditingController,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Бонусов',
              prefixIcon: Icon(Icons.toll),
            ),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[1-9][0-9]*')),
            ],
          ),
        ),
        controller.obx(
          (status) {
            String? errText;
            switch (status) {
              case ChangeBalanceStatus.wrongLogin:
                errText = 'Такого пользователя не существует';
                break;
              case ChangeBalanceStatus.lowBalance:
                errText = 'Недостаточно бонусов для списания';
                break;
              default:
            }

            return Column(
              children: [
                errText != null
                    ? Text(
                        errText,
                        style: const TextStyle(color: Colors.red),
                      )
                    : Container(),
                errText != null ? const SizedBox(height: 16) : Container(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (balanceLoginEditingController.text.isNotEmpty &&
                          balanceAmountEditingController.text.isNotEmpty &&
                          balanceAction != null) {
                        controller.changeBalance(
                            balanceLoginEditingController.text,
                            balanceAction!,
                            int.parse(balanceAmountEditingController.text));
                      }
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Выполнить'),
                    ),
                  ),
                ),
              ],
            );
          },
          onLoading: const Padding(
            padding: EdgeInsets.only(bottom: 16.0),
            child: CircularProgressIndicator(),
          ),
          onError: (err) => Column(
            children: [
              Text(
                'Ошибка: $err',
                style: const TextStyle(color: Colors.red),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (balanceLoginEditingController.text.isNotEmpty &&
                        balanceAmountEditingController.text.isNotEmpty &&
                        balanceAction != null) {
                      controller.changeBalance(
                          balanceLoginEditingController.text,
                          balanceAction!,
                          int.parse(balanceAmountEditingController.text));
                    }
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Выполнить'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _CheckContainerWidget extends StatelessWidget {
  const _CheckContainerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final contIdEditingController = TextEditingController();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 24.0),
          child: TextField(
            controller: contIdEditingController,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'ID контейнера',
              prefixIcon: Icon(Icons.person),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: ElevatedButton(
            onPressed: () {
              if (contIdEditingController.text.isNotEmpty) {
                SchedulerBinding.instance?.addPostFrameCallback((_) =>
                    Get.toNamed('/container/${contIdEditingController.text}'));
              }
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Перейти'),
            ),
          ),
        ),
      ],
    );
  }
}
