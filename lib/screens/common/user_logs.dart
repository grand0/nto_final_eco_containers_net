import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nto_final_eco_containers_net/main.dart';
import 'package:nto_final_eco_containers_net/models/user_model.dart';

class UserLogs extends StatelessWidget {
  final List<UserActionLog> actions;

  const UserLogs({Key? key, required this.actions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<TableRow> rows = actions.map(
      (e) => TableRow(
        children: [
          _tableCell(dateFormat.format(e.time)),
          _tableCell(''),
          _tableCell(
              '${e.action == UserAction.add ? '+' : '-'}${e.amount} баллов'),
        ],
      ),
    ).toList();

    return Container(
      width: 700,
      child: Table(
        border: TableBorder(
          horizontalInside: BorderSide(color: Get.theme.colorScheme.primary),
        ),
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: <TableRow>[
          TableRow(
            decoration: BoxDecoration(
              color: Get.theme.colorScheme.primary,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0),
              ),
            ),
            children: [
              _tableHeaderCell('Время'),
              _tableHeaderCell('ID'),
              _tableHeaderCell('Действие'),
            ],
          ),
          ...rows,
        ],
      ),
    );
  }

  Widget _tableHeaderCell(String text) => Container(
        height: 50,
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        alignment: Alignment.center,
      );

  Widget _tableCell(String text) => Container(
        height: 50,
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
        alignment: Alignment.center,
      );
}
