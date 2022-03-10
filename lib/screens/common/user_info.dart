import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nto_final_eco_containers_net/screens/common/text_with_icon.dart';

class UserInfo extends StatelessWidget {
  final String avatarUrl;
  final String name;
  final int balance;
  final String address;
  final String login;
  final String id;
  final bool showBalance;

  const UserInfo({
    Key? key,
    required this.balance,
    required this.avatarUrl,
    required this.name,
    required this.address,
    required this.login,
    required this.id,
    this.showBalance = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          backgroundImage: Image.network(avatarUrl).image,
          backgroundColor: Colors.grey.shade200,
          maxRadius: 50.0,
          minRadius: 50.0,
        ),
        const SizedBox(height: 8),
        Text(
          name,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 30,
          ),
        ),
        const SizedBox(height: 8),
        TextWithIcon(
          icon: Icons.person,
          text: login,
          color: Colors.grey,
        ),
        const SizedBox(height: 4),
        TextWithIcon(
          icon: Icons.tag,
          text: id,
          color: Colors.grey,
        ),
        const SizedBox(height: 4),
        TextWithIcon(
          icon: Icons.home,
          text: address,
          color: Colors.grey,
        ),
        const SizedBox(height: 8),
        showBalance
            ? Container(
                width: 300,
                height: 200,
                margin: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Get.theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(15.0),
                  image: DecorationImage(
                    image: Image.asset(
                      'assets/images/coin.png',
                      fit: BoxFit.fitWidth,
                    ).image,
                    opacity: 0.2,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Баланс:',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        '$balance',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        'бонусов',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Container(),
      ],
    );
  }
}
