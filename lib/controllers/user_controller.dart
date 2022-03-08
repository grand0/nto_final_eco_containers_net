import 'package:get/get.dart';

import 'package:nto_final_eco_containers_net/models/user_model.dart';
import 'package:nto_final_eco_containers_net/providers/mock_provider.dart';

class UserController extends GetxController with StateMixin<UserModel> {
  final _provider = MockProvider();
  final String id;

  UserController(this.id) {
    loadData();
  }

  void loadData() {
    change(null, status: RxStatus.loading());
    _provider.getUserData(id).then((model) {
      change(model, status: RxStatus.success());
    }, onError: (err) {
      change(null, status: RxStatus.error(err));
      printError(info: err);
    });
  }
}
