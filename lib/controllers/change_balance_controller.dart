import 'package:get/get.dart';
import 'package:nto_final_eco_containers_net/models/change_balance_status.dart';
import 'package:nto_final_eco_containers_net/models/user_model.dart';
import 'package:nto_final_eco_containers_net/providers/mock_provider.dart';
import 'package:nto_final_eco_containers_net/providers/provider.dart';

class ChangeBalanceController extends GetxController
    with StateMixin<ChangeBalanceStatus> {
  final Provider _provider = MockProvider();

  @override
  void onInit() {
    change(null, status: RxStatus.success());
    super.onInit();
  }

  void changeBalance(String login, UserAction action, int amount) {
    change(null, status: RxStatus.loading());
    _provider.changeBalance(login, action, amount).then((value) {
      change(value, status: RxStatus.success());
    }, onError: (err) {
      change(null, status: RxStatus.error(err));
      printError(info: err);
    });
  }
}
