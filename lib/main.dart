import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nto_final_eco_containers_net/bindings/initial_binding.dart';
import 'package:nto_final_eco_containers_net/middlewares/auth_guard.dart';
import 'package:nto_final_eco_containers_net/screens/admin_page.dart';
import 'package:nto_final_eco_containers_net/screens/auth_page.dart';
import 'package:nto_final_eco_containers_net/screens/container_page.dart';
import 'package:nto_final_eco_containers_net/screens/user_page.dart';

final dateFormat = DateFormat('d/M/y H:m');

void main() => runApp(
      GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Эко-контейнеры',
        initialBinding: InitialBinding(),
        initialRoute: '/',
        getPages: [
          GetPage(
            name: '/',
            page: () => const AuthPage(),
          ),
          GetPage(
            name: '/user/:id',
            page: () => const UserPage(),
            middlewares: [
              AuthGuard(),
            ],
          ),
          GetPage(
            name: '/admin/:id',
            page: () => const AdminPage(),
            middlewares: [
              AuthGuard(),
            ],
          ),
          GetPage(
            name: '/container/:id',
            page: () => const ContainerPage(),
            middlewares: [
              AuthGuard(),
            ],
          ),
        ],
      ),
    );
