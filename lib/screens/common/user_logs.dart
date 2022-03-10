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
      (e) {
        Color? indicatorColor;
        String typeText;
        switch (e.type) {
          case UserActionType.red:
            indicatorColor = Colors.red;
            typeText = 'Пластик';
            break;
          case UserActionType.green:
            indicatorColor = Colors.green;
            typeText = 'Бумага';
            break;
          case UserActionType.blue:
            indicatorColor = Colors.blue;
            typeText = 'Стекло';
            break;
          case UserActionType.noType:
            indicatorColor = null;
            typeText = 'Действие администратора';
            break;
        }
        return TableRow(
          children: [
            _tableCell(dateFormat.format(e.time)),
            _tableCell(
              '${e.action == UserAction.add ? '+' : '-'}${e.amount} баллов',
            ),
            _tableCell(
              typeText,
              prefix: indicatorColor != null
                  ? Container(
                      width: 15,
                      height: 15,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7.5),
                        color: indicatorColor,
                      ),
                    )
                  : null,
              style: e.type == UserActionType.noType ? const TextStyle(
                color: Colors.grey,
                fontStyle: FontStyle.italic,
              ) : null,
            ),
          ],
        );
      },
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
              _tableHeaderCell('Действие'),
              _tableHeaderCell('Тип мусора'),
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
          ),
          textAlign: TextAlign.center,
        ),
        alignment: Alignment.center,
      );

  Widget _tableCell(String text,
      {Widget? prefix, Widget? suffix, TextStyle? style}) {
    return Container(
      height: 50,
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          prefix ?? Container(),
          prefix != null ? const SizedBox(width: 12) : Container(),
          Text(
            text,
            style: style ??
                const TextStyle(
                  color: Colors.black,
                ),
            textAlign: TextAlign.center,
          ),
          suffix != null ? const SizedBox(width: 12) : Container(),
          suffix ?? Container(),
        ],
      ),
    );
  }
}
