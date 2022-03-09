import 'package:get/get.dart';
import 'package:nto_final_eco_containers_net/providers/provider.dart';

class CheckUserController extends GetxController with StateMixin<String> {
  final Provider _provider = currentProvider;

  @override
  void onInit() {
    change(null, status: RxStatus.success());
    super.onInit();
  }

  void getIdByLogin(String login) {
    change(null, status: RxStatus.loading());
    _provider.getIdByLogin(login).then((value) {
      change(value, status: RxStatus.success());
    }, onError: (err) {
      change(null, status: RxStatus.error(err));
      printError(info: err);
    });
  }
}