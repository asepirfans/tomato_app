// controllers/register_controller.dart
import 'dart:convert';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:tomato_smart_farm/providers/api.dart';
import 'package:tomato_smart_farm/routes/route_name.dart';

class RegisterController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var showPassword = false.obs;

  final ApiController apiController = ApiController();

  Future<void> registerWithEmail() async {
    try {
      Map<String, dynamic> body = {
        'username': nameController.text,
        'email': emailController.text,
        'password': passwordController.text,
      };
      final response = await apiController.register(body);
      final jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        if (jsonResponse['success'] == true) {
          nameController.clear();
          emailController.clear();
          passwordController.clear();
          Get.snackbar(
            'Success',
            jsonResponse['message'],
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
          Get.offAllNamed(RouteName.login);
        } else {
          throw (jsonResponse['message'] ?? "Registration failed");
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
