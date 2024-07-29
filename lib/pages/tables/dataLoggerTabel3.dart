import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tomato_smart_farm/controllers/sensors_con.dart';
import 'package:tomato_smart_farm/models/allSensor.dart';
import '../../routes/route_name.dart';
import 'package:intl/intl.dart';
import '../../tools/color.dart';

class DataLoggerTabel3 extends StatelessWidget {
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
            "Data Tanaman 3",
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
                            DataCell(Text(datum.plant3.suhu.toString())),
                            DataCell(
                                Text(datum.plant3.kelembapanTanah.toString())),
                            DataCell(Text(datum.plant3.keterangan.toString())),
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

                      // Text color
                    ),
                    onPressed: sensorsController.previousPage,
                    child: Text('Previous'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: colorBg.primaryC
                        // Text color
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
}
