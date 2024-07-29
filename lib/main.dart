import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tomato_smart_farm/controllers/user_controller.dart';
import 'package:tomato_smart_farm/pages/loginPage.dart';
// import 'package:tomato_farm/pages/registerPage.dart';
import './pages/homePage.dart';
import './routes/page_route.dart';
import './controllers/sensor_con.dart';
import './controllers/pump_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? accessToken = prefs.getString('accessToken');
  Get.put(SensorController());
  Get.put(PumpController());
  Get.put(UserController());
  runApp(MyApp(accessToken: accessToken));
}

class MyApp extends StatelessWidget {
  final String? accessToken;
  MyApp({this.accessToken});
  @override
  Widget build(BuildContext context) {
  print('accessToken: ${accessToken}' );
    return GetMaterialApp(
      theme: ThemeData(
        fontFamily: 'Poppins',
      ),
      defaultTransition: Transition.native, // Use native transition
      opaqueRoute: false, // Make routes not opaque
      debugShowCheckedModeBanner: false,
      home: accessToken != null ? HomePage() : LoginPage(),
      getPages: AppPage.pages,
    );
  }
}
