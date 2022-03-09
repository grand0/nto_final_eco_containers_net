import 'dart:async';

import 'package:get/get.dart';

import 'package:nto_final_eco_containers_net/models/user_model.dart';
import 'package:nto_final_eco_containers_net/providers/mock_provider.dart';

class UserController extends GetxController with StateMixin<UserModel> {
  final _provider = MockProvider();
  final String id;
  late final Timer timer;

  UserController(this.id) {
    loadData();
  }

  @override
  void onReady() {
    timer = Timer.periodic(const Duration(seconds: 5), (_) => loadData());
  }

  @override
  void onClose() {
    timer.cancel();
    super.onClose();
  }

  void loadData() {
    change(state, status: RxStatus.loadingMore());
    _provider.getUserData(id).then((model) {
      change(model, status: RxStatus.success());
    }, onError: (err) {
      change(null, status: RxStatus.error(err));
      printError(info: err);
    });
  }
}
