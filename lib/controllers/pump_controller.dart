import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:get/get.dart';
import '../providers/api.dart';

class PumpController extends GetxController {
  final ApiController apiProvider = ApiController();
  RxMap<String, String> pumpStatus = RxMap<String, String>({
    'pump1': 'OFF',
    'pump2': 'OFF',
    'pump3': 'OFF',
  }).obs();

  String togglePumpStatus(String pump) {
    return pumpStatus[pump] == 'ON' ? 'OFF' : 'ON';
  }

  String getPumpStatus(String pump) {
    return pumpStatus[pump] ?? 'OFF';
  }

  @override
  void onInit() {
    super.onInit();
    fetchInitialPumpStatus();
  }

  Future<void> fetchInitialPumpStatus() async {
    try {
      final http.Response response = await apiProvider.getData();
      final Map<String, dynamic> responseBody = json.decode(response.body);
      print('Response Body: $responseBody');

      // Periksa apakah respons memiliki properti 'data' dan isiannya tidak kosong
      if (responseBody.containsKey('data') && responseBody['data'] != null) {
        Map<String, dynamic> pumpData = responseBody['data'];
        pumpStatus['pump1'] = pumpData['pump1'] ?? 'OFF';
        pumpStatus['pump2'] = pumpData['pump2'] ?? 'OFF';
        pumpStatus['pump3'] = pumpData['pump3'] ?? 'OFF';

        // List<dynamic> pumpDataList = responseBody['data'];

        // if (pumpDataList.isNotEmpty) {
        //   Map<String, dynamic> pumpData = pumpDataList[0];

        //   pumpStatus['pump1'] = pumpData['pump1'] ?? 'OFF';
        //   pumpStatus['pump2'] = pumpData['pump2'] ?? 'OFF';
        //   pumpStatus['pump3'] = pumpData['pump3'] ?? 'OFF';
        // }
      } else {
        // Tangani kasus respons tidak sesuai dengan yang diharapkan
        print('Invalid response format or empty data array.');
        // Atur nilai default OFF untuk semua pompa
        pumpStatus['pump1'] = 'OFF';
        pumpStatus['pump2'] = 'OFF';
        pumpStatus['pump3'] = 'OFF';
      }

      pumpStatus
          .refresh(); // Perbarui tampilan setelah memperbarui status pompa
    } catch (e) {
      // Tangani error
      print('Error fetchInitialPumpStatus: $e');
      // Atur nilai default OFF untuk semua pompa saat terjadi kesalahan
      pumpStatus['pump1'] = 'OFF';
      pumpStatus['pump2'] = 'OFF';
      pumpStatus['pump3'] = 'OFF';
      pumpStatus.refresh(); // Perbarui tampilan setelah terjadi kesalahan
    }
  }

  Future<void> sendPumpCommand(String pump) async {
    try {
      // Toggle status pompa di controller
      pumpStatus[pump] = togglePumpStatus(pump);

      // Kirim data ke server
      final Map<String, dynamic> pumpData = {
        'pump1': pumpStatus['pump1'],
        'pump2': pumpStatus['pump2'],
        'pump3': pumpStatus['pump3'],
      };

      final http.Response response = await apiProvider.postData(pumpData);
      final Map<String, dynamic> responseBody = json.decode(response.body);

      // Perbarui status pompa di controller berdasarkan respons dari server
      if (responseBody.containsKey('pump1')) {
        pumpStatus['pump1'] = responseBody['pump1'];
      }

      if (responseBody.containsKey('pump2')) {
        pumpStatus['pump2'] = responseBody['pump2'];
      }

      if (responseBody.containsKey('pump3')) {
        pumpStatus['pump3'] = responseBody['pump3'];
      }

      pumpStatus
          .refresh(); // Perbarui tampilan setelah memperbarui status pompa
    } catch (e) {
      // Handle error
      print('Error sendPumpCommand: $e');
    }
  }
}
