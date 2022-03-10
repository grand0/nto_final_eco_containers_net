import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:get/get.dart';
import 'package:nto_final_eco_containers_net/models/auth_model.dart';
import 'package:nto_final_eco_containers_net/models/user_model.dart';
import 'package:nto_final_eco_containers_net/providers/provider.dart';

class AuthController extends GetxController with StateMixin<AuthModel> {
  final Provider _provider = currentProvider;
  bool isAuthenticated = false;
  String? authenticatedForId;
  UserStatus? userStatus;

  @override
  void onInit() {
    change(null, status: RxStatus.empty());
    super.onInit();
  }

  void auth(String login, String password) {
    change(null, status: RxStatus.loading());
    _provider
        .auth(login, sha256.convert(utf8.encode(password)).toString())
        .then((model) {
          if (model.isError) {
            change(null, status: RxStatus.error('no user'));
          } else {
            change(model, status: RxStatus.success());
          }
    }, onError: (err) {
      change(null, status: RxStatus.error(err));
    });
  }

  void clearAuthentication() {
    change(null, status: RxStatus.empty());
    isAuthenticated = false;
    userStatus = null;
    authenticatedForId = null;
  }
}
