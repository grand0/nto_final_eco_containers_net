import 'package:nto_final_eco_containers_net/models/user_model.dart';

class AuthModel {
  late String id;
  late UserStatus status;

  AuthModel({required this.id, required this.status});

  AuthModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = getStatusByJsonName(json['status']);
  }

  bool get isError => id.isEmpty;

  UserStatus getStatusByJsonName(String name) {
    switch (name) {
      case 'user':
        return UserStatus.user;
      case 'admin':
        return UserStatus.admin;
    }
    throw ArgumentError.value(name, 'name', "Can't parse this value");
  }
}