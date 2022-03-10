import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:nto_final_eco_containers_net/bindings/initial_binding.dart';
import 'package:nto_final_eco_containers_net/screens/admin_page.dart';
import 'package:nto_final_eco_containers_net/screens/auth_page.dart';
import 'package:nto_final_eco_containers_net/screens/container_page.dart';
import 'package:nto_final_eco_containers_net/screens/user_page.dart';

final dateFormat = DateFormat('dd MMM, EEE HH:mm', 'ru');
final excelDateFormat = DateFormat('dd.MM.y HH:mm', 'ru');

void main() {
  initializeDateFormatting('ru');
  runApp(
    GetMaterialApp(
      theme: ThemeData.light().copyWith(
        radioTheme: RadioThemeData(
            fillColor: MaterialStateProperty.all(Colors.indigo)),
        colorScheme: const ColorScheme.light().copyWith(
          primary: Colors.indigo,
        ),
      ),
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
        ),
        GetPage(
          name: '/admin/:id',
          page: () => const AdminPage(),
        ),
        GetPage(
          name: '/container/:id',
          page: () => const ContainerPage(),
        ),
      ],
    ),
  );
}
