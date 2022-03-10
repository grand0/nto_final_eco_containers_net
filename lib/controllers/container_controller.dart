import 'dart:async';

import 'package:get/get.dart';
import 'package:nto_final_eco_containers_net/models/container_model.dart';
import 'package:nto_final_eco_containers_net/providers/provider.dart';

class ContainerController extends GetxController
    with StateMixin<ContainerModel> {
  final Provider _provider = currentProvider;
  final String id;
  Timer? timer;

  ContainerController(this.id) {
    loadData();
    change(null, status: RxStatus.loading());
  }

  @override
  void onReady() {
    timer = Timer.periodic(const Duration(seconds: 5), (_) => loadData());
  }

  @override
  void onClose() {
    timer?.cancel();
    super.onClose();
  }

  void loadData() {
    change(state, status: RxStatus.loadingMore());
    _provider.getContainerData(id).then((model) {
      change(model, status: RxStatus.success());
    }, onError: (err) {
      change(null, status: RxStatus.error(err));
      printError(info: err);
    });
  }

  void toggleLock() {
    timer?.cancel();
    change(
      state
        ?..changingLock = true
        ..changingError = false,
      status: RxStatus.loadingMore(),
    );
    _provider.toggleContainerLock(id).then(
      (locked) {
        final model = (state
          ?..locked = locked
          ..changingLock = false);
        change(model, status: RxStatus.success());
        timer = Timer.periodic(const Duration(seconds: 5), (_) => loadData());
      },
      onError: (err) {
        change(
            state
              ?..changingLock = false
              ..changingError = true,
            status: RxStatus.success());
        timer = Timer.periodic(const Duration(seconds: 5), (_) => loadData());
      },
    );
  }
}
