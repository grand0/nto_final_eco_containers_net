class UserModel {
  late String login;
  late String firstName;
  late String lastName;
  late String? patronymic;
  late String avatarUrl;
  late int balance;
  late String address;
  late UserStatus status;
  late List<UserActionLog> actions;

  UserModel({
    required this.login,
    required this.firstName,
    required this.lastName,
    required this.patronymic,
    required this.avatarUrl,
    required this.balance,
    required this.address,
    required this.status,
    required this.actions,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    login = json['login'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    patronymic = json['patronymic'];
    avatarUrl = json['avatar'];
    balance = json['balance'];
    address = json['address'];
    status = getStatusByJsonName(json['status']);
    actions = (json['actions'] as List)
        .map((e) => UserActionLog.fromJson(e))
        .toList();
  }

  String get fullName =>
      '$lastName $firstName '
          '${patronymic == null || patronymic!.isEmpty ? '' : patronymic}';

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

class UserActionLog {
  late DateTime time;
  late UserAction action;
  late int amount;
  late UserActionType type;

  UserActionLog({
    required this.time,
    required this.action,
    required this.amount,
    required this.type,
  });

  UserActionLog.fromJson(Map<String, dynamic> json) {
    time = DateTime.fromMillisecondsSinceEpoch(json['time'] * 1000);
    action = getActionByJsonName(json['action']);
    amount = json['amount'];
    type = getTypeByJsonName(json['type']);
  }

  UserAction getActionByJsonName(String name) {
    switch (name) {
      case 'add':
        return UserAction.add;
      case 'delete':
        return UserAction.delete;
    }
    throw ArgumentError.value(name, 'name', "Can't parse this value");
  }

  UserActionType getTypeByJsonName(String name) {
    switch (name) {
      case 'red':
        return UserActionType.red;
      case 'green':
        return UserActionType.green;
      case 'blue':
        return UserActionType.blue;
      case '':
        return UserActionType.noType;
    }
    throw ArgumentError.value(name, 'name', "Can't parse this value");
  }
}

enum UserAction { add, delete }

enum UserStatus { user, admin }

enum UserActionType { red, green, blue, noType }
