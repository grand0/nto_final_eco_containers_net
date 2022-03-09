class UserModel {
  late String firstName;
  late String lastName;
  late String? patronymic;
  late String avatarUrl;
  late int balance;
  late String address;
  late UserStatus status;
  late List<UserActionLog> actions;

  UserModel({
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
      '$firstName $lastName '
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
  late String id;
  late UserAction action;
  late int amount;

  UserActionLog({
    required this.time,
    required this.id,
    required this.action,
    required this.amount,
  });

  UserActionLog.fromJson(Map<String, dynamic> json) {
    time = DateTime.fromMillisecondsSinceEpoch(json['time'] * 1000);
    id = json['id'];
    action = getActionByJsonName(json['action']);
    amount = json['amount'];
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
}

enum UserAction { add, delete }

enum UserStatus { user, admin }
