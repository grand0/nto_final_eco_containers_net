import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nto_final_eco_containers_net/screens/admin_page.dart';
import 'package:nto_final_eco_containers_net/screens/container_page.dart';
import 'package:nto_final_eco_containers_net/screens/user_page.dart';

final dateFormat = DateFormat('d/M/y H:m');

void main() => runApp(
      GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Эко-контейнеры',
        initialRoute: '/admin',
        getPages: [
          GetPage(
            name: '/user/:id',
            page: () => const HomePage(),
          ),
          GetPage(
            name: '/admin',
            page: () => const AdminPage(),
          ),
          GetPage(
            name: '/container/:id',
            page: () => const ContainerPage(),
          ),
        ],
      ),
    );
