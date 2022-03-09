class ContainerModel {
  late bool redFull;
  late bool greenFull;
  late bool blueFull;
  late bool locked;
  bool changingLock = false;
  late List<ContainerLog> actions;

  ContainerModel({
    required this.redFull,
    required this.greenFull,
    required this.blueFull,
    required this.actions,
    required this.locked,
  });

  ContainerModel.fromJson(Map<String, dynamic> json) {
    redFull = json['red_full'];
    greenFull = json['green_full'];
    blueFull = json['blue_full'];
    actions =
        (json['actions'] as List).map((e) => ContainerLog.fromJson(e)).toList();
    locked = json['locked'];
  }
}

class ContainerLog {
  late String login;
  late String avatarUrl;
  late ContainerAction action;
  late int amount;
  late ContainerActionType type;
  late DateTime time;

  ContainerLog({
    required this.login,
    required this.avatarUrl,
    required this.action,
    required this.amount,
    required this.type,
    required this.time,
  });

  ContainerLog.fromJson(Map<String, dynamic> json) {
    login = json['login'];
    avatarUrl = json['avatar'];
    action = getActionByName(json['action']);
    amount = json['amount'];
    type = getTypeByName(json['type']);
    time = DateTime.fromMillisecondsSinceEpoch(json['time'] * 1000);
  }

  ContainerAction getActionByName(String name) {
    switch (name) {
      case 'add':
        return ContainerAction.add;
      case 'service':
        return ContainerAction.service;
    }
    throw ArgumentError.value(name, 'name', "Can't parse this value");
  }

  ContainerActionType getTypeByName(String name) {
    switch (name) {
      case 'red':
        return ContainerActionType.red;
      case 'green':
        return ContainerActionType.green;
      case 'blue':
        return ContainerActionType.blue;
      case 'service':
        return ContainerActionType.service;
    }
    throw ArgumentError.value(name, 'name', "Can't parse this value");
  }
}

enum ContainerAction { add, service }

enum ContainerActionType { red, green, blue, service }
