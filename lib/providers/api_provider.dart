import 'dart:convert';

import 'package:nto_final_eco_containers_net/models/auth_model.dart';
import 'package:nto_final_eco_containers_net/models/change_balance_status.dart';
import 'package:nto_final_eco_containers_net/models/container_model.dart';
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
        final UserModel model = UserModel.fromJson(jsonDecode(resp.bodyString ?? ''));
        return model;
      } catch (e) {
        return Future.error(e);
      }
    }
  }

  @override
  Future<ContainerModel> getContainerData(String id) async {
    final resp = await get('$url/container');
    if (resp.status.hasError) {
      return Future.error(resp.statusText ?? '');
    } else {
      try {
        final ContainerModel model =
            ContainerModel.fromJson(jsonDecode(resp.bodyString ?? ''));
        return model;
      } catch (e) {
        return Future.error(e);
      }
    }
  }

  @override
  Future<bool> toggleContainerLock(String id) async {
    final resp = await post('$url/toggle', '');
    if (resp.status.hasError) {
      return Future.error(resp.statusText ?? '');
    } else {
      try {
        final bool locked =
            (jsonDecode(resp.bodyString ?? '') as Map<String, bool>)['locked']!;
        return locked;
      } catch (e) {
        return Future.error(e);
      }
    }
  }

  @override
  Future<AuthModel> auth(String login, String password) async {
    final resp = await post(
        '$url/auth', jsonEncode({'login': login, 'password': password}));
    if (resp.status.hasError) {
      return Future.error(resp.statusText ?? '');
    } else {
      try {
        final AuthModel model =
            AuthModel.fromJson(jsonDecode(resp.bodyString ?? ''));
        return model;
      } catch (e) {
        return Future.error(e);
      }
    }
  }

  @override
  Future<ChangeBalanceStatus> changeBalance(
      String login, UserAction action, int amount) async {
    final resp = await post('$url/change',
        jsonEncode({'login': login, 'action': action.name, 'amount': amount}));
    if (resp.status.hasError) {
      return Future.error(resp.statusText ?? '');
    } else {
      try {
        final String statusName = (jsonDecode(resp.bodyString ?? '') as Map<String, String>)['status']!;
        switch (statusName) {
          case 'ok':
            return ChangeBalanceStatus.ok;
          case 'wrong_login':
            return ChangeBalanceStatus.wrongLogin;
          case 'low_balance':
            return ChangeBalanceStatus.lowBalance;
        }
        throw UnsupportedError('Unsupported status name: $statusName');
      } catch (e) {
        return Future.error(e);
      }
    }
  }

  @override
  Future<String> getIdByLogin(String login) async {
    final resp = await get('$url/idByLogin?login=$login');
    if (resp.status.hasError) {
      return Future.error(resp.statusText ?? '');
    } else {
      try {
        final String id = (jsonDecode(resp.bodyString ?? '') as Map<String, String>)['id']!;
        if (id == '') {
          return Future.error('no user');
        }
        return id;
      } catch (e) {
        return Future.error(e);
      }
    }
  }
}
