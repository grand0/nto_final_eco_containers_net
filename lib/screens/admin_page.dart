import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:nto_final_eco_containers_net/controllers/auth_controller.dart';
import 'package:nto_final_eco_containers_net/controllers/change_balance_controller.dart';
import 'package:nto_final_eco_containers_net/controllers/check_user_controller.dart';
import 'package:nto_final_eco_containers_net/controllers/user_controller.dart';
import 'package:nto_final_eco_containers_net/models/change_balance_status.dart';
import 'package:nto_final_eco_containers_net/models/user_model.dart';
import 'package:nto_final_eco_containers_net/screens/common/expandable_button.dart';
import 'package:nto_final_eco_containers_net/screens/common/rounded_button.dart';
import 'package:nto_final_eco_containers_net/screens/common/rounded_text_field.dart';
import 'package:nto_final_eco_containers_net/screens/common/user_info.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String id = Get.parameters['id']!;

    final authController = Get.find<AuthController>();
    if (!authController.isAuthenticated ||
        !(authController.userStatus == UserStatus.admin &&
            authController.authenticatedForId == id)) {
      SchedulerBinding.instance?.addPostFrameCallback((_) {
        Get.offNamed('/');
      });
    }

    Get.put(CheckUserController());
    Get.put(ChangeBalanceController());
    final UserController userController =
        Get.put(UserController(id), tag: 'admin');

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
            children: [
              const SizedBox(height: 16),
              userController.obx(
                (model) => UserInfo(
                  balance: 0,
                  avatarUrl: model!.avatarUrl,
                  name: model.fullName,
                  address: model.address,
                  login: model.login,
                  id: id,
                  showBalance: false,
                ),
              ),
              const SizedBox(height: 32),
              const Text(
                'Админ-панель',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30.0,
                ),
              ),
              const SizedBox(height: 16),
              const ExpandableButton(
                icon: Icon(Icons.person),
                label: Text('Информация о пользователе'),
                contents: _UserCheckWidget(),
              ),
              const SizedBox(height: 16),
              const ExpandableButton(
                icon: Icon(MdiIcons.handCoin),
                label: Text('Изменить баланс пользователя'),
                contents: _BalanceChangeWidget(),
              ),
              const SizedBox(height: 16),
              const ExpandableButton(
                icon: Icon(MdiIcons.trashCan),
                label: Text('Информация о контейнерах'),
                contents: _CheckContainerWidget(),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class _UserCheckWidget extends StatelessWidget {
  const _UserCheckWidget({Key? key}) : super(key: key);

  void submit(String login, CheckUserController controller) {
    if (login.isNotEmpty) {
      controller.getIdByLogin(login);
    }
  }

  @override
  Widget build(BuildContext context) {
    final loginEditingController = TextEditingController();
    final controller = Get.find<CheckUserController>();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(24.0, 8.0, 24.0, 16.0),
          child: RoundedTextField(
            controller: loginEditingController,
            label: 'Имя пользователя',
            prefixIcon: const Icon(Icons.person),
            onSubmitted: (_) => submit(loginEditingController.text, controller),
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
              child: RoundedButton(
                label: 'Перейти',
                onPressed: () =>
                    submit(loginEditingController.text, controller),
                width: 350,
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
                  child: RoundedButton(
                    label: 'Перейти',
                    onPressed: () =>
                        submit(loginEditingController.text, controller),
                    width: 350,
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

  void submit(ChangeBalanceController controller) {
    if (balanceLoginEditingController.text.isNotEmpty &&
        balanceAmountEditingController.text.isNotEmpty &&
        balanceAction != null) {
      controller.changeBalance(
          balanceLoginEditingController.text,
          balanceAction!,
          int.parse(balanceAmountEditingController.text));
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ChangeBalanceController>();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(24.0, 8.0, 24.0, 16.0),
          child: RoundedTextField(
            controller: balanceLoginEditingController,
            label: 'Имя пользователя',
            prefixIcon: const Icon(Icons.person),
            onSubmitted: (_) => submit(controller),
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
          padding: const EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 16.0),
          child: RoundedTextField(
            controller: balanceAmountEditingController,
            label: 'Бонусов',
            prefixIcon: const Icon(Icons.toll),
            onSubmitted: (_) => submit(controller),
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
              case ChangeBalanceStatus.ok:
                errText = 'Баланс изменён';
                break;
              default:
            }
            return Column(
              children: [
                errText != null
                    ? Text(
                        errText,
                        style: TextStyle(
                            color: status == ChangeBalanceStatus.ok
                                ? Colors.green
                                : Colors.red),
                      )
                    : Container(),
                errText != null ? const SizedBox(height: 16) : Container(),
                RoundedButton(
                  onPressed: () => submit(controller),
                  label: 'Выполнить',
                  width: 350,
                ),
                const SizedBox(height: 16),
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
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: RoundedButton(
                  onPressed: () => submit(controller),
                  label: 'Выполнить',
                  width: 350,
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

  void submit(String id) {
    if (id.isNotEmpty) {
      SchedulerBinding.instance?.addPostFrameCallback((_) =>
          Get.toNamed('/container/$id'));
    }
  }

  @override
  Widget build(BuildContext context) {
    final contIdEditingController = TextEditingController();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(24.0, 8.0, 24.0, 16.0),
          child: RoundedTextField(
            label: 'ID контейнера',
            controller: contIdEditingController,
            prefixIcon: const Icon(Icons.tag),
            onSubmitted: (_) => submit(contIdEditingController.text),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: RoundedButton(
            onPressed: () => submit(contIdEditingController.text),
            label: 'Перейти',
            width: 350,
          ),
        ),
      ],
    );
  }
}
