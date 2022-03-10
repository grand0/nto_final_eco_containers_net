import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:nto_final_eco_containers_net/controllers/auth_controller.dart';
import 'package:nto_final_eco_containers_net/screens/common/rounded_button.dart';
import 'package:nto_final_eco_containers_net/screens/common/rounded_text_field.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  void _authorize(String login, String password, AuthController controller) {
    if (login.isNotEmpty && password.isNotEmpty) {
      controller.auth(login, password);
    }
  }

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
              RoundedTextField(
                controller: loginEditingController,
                label: 'Логин',
                prefixIcon: const Icon(Icons.person),
                onSubmitted: (_) => _authorize(
                  loginEditingController.text,
                  passwordEditingController.text,
                  controller,
                ),
                autofocus: true,
              ),
              const SizedBox(height: 16),
              RoundedTextFieldWithObscure(
                controller: passwordEditingController,
                label: 'Пароль',
                prefixIcon: const Icon(Icons.lock),
                onSubmitted: (_) => _authorize(
                  loginEditingController.text,
                  passwordEditingController.text,
                  controller,
                ),
              ),
              const SizedBox(height: 16),
              controller.obx(
                (model) {
                  controller.userStatus = model!.status;
                  controller.isAuthenticated = true;
                  controller.authenticatedForId = model.id;
                  SchedulerBinding.instance?.addPostFrameCallback((_) =>
                      Get.offNamed('/${model.status?.name}/${model.id}'));
                  return const Text('Вход выполнен!');
                },
                onEmpty: RoundedButton(
                  onPressed: () => _authorize(
                    loginEditingController.text,
                    passwordEditingController.text,
                    controller,
                  ),
                  label: 'Войти',
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
                    RoundedButton(
                      onPressed: () => _authorize(
                        loginEditingController.text,
                        passwordEditingController.text,
                        controller,
                      ),
                      label: 'Войти',
                    )
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
