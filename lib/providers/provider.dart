import 'package:get/get.dart';
import 'package:nto_final_eco_containers_net/models/auth_model.dart';
import 'package:nto_final_eco_containers_net/models/change_balance_status.dart';
import 'package:nto_final_eco_containers_net/models/container_model.dart';
import 'package:nto_final_eco_containers_net/models/user_model.dart';

abstract class Provider extends GetConnect {
  Future<UserModel> getUserData(String id);

  Future<String> getIdByLogin(String login);

  Future<ChangeBalanceStatus> changeBalance(String login, UserAction action, int amount);

  Future<ContainerModel> getContainerData(String id);

  Future<bool> toggleContainerLock(String login);

  Future<AuthModel> auth(String login, String password);
}
