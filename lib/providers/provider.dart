import 'package:get/get.dart';
import 'package:nto_final_eco_containers_net/models/container_model.dart';
import 'package:nto_final_eco_containers_net/models/user_model.dart';

abstract class Provider extends GetConnect {
  Future<UserModel> getUserData(String id);

  Future<ContainerModel> getContainerData(String id);

  Future<void> toggleContainerLock(String id);
}