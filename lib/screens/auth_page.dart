import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:nto_final_eco_containers_net/controllers/auth_controller.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();
    controller.clearAuthentication();

    final loginEditingController = TextEditingController();
    final passwordEditingController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Эко-контейнеры'),
      ),
      body: Center(
        child: Container(
          width: 350,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Вход',
                style: TextStyle(fontSize: 30),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: loginEditingController,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Логин',
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: passwordEditingController,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Пароль',
                  prefixIcon: Icon(Icons.lock),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 16),
              controller.obx(
                (model) {
                  controller.userStatus = model!.status;
                  controller.isAuthenticated = true;
                  SchedulerBinding.instance?.addPostFrameCallback(
                      (_) => Get.offNamed('/${model.status.name}/${model.id}'));
                  return const Text('Вход выполнен!');
                },
                onEmpty: ElevatedButton(
                  onPressed: () {
                    controller.auth(loginEditingController.text,
                        passwordEditingController.text);
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Войти'),
                  ),
                ),
                onLoading: const CircularProgressIndicator(),
                onError: (err) => Column(
                  children: [
                    Text(
                      err == 'no user'
                          ? 'Пользователь не найден, либо пароль неверен'
                          : 'Ошибка: $err',
                      style: const TextStyle(color: Colors.red),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        controller.auth(loginEditingController.text,
                            passwordEditingController.text);
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Войти'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
