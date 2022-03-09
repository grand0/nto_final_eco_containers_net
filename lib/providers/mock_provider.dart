import 'dart:math';

import 'package:nto_final_eco_containers_net/models/auth_model.dart';
import 'package:nto_final_eco_containers_net/models/change_balance_status.dart';
import 'package:nto_final_eco_containers_net/models/container_model.dart';
import 'package:nto_final_eco_containers_net/models/user_model.dart';
import 'package:nto_final_eco_containers_net/providers/provider.dart';

class MockProvider extends Provider {
  bool locked = false;

  @override
  Future<UserModel> getUserData(String id) async {
    return await Future.delayed(
      const Duration(seconds: 2),
      () => UserModel(
        login: 'ilya00',
        firstName: 'Илья',
        lastName: 'Пономарев',
        patronymic: 'Иванович',
        avatarUrl:
            'https://upload.wikimedia.org/wikipedia/commons/thumb/b/bf/Big_Floppa_and_Justin_2_%28cropped%29.jpg/660px-Big_Floppa_and_Justin_2_%28cropped%29.jpg',
        balance: Random().nextInt(100),
        address: 'ул. Пушкина, ${Random().nextInt(100)}',
        status: UserStatus.user,
        actions: [
          UserActionLog(
            time: DateTime.fromMillisecondsSinceEpoch(1646729236000),
            action: UserAction.add,
            amount: Random().nextInt(50),
            type: UserActionType.red,
          ),
          UserActionLog(
            time: DateTime.fromMillisecondsSinceEpoch(1646729345000),
            action: UserAction.add,
            amount: Random().nextInt(30),
            type: UserActionType.red,
          ),
          UserActionLog(
            time: DateTime.fromMillisecondsSinceEpoch(1646729355000),
            action: UserAction.delete,
            amount: Random().nextInt(15),
            type: UserActionType.noType,
          ),
        ],
      ),
    );
  }

  @override
  Future<ContainerModel> getContainerData(String id) async {
    final report1 = <ContainerDevice, bool>{};
    for (final d in ContainerDevice.values) {
      report1[d] = Random().nextBool();
    }
    final report2 = <ContainerDevice, bool>{};
    for (final d in ContainerDevice.values) {
      report2[d] = Random().nextBool();
    }
    final report3 = <ContainerDevice, bool>{};
    for (final d in ContainerDevice.values) {
      report3[d] = Random().nextBool();
    }

    return await Future.delayed(
      const Duration(seconds: 2),
      () => ContainerModel(
        redFull: Random().nextBool(),
        greenFull: Random().nextBool(),
        blueFull: Random().nextBool(),
        locked: locked,
        actions: [
          ContainerLog(
            login: 'ilya01',
            avatarUrl:
                'https://upload.wikimedia.org/wikipedia/commons/thumb/b/bf/Big_Floppa_and_Justin_2_%28cropped%29.jpg/845px-Big_Floppa_and_Justin_2_%28cropped%29.jpg',
            action: ContainerAction.add,
            amount: Random().nextInt(20) + 1,
            type: ContainerActionType.blue,
            time: DateTime.fromMillisecondsSinceEpoch(1646729236000),
          ),
          ContainerLog(
            login: 'vanya20',
            avatarUrl:
                'https://www.meme-arsenal.com/memes/cc93311366bfbca1bff40222ec269da9.jpg',
            action: ContainerAction.add,
            amount: Random().nextInt(20) + 1,
            type: ContainerActionType.red,
            time: DateTime.fromMillisecondsSinceEpoch(1646729336000),
          ),
          ContainerLog(
            login: 'Technician',
            avatarUrl:
                'https://www.meme-arsenal.com/memes/cc93311366bfbca1bff40222ec269da9.jpg',
            action: ContainerAction.service,
            amount: 0,
            type: ContainerActionType.service,
            time: DateTime.fromMillisecondsSinceEpoch(1646729536000),
          ),
        ],
        reports: [
          ContainerReport(
            DateTime.fromMillisecondsSinceEpoch(1646729536000),
            report1,
          ),
          ContainerReport(
            DateTime.fromMillisecondsSinceEpoch(1646729536000),
            report2,
          ),
          ContainerReport(
            DateTime.fromMillisecondsSinceEpoch(1646729536000),
            report3,
          ),
        ],
      ),
    );
  }

  @override
  Future<bool> toggleContainerLock(String id) async {
    locked = !locked;
    return await Future.delayed(const Duration(seconds: 2), () => locked);
  }

  @override
  Future<AuthModel> auth(String login, String password) {
    return Future.delayed(
      const Duration(seconds: 1),
      () => AuthModel(
        id: '1',
        status: login == 'admin' ? UserStatus.admin : UserStatus.user,
      ),
    );
  }

  @override
  Future<ChangeBalanceStatus> changeBalance(
      String login, UserAction action, int amount) {
    return Future.delayed(
        const Duration(seconds: 1), () => ChangeBalanceStatus.wrongLogin);
  }

  @override
  Future<String> getIdByLogin(String login) {
    return Future.delayed(const Duration(seconds: 1), () => '1');
  }
}
