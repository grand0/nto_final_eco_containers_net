import 'package:excel/excel.dart';
import 'package:nto_final_eco_containers_net/main.dart';
import 'package:nto_final_eco_containers_net/models/container_model.dart';

void createAndDownloadExcelReport(List<ContainerReport> reports) {
  var excel = Excel.createExcel();
  Sheet sheet = excel['Sheet1'];
  final font = getFontFamily(FontFamily.Calibri);
  final headerStyle = CellStyle(
    backgroundColorHex: '#5209BD',
    fontColorHex: '#FFFFFF',
    fontFamily: font,
    bold: true,
    horizontalAlign: HorizontalAlign.Center,
    textWrapping: TextWrapping.WrapText,
  );
  final okStyle = CellStyle(
    backgroundColorHex: '#C6EFCE',
    fontColorHex: '#006100',
    fontFamily: font,
    horizontalAlign: HorizontalAlign.Center,
    bold: true,
  );
  final failStyle = CellStyle(
    backgroundColorHex: '#FFC7CE',
    fontColorHex: '#9C0006',
    fontFamily: font,
    horizontalAlign: HorizontalAlign.Center,
    bold: true,
  );
  final normalStyle = CellStyle(fontFamily: font);

  final List<String> headerRow = [
    'Время',
    ...ContainerDevice.values
        .map((e) => e.getTableName())
        .toList(),
  ];
  for (int i = 0; i < headerRow.length; i++) {
    var cell =
        sheet.cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 0));
    cell.cellStyle = headerStyle;
    cell.value = headerRow[i];
  }

  for (int i = 0; i < reports.length; i++) {
    var cell =
        sheet.cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: i + 1));
    cell.cellStyle = normalStyle;
    cell.value = excelDateFormat.format(reports[i].time);
    for (int j = 0; j < ContainerDevice.values.length; j++) {
      cell = sheet.cell(
          CellIndex.indexByColumnRow(columnIndex: j + 1, rowIndex: i + 1));
      bool isOk = reports[i].report[ContainerDevice.values[j]]!;
      if (isOk) {
        cell.cellStyle = okStyle;
        cell.value = '+';
      } else {
        cell.cellStyle = failStyle;
        cell.value = '-';
      }
    }
  }
  for (int i = 0; i < headerRow.length; i++) {
    sheet.setColWidth(i, 13.5);
  }
  excel.save(
      fileName: 'Отчёты ${excelDateFormat.format(DateTime.now())}.xlsx');
}

