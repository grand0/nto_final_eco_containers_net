import 'package:get/get.dart';
import 'package:nto_final_eco_containers_net/models/container_model.dart';
import 'package:nto_final_eco_containers_net/providers/mock_provider.dart';

class ContainerController extends GetxController
    with StateMixin<ContainerModel> {
  final _provider = MockProvider();
  final String id;

  ContainerController(this.id) {
    loadData();
  }

  void loadData() {
    change(null, status: RxStatus.loading());
    _provider.getContainerData(id).then((model) {
      change(model, status: RxStatus.success());
    }, onError: (err) {
      change(null, status: RxStatus.error(err));
      printError(info: err);
    });
  }

  void toggleLock() {
    change(
      state?..changingLock = true,
      status: RxStatus.loadingMore(),
    );
    _provider.toggleContainerLock(id).then((locked) {
      final model = (state
        ?..locked = locked
        ..changingLock = false);
      change(model, status: RxStatus.success());
    });
  }
}
