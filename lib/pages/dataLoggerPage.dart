import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes/route_name.dart';
import 'package:tomato_smart_farm/controllers/sensors_con.dart';
import 'package:tomato_smart_farm/models/allSensor.dart';
import 'package:intl/intl.dart';
import 'package:excel/excel.dart';
import 'dart:io';
import 'package:open_file/open_file.dart';
import '../tools/color.dart';

class DataLoggerPage extends StatelessWidget {
  final SensorsController sensorsController = Get.put(SensorsController());

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (!didPop) {
          Get.offAllNamed(RouteName.monitoringPage);
        }
      },
      child: Scaffold(
        backgroundColor: Color(0xF5F5F5F5),
        appBar: AppBar(
          backgroundColor: colorBg.primaryC,
          leading: IconButton(
            onPressed: () => Get.offAllNamed(RouteName.monitoringPage),
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          title: Text(
            "Data Logger",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: StreamBuilder<List<Datum>>(
            stream: sensorsController.sensorStream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No data available'));
              }

              // final data = snapshot.data!;
              // final dateFormat = DateFormat('yyyy-MM-dd');
              // final timeFormat = DateFormat('HH:mm:ss');
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  height: 300,
                  width: Get.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 3,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () =>
                            Get.offAllNamed(RouteName.dataLoggerTabel1),
                        child: Container(
                          width: MediaQuery.of(context).size.width - 200,
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 17,
                          ),
                          decoration: BoxDecoration(
                            color: colorBg.primaryC,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text(
                            'Tanaman 1',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () =>
                            Get.offAllNamed(RouteName.dataLoggerTabel2),
                        child: Container(
                          width: MediaQuery.of(context).size.width - 200,
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 17,
                          ),
                          decoration: BoxDecoration(
                            color: colorBg.primaryC,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text(
                            'Tanaman 2',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () =>
                            Get.offAllNamed(RouteName.dataLoggerTabel3),
                        child: Container(
                          width: MediaQuery.of(context).size.width - 200,
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 17,
                          ),
                          decoration: BoxDecoration(
                            color: colorBg.primaryC,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text(
                            'Tanaman 3',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () =>
                            _saveToExcel(context, sensorsController.allData),
                        child: Container(
                          width: MediaQuery.of(context).size.width - 200,
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 17,
                          ),
                          decoration: BoxDecoration(
                            color: colorBg.primaryC,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text(
                            'Export Excel',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }

  Future<void> _saveToExcel(BuildContext context, List<Datum> data) async {
    var excel = Excel.createExcel();
    Sheet sheet1 = excel['Tanaman 1'];
    Sheet sheet2 = excel['Tanaman 2'];
    Sheet sheet3 = excel['Tanaman 3'];

    List<TextCellValue> headers = [
      TextCellValue('Tanggal'),
      TextCellValue('Waktu'),
      TextCellValue('Suhu'),
      TextCellValue('Kelembapan Tanah'),
      TextCellValue('Keterangan')
    ];

    sheet1.appendRow(headers);
    sheet2.appendRow(headers);
    sheet3.appendRow(headers);
    List<TextCellValue> _createRow(Plant plant, DateTime waktu) {
      return [
        TextCellValue(DateFormat('dd MMMM yyyy').format(waktu.toLocal())),
        TextCellValue(DateFormat('HH:mm:ss').format(waktu.toLocal())),
        TextCellValue(plant.suhu.toString()),
        TextCellValue(plant.kelembapanTanah.toString()),
        TextCellValue(plant.keterangan ?? '')
      ];
    }

    for (var datum in data) {
      sheet1.appendRow(_createRow(datum.plant1, datum.waktu));
      sheet2.appendRow(_createRow(datum.plant2, datum.waktu));
      sheet3.appendRow(_createRow(datum.plant3, datum.waktu));
    }

    String filePath = '/storage/emulated/0/Data_History_Tanaman.xlsx';
    File(filePath)
      ..createSync(recursive: true)
      ..writeAsBytesSync(excel.save()!);
    OpenFile.open(filePath);

    Get.snackbar('Success', 'Data saved to Excel');
  }
}
