import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nto_final_eco_containers_net/main.dart';
import 'package:nto_final_eco_containers_net/models/container_model.dart';

class ContainerLogs extends StatelessWidget {
  final List<ContainerLog> actions;

  const ContainerLogs({Key? key, required this.actions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<TableRow> rows = actions.map(
      (e) {
        String note = '';
        switch (e.action) {
          case ContainerAction.add:
            note = '+${e.amount} баллов';
            break;
          case ContainerAction.service:
            note = 'Выгрузка мусора';
            break;
        }
        Color? indicatorColor;
        switch (e.type) {
          case ContainerActionType.red:
            indicatorColor = Colors.red;
            break;
          case ContainerActionType.green:
            indicatorColor = Colors.green;
            break;
          case ContainerActionType.blue:
            indicatorColor = Colors.blue;
            break;
          case ContainerActionType.service:
            indicatorColor = null;
            break;
        }
        return TableRow(
          children: [
            _tableCell(dateFormat.format(e.time)),
            _tableCell(
              e.login,
              prefix: CircleAvatar(
                backgroundImage: Image.network(e.avatarUrl).image,
                minRadius: 15,
              ),
            ),
            _tableCell(
              note,
              suffix: indicatorColor != null
                  ? Container(
                      width: 15,
                      height: 15,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7.5),
                        color: indicatorColor,
                      ),
                    )
                  : null,
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
              _tableHeaderCell('Пользователь'),
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

  Widget _tableCell(String text, {Widget? prefix, Widget? suffix}) {
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
            style: const TextStyle(
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
