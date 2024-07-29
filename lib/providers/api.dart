import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ApiController {
  // static const String URL_API1 = "https://d4ts3cxh-5000.asse.devtunnels.ms";
  // static const String URL_API = "https://be-ta.vercel.app";
  static const String URL_API = "https://be-ta-gwuo7fgaxq-uc.a.run.app";

  Future statusPlant() async {
    final SharedPreferences shared = await SharedPreferences.getInstance();
    String? getToken = shared.getString("accessToken");
    Uri url = Uri.parse("$URL_API/kondisiPlant");
    var response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $getToken',
    });
    var data = jsonDecode(response.body) as Map<String, dynamic>;
    bool status = data['status'];
    return status;
  }

  Future<http.Response> fetchData() async {
    final SharedPreferences shared = await SharedPreferences.getInstance();
    String? getToken = shared.getString("accessToken");
    try {
      Uri url = Uri.parse('$URL_API/api/sensors');
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $getToken',
      });
      if (response.statusCode == 200) {
        return response;
      } else {
        throw Exception(
            'Failed to fetch data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during fetchData: $e');
      throw e;
    }
  }

  Future<http.Response> fetchAllData() async {
    final SharedPreferences shared = await SharedPreferences.getInstance();
    String? getToken = shared.getString("accessToken");
    try {
      Uri url = Uri.parse('$URL_API/api/allSensors');
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $getToken',
      });
      if (response.statusCode == 200) {
        return response;
      } else {
        throw Exception(
            'Failed to fetch data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during fetchData: $e');
      throw e;
    }
  }

  Future<http.Response> fetchHighestData() async {
    try {
      final response = await http.get(Uri.parse('$URL_API/api/highestSensor'));
      print('Status Code: ${response.statusCode}');
      // print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        return response;
      } else {
        throw Exception(
            'Failed to fetch data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during fetchData: $e');
      throw e;
    }
  }

  Future<http.Response> postData(Map<String, dynamic> data) async {
    try {
      final response = await http.post(
        Uri.parse('$URL_API/api/pump'), // Ganti URL dengan URL POST yang sesuai
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data),
      );

      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<http.Response> getData() async {
    try {
      final response = await http.get(Uri.parse('$URL_API/api/pump'));
      print('Status Code: ${response.statusCode}');
      // print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        return response;
      } else {
        throw Exception(
            'Failed to fetch data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during fetchData: $e');
      throw e;
    }
  }

  Future<http.Response> register(Map<String, dynamic> data) async {
    try {
      final response = await http.post(Uri.parse('$URL_API/user/register'),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode(data));

      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<http.Response> login(Map<String, dynamic> data) async {
    try {
      final response = await http.post(Uri.parse('$URL_API/user/login'),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode(data));

      return response;
    } catch (e) {
      throw e;
    }
  }
}
