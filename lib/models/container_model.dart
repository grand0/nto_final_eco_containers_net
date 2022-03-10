class ContainerModel {
  late bool redFull;
  late bool greenFull;
  late bool blueFull;
  late bool locked;
  bool changingLock = false;
  bool changingError = false;
  late List<ContainerLog> actions;
  late List<ContainerReport> reports;

  ContainerModel({
    required this.redFull,
    required this.greenFull,
    required this.blueFull,
    required this.locked,
    required this.actions,
    required this.reports,
  });

  ContainerModel.fromJson(Map<String, dynamic> json) {
    redFull = json['red_full'];
    greenFull = json['green_full'];
    blueFull = json['blue_full'];
    locked = json['locked'];
    actions =
        (json['actions'] as List).map((e) => ContainerLog.fromJson(e)).toList();
    reports = (json['reports'] as List)
        .map((e) => ContainerReport.fromJson(e))
        .toList();
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

class ContainerReport {
  late DateTime time;
  late Map<ContainerDevice, bool> report;

  ContainerReport(this.time, this.report);

  ContainerReport.fromJson(Map<String, dynamic> json) {
    time = DateTime.fromMillisecondsSinceEpoch(json['time'] * 1000);
    report = {};
    for (final d in ContainerDevice.values) {
      report[d] = json[d.getJsonName()];
    }
  }
}

enum ContainerDevice {
  servoRed,
  servoGreen,
  servoBlue,
  typeRed,
  typeGreen,
  typeBlue,
  overflowRed,
  overflowGreen,
  overflowBlue,
}

extension ContainerDeviceExt on ContainerDevice {
  String getJsonName() {
    return toString().split('.').last;
  }

  String getTableName() {
    switch (this) {
      case ContainerDevice.servoRed:
        return 'Сервопривод (пластик)';
      case ContainerDevice.servoGreen:
        return 'Сервопривод (бумага)';
      case ContainerDevice.servoBlue:
        return 'Сервопривод (стекло)';
      case ContainerDevice.typeRed:
        return 'Датчик пластика';
      case ContainerDevice.typeGreen:
        return 'Датчик бумаги';
      case ContainerDevice.typeBlue:
        return 'Датчик стекла';
      case ContainerDevice.overflowRed:
        return 'Датчик переполнения пластика';
      case ContainerDevice.overflowGreen:
        return 'Датчик переполнения бумаги';
      case ContainerDevice.overflowBlue:
        return 'Датчик переполнения стекла';
    }
  }
}
