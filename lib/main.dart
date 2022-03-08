import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nto_final_eco_containers_net/screens/home_page.dart';

void main() => runApp(
      GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Эко-контейнеры',
        initialRoute: '/',
        getPages: [
          GetPage(
            name: '/',
            page: () => const HomePage(),
          ),
        ],
      ),
    );
