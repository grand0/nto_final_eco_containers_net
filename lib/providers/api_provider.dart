import 'dart:convert';

import 'package:nto_final_eco_containers_net/models/user_model.dart';
import 'package:nto_final_eco_containers_net/providers/provider.dart';

class ApiProvider extends Provider {
  static const String url = 'http://localhost:8000/api';

  @override
  Future<UserModel> getUserData(String id) async {
    final resp = await get('$url/user?id=$id');
    if (resp.status.hasError) {
      return Future.error(resp.statusText ?? '');
    } else {
      try {
        UserModel model = UserModel.fromJson(jsonDecode(resp.bodyString ?? ''));
        return model;
      } catch (e) {
        return Future.error(e);
      }
    }
  }
}