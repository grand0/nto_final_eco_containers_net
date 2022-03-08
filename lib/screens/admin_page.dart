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
    final checkUserIdEditingController = TextEditingController();

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
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Админ-панель',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 44.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ExpandableButton(
                icon: const Icon(Icons.person),
                label: const Text('Информация о пользователе'),
                contents: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 24.0),
                      child: TextField(
                        controller: checkUserIdEditingController,
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
                          if (checkUserIdEditingController.text.isNotEmpty) {
                            SchedulerBinding.instance?.addPostFrameCallback(
                                (_) => Get.toNamed(
                                    '/user/${checkUserIdEditingController.text}'));
                          }
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Перейти'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              ExpandableButton(
                icon: const Icon(MdiIcons.handCoin),
                label: const Text('Изменить баланс пользователя'),
                contents: _BalanceChangeWidget(),
              ),
              const SizedBox(height: 16),
              ExpandableButton(
                icon: Icon(MdiIcons.trashCan),
                label: Text('Информация о контейнерах'),
                contents: Container(),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class _BalanceChangeWidget extends StatefulWidget {
  const _BalanceChangeWidget({Key? key}) : super(key: key);

  @override
  _BalanceChangeWidgetState createState() => _BalanceChangeWidgetState();
}

class _BalanceChangeWidgetState extends State<_BalanceChangeWidget> {
  BalanceChangeAction? balanceAction = BalanceChangeAction.add;
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
                  balanceAction = BalanceChangeAction.add;
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Radio<BalanceChangeAction>(
                    value: BalanceChangeAction.add,
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
                  balanceAction = BalanceChangeAction.delete;
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Radio<BalanceChangeAction>(
                    value: BalanceChangeAction.delete,
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
                print('button pressed');
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

enum BalanceChangeAction { add, delete }
