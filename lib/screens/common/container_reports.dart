import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nto_final_eco_containers_net/main.dart';
import 'package:nto_final_eco_containers_net/models/container_model.dart';

class ContainerReports extends StatelessWidget {
  final List<ContainerReport> reports;

  const ContainerReports({Key? key, required this.reports}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<TableRow> rows = reports.map(
      (report) {
        final cells = [];
        cells.add(report.time);
        for (final d in ContainerDevice.values) {
          cells.add(report.report[d]);
        }

        return TableRow(
          children: cells.map((e) {
            if (e is DateTime) {
              return _tableCell(Text(dateFormat.format(e)));
            }

            return _tableCell(
              e
                  ? const Icon(
                      Icons.check,
                      color: Colors.green,
                    )
                  : const Icon(
                      Icons.close,
                      color: Colors.red,
                    ),
            );
          }).toList(),
        );
      },
    ).toList();

    final List<Widget> headerCells = [_tableHeaderCell('Время')];
    for (final d in ContainerDevice.values) {
      headerCells.add(_tableHeaderCell(d.getTableName()));
    }

    return Container(
      width: 800,
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
            children: headerCells,
          ),
          ...rows,
        ],
      ),
    );
  }

  Widget _tableHeaderCell(String text) => RotatedBox(
        quarterTurns: 1,
        child: Container(
          height: 50,
          child: Text(
            text.replaceAll(' ', '\n'),
            style: const TextStyle(
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          alignment: Alignment.center,
        ),
      );

  Widget _tableCell(Widget content) => Container(
        height: 50,
        child: content,
        alignment: Alignment.center,
      );
}
