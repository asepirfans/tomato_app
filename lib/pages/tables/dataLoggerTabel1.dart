import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tomato_smart_farm/controllers/sensors_con.dart';
import 'package:tomato_smart_farm/models/allSensor.dart';
import '../../routes/route_name.dart';
import 'package:intl/intl.dart';
import '../../tools/color.dart';
// import 'package:excel/excel.dart';
// import 'dart:io';
// import 'package:open_file/open_file.dart';

class DataLoggerTabel1 extends StatelessWidget {
  final SensorsController sensorsController = Get.put(SensorsController());

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (!didPop) {
          Get.offAllNamed(RouteName.dataLoggerPage);
        }
      },
      child: Scaffold(
        backgroundColor: Color(0xF5F5F5F5),
        appBar: AppBar(
          backgroundColor: colorBg.primaryC,
          leading: IconButton(
            onPressed: () => Get.offAllNamed(RouteName.dataLoggerPage),
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          title: Text(
            "Data Tanaman 1",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: _tabelData(),
      ),
    );
  }

  _tabelData() {
    return StreamBuilder<List<Datum>>(
      stream: sensorsController.sensorStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No data available'));
        }

        final data = snapshot.data!;
        final dateFormat = DateFormat('yyyy-MM-dd');
        final timeFormat = DateFormat('HH:mm:ss');

        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: DataTable(
                        columns: [
                          DataColumn(
                              label: Text(
                            'Waktu',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                          DataColumn(
                              label: Text(
                            'Suhu',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                          DataColumn(
                              label: Text(
                            'Kelembapan\nTanah',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                          DataColumn(
                              label: Text(
                            'Keterangan',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                        ],
                        rows: data.map((datum) {
                          return DataRow(cells: [
                            DataCell(
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(dateFormat.format(datum.waktu)),
                                  Text(
                                      timeFormat.format(datum.waktu.toLocal())),
                                ],
                              ),
                            ),
                            DataCell(Text(datum.plant1.suhu.toString())),
                            DataCell(
                                Text(datum.plant1.kelembapanTanah.toString())),
                            DataCell(Text(datum.plant1.keterangan.toString())),
                          ]);
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: colorBg.primaryC,
                    ),
                    onPressed: sensorsController.previousPage,
                    child: Text('Previous'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: colorBg.primaryC,
                    ),
                    onPressed: sensorsController.nextPage,
                    child: Text('Next'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  // Future<void> _saveToExcel(BuildContext context, List<Datum> data) async {
  //   var excel = Excel.createExcel();
  //   Sheet sheetObject = excel['Sheet1'];
  //   final dateFormat = DateFormat('yyyy-MM-dd');
  //   final timeFormat = DateFormat('HH:mm:ss');

  //   sheetObject.appendRow([
  //     TextCellValue('Waktu'),
  //     TextCellValue('Suhu'),
  //     TextCellValue('Kelembapan Tanah'),
  //     TextCellValue('Keterangan'),
  //   ]);

  //   for (var datum in data) {
  //     sheetObject.appendRow([
  //       TextCellValue(
  //           '${dateFormat.format(datum.waktu)} ${timeFormat.format(datum.waktu.toLocal())}'),
  //       TextCellValue(datum.plant1.suhu.toString()),
  //       TextCellValue(datum.plant1.kelembapanTanah.toString()),
  //       TextCellValue(datum.plant1.keterangan.toString()),
  //     ]);
  //   }

  //   String filePath = '/storage/emulated/0/Data_Tanaman_1.xlsx';
  //   File(filePath)
  //     ..createSync(recursive: true)
  //     ..writeAsBytesSync(excel.save()!);
  //   OpenFile.open(filePath);

  //   Get.snackbar('Success', 'Data saved to Excel');
  // }
}
