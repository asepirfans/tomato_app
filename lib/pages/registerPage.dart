// views/register_view.dart
import 'package:animate_do/animate_do.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'package:tomato_smart_farm/controllers/register_controller.dart';
import 'package:tomato_smart_farm/routes/route_name.dart';
import '../tools/color.dart';

class RegisterView extends StatelessWidget {
  final RegisterController _registerController = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Login'),
      // ),
      body: Container(
        width: Get.width,
        decoration: BoxDecoration(
          color: colorBg.primaryC,
        ),
        // decoration: BoxDecoration(
        //     gradient: LinearGradient(begin: Alignment.topCenter, colors: [
        //   colorBg.primaryC,
        //   Color(0xFF708F73),
        //   Color(0xFF80A083),
        // ])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FadeInRight(
                      duration: Duration(milliseconds: 1000),
                      child: Text(
                        "TOMATO\nSMART FARM",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                        ),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  FadeInRight(
                      duration: Duration(milliseconds: 1300),
                      child: Text(
                        "Welcome Back GenZ 👋",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      )),
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Expanded(
              child: FadeInUp(
                duration: Duration(milliseconds: 1000),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(60),
                          topRight: Radius.circular(60))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          FadeInUp(
                            duration: Duration(milliseconds: 1000),
                            child: TextField(
                              cursorColor: colorBg.primaryC,
                              controller: _registerController.emailController,
                              decoration: InputDecoration(
                                labelText: 'Email',
                                labelStyle: TextStyle(
                                  color: colorBg.primaryC,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: colorBg.primaryC, width: 2.0),
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                                contentPadding: EdgeInsets.only(
                                    left: 20.0, top: 20.0, bottom: 20.0),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: colorBg.primaryC, width: 2.0),
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                                suffixIcon: Icon(
                                  Icons.email,
                                  color: colorBg.primaryC,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 24),
                          FadeInUp(
                            duration: Duration(milliseconds: 1000),
                            child: TextField(
                              cursorColor: colorBg.primaryC,
                              controller: _registerController.nameController,
                              decoration: InputDecoration(
                                labelText: 'Username',
                                labelStyle: TextStyle(
                                  color: colorBg.primaryC,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: colorBg.primaryC, width: 2.0),
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                                contentPadding: EdgeInsets.only(
                                    left: 20.0, top: 20.0, bottom: 20.0),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: colorBg.primaryC, width: 2.0),
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                                suffixIcon: Icon(
                                  Icons.person,
                                  color: colorBg.primaryC,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 24),
                          Obx(() => FadeInUp(
                                duration: Duration(milliseconds: 1000),
                                child: Stack(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        controller: _registerController
                                            .passwordController,
                                        decoration: InputDecoration(
                                          labelText: 'Password',
                                          labelStyle: TextStyle(
                                            color: colorBg.primaryC,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: colorBg.primaryC,
                                                width: 2.0),
                                            borderRadius:
                                                BorderRadius.circular(50.0),
                                          ),
                                          contentPadding: EdgeInsets.only(
                                              left: 20.0,
                                              top: 20.0,
                                              bottom: 20.0),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: colorBg.primaryC,
                                                width: 2.0),
                                            borderRadius:
                                                BorderRadius.circular(50.0),
                                          ),
                                        ),
                                        obscureText: !_registerController
                                            .showPassword
                                            .value, // Use value from controller
                                      ),
                                    ),
                                    Positioned(
                                      right: 2,
                                      bottom: 8,
                                      child: IconButton(
                                        onPressed: () {
                                          _registerController
                                              .toggleShowPassword();
                                        },
                                        icon: Icon(
                                          color: colorBg.primaryC,
                                          _registerController.showPassword.value
                                              ? Icons.visibility
                                              : Icons
                                                  .visibility_off, // Use icon based on showPassword value
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                          SizedBox(height: 24),
                          FadeInUp(
                            duration: Duration(milliseconds: 1000),
                            child: MaterialButton(
                              minWidth: Get.width,
                              height: 60,
                              color: colorBg.primaryC,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              onPressed: () {
                                _registerController.registerWithEmail();
                              },
                              child: Text(
                                'Sign Up',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 4,
                            ),
                            child: FadeInRight(
                              duration: Duration(milliseconds: 1000),
                              child: Row(
                                children: [
                                  Text("Do You Have Account?"),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  MaterialButton(
                                    onPressed: () {
                                      Get.offAllNamed(
                                        RouteName.login,
                                      );
                                    },
                                    child: Text(
                                      "Sign In",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: colorBg.primaryC,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
