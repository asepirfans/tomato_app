import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthHelper {
  static String authToken = ''; // Simpan token otentikasi di sini

  // Fungsi untuk mengambil token otentikasi
  static Future<void> fetchAuthToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('accessToken');
    await Future.delayed(Duration(seconds: 2));
    authToken = '$accessToken'; // Token yang diperoleh dari server
  }

  // Fungsi untuk mengirim permintaan HTTP dengan token otentikasi
  static Future<http.Response> authenticatedGet(Uri url) async {
    // Pastikan token otentikasi sudah diperoleh sebelum melakukan permintaan HTTP
    if (authToken.isEmpty) {
      await fetchAuthToken();
    }

    // Sertakan token otentikasi dalam header permintaan
    final headers = {'Authorization': 'Bearer $authToken'};
    return http.get(url, headers: headers);
  }

  static Future<http.Response> authenticatedDelete(Uri url) async {
    // Pastikan token otentikasi sudah diperoleh sebelum melakukan permintaan HTTP
    if (authToken.isEmpty) {
      await fetchAuthToken();
    }

    // Sertakan token otentikasi dalam header permintaan
    final headers = {'Authorization': 'Bearer $authToken'};
    return http.delete(url, headers: headers);
  }
   static Future<http.Response> authenticatedPost(Uri url, Map<String, dynamic> body) async {
    // Pastikan token otentikasi sudah diperoleh sebelum melakukan permintaan HTTP
    if (authToken.isEmpty) {
      await fetchAuthToken();
    }

    // Sertakan token otentikasi dalam header permintaan
    final headers = {'Authorization': 'Bearer $authToken', 'Content-Type': 'application/json'};
    return http.post(url, headers: headers, body: jsonEncode(body));
  }

  static Future<void> clearAuthToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('accessToken');
    authToken = ''; // Hapus token dari AuthHelper
  }
}
