import 'package:flutter/material.dart';
import 'package:nto_final_eco_containers_net/screens/common/user_info.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Эко-контейнеры'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: const [
            UserInfo(
                balance: 90,
                avatarUrl:
                    "https://upload.wikimedia.org/wikipedia/commons/thumb/b/bf/Big_Floppa_and_Justin_2_%28cropped%29.jpg/660px-Big_Floppa_and_Justin_2_%28cropped%29.jpg",
                name: 'Илья Пономарев',
                address: 'ул. Пушкина, 89'),

          ],
        ),
      ),
    );
  }
}
