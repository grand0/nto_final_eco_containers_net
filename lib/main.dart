import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nto_final_eco_containers_net/screens/user_page.dart';

void main() => runApp(
      GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Эко-контейнеры',
        initialRoute: '/user/1',
        getPages: [
          GetPage(
            name: '/user/:id',
            page: () => const HomePage(),
          ),
        ],
      ),
    );
