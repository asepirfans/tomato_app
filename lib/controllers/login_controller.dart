import 'dart:convert';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:cool_alert/cool_alert.dart';
// import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:tomato_smart_farm/providers/api.dart';
import '../routes/route_name.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var showPassword = false.obs;

  final ApiController apiController = ApiController();

  Future<void> loginWithEmail() async {
    try {
      Map<String, dynamic> body = {
        'email': emailController.text,
        'password': passwordController.text,
      };
      final response = await apiController.login(body);
      final jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        if (jsonResponse['success'] == true) {
          final userData = jsonResponse['data'];
          final accessToken = userData['accessToken'];
          final userName = userData['userName'];
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('accessToken', accessToken);
          await prefs.setString('userName', userName);
          print('usename: ${userName}');

          emailController.clear();
          passwordController.clear();
          Get.offAllNamed(RouteName.homePage);

          Get.snackbar(
            'Success',
            jsonResponse['message'],
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
        } else {
          throw (jsonResponse['message'] ?? "Login failed");
        }
      } else {
        throw (jsonResponse['message']);
      }
    } catch (e) {
      Get.back();
      Get.snackbar(
        'Failed',
        e.toString(),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void toggleShowPassword() {
    showPassword.value = !showPassword.value;
  }
}
