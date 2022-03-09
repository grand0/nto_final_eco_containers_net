import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:nto_final_eco_containers_net/screens/common/expandable_button.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Эко-контейнеры'),
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
    final userIdEditingController = TextEditingController();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 24.0),
          child: TextField(
            controller: userIdEditingController,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'ID пользователя',
              prefixIcon: Icon(Icons.person),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: ElevatedButton(
            onPressed: () {
              if (userIdEditingController.text.isNotEmpty) {
                SchedulerBinding.instance?.addPostFrameCallback(
                        (_) => Get.toNamed(
                        '/user/${userIdEditingController.text}'));
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


class _BalanceChangeWidget extends StatefulWidget {
  const _BalanceChangeWidget({Key? key}) : super(key: key);

  @override
  _BalanceChangeWidgetState createState() => _BalanceChangeWidgetState();
}

class _BalanceChangeWidgetState extends State<_BalanceChangeWidget> {
  _BalanceChangeAction? balanceAction = _BalanceChangeAction.add;
  final balanceUserIdEditingController = TextEditingController();
  final balanceAmountEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 16.0),
          child: TextField(
            controller: balanceUserIdEditingController,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'ID пользователя',
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
                  balanceAction = _BalanceChangeAction.add;
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Radio<_BalanceChangeAction>(
                    value: _BalanceChangeAction.add,
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
                  balanceAction = _BalanceChangeAction.delete;
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Radio<_BalanceChangeAction>(
                    value: _BalanceChangeAction.delete,
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
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: ElevatedButton(
            onPressed: () {
              if (balanceUserIdEditingController.text.isNotEmpty &&
                  balanceAmountEditingController.text.isNotEmpty) {
                printInfo(info: 'execute button pressed');
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
  }
}

enum _BalanceChangeAction { add, delete }

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
                SchedulerBinding.instance?.addPostFrameCallback(
                        (_) => Get.toNamed(
                        '/container/${contIdEditingController.text}'));
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
