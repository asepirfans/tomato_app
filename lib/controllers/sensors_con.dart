import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:tomato_smart_farm/models/allSensor.dart';
import 'package:tomato_smart_farm/providers/api.dart';

class SensorsController extends GetxController {
  final ApiController apiController = ApiController();
  final _sensorStreamController = StreamController<List<Datum>>.broadcast();
  Stream<List<Datum>> get sensorStream => _sensorStreamController.stream;

  final int _itemsPerPage = 10;
  var _currentPage = 0.obs;
  var _allData = <Datum>[].obs;

  List<Datum> get allData => _allData.toList();

  @override
  void onInit() {
    super.onInit();
    fetchAllData();
  }

  Future<void> fetchAllData() async {
    try {
      final response = await apiController.fetchAllData();
      print("status: ${response.statusCode}");
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        if (responseData is Map<String, dynamic>) {
          final sensors = Sensor.fromJson(responseData);
          print("datass: ${sensors}");

          // Flatten the data list from all sensors
          _allData.value = sensors.data;

          _updateStream();
        } else {
          throw Exception(
              'Unexpected response format: ${responseData.runtimeType}');
        }
      } else {
        throw Exception(
            'Gagal mengambil data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetchData: $e');
    }
  }

  void _updateStream() {
    final startIndex = _currentPage.value * _itemsPerPage;
    final endIndex = startIndex + _itemsPerPage;
    final pageData = _allData.sublist(
        startIndex, endIndex < _allData.length ? endIndex : _allData.length);
    _sensorStreamController.add(pageData);
  }

  void nextPage() {
    if ((_currentPage.value + 1) * _itemsPerPage < _allData.length) {
      _currentPage.value++;
      _updateStream();
    }
  }

  void previousPage() {
    if (_currentPage.value > 0) {
      _currentPage.value--;
      _updateStream();
    }
  }

  // @override
  // void onClose() {
  //   print("close stream");
  //   _sensorStreamController.close();
  //   super.onClose();
  // }
}
