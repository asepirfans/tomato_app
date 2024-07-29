// user_controller.dart
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helper/auth.dart';

class UserController extends GetxController {
  var username = ''.obs;

  Future<bool> checkLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('accessToken');
    if (accessToken != null) {
      String username = prefs.getString('userName') ?? 'Anonymous';
      setUsername(username);
      return true;
    } else {
      return false;
    }
  }

  setUsername(String name) {
    username.value = name;
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('accessToken');
    await prefs.remove('userName');
    setUsername(''); // Clear username value
    await AuthHelper.clearAuthToken();
  }
}
