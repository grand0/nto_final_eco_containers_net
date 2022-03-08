import 'dart:math';

import 'package:nto_final_eco_containers_net/models/user_model.dart';
import 'package:nto_final_eco_containers_net/providers/provider.dart';

class MockProvider extends Provider {
  @override
  Future<UserModel> getUserData(String id) async {
    return await Future.delayed(
      const Duration(seconds: 2),
      () => UserModel(
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
            id: id,
            action: UserAction.add,
            amount: Random().nextInt(50),
          ),
          UserActionLog(
            time: DateTime.fromMillisecondsSinceEpoch(1646729345000),
            id: id,
            action: UserAction.add,
            amount: Random().nextInt(30),
          ),
          UserActionLog(
            time: DateTime.fromMillisecondsSinceEpoch(1646729355000),
            id: id,
            action: UserAction.delete,
            amount: Random().nextInt(15),
          ),
        ],
      ),
    );
  }
}
