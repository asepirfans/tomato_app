import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';

import '../controllers/detect_controller.dart';
import '../routes/route_name.dart';
import '../widgets/treatment.dart';
import '../tools/color.dart';

class Detect extends StatelessWidget {
  final DetectController detectController = Get.put(DetectController());

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (!didPop) {
          Get.offAllNamed(
            RouteName.homePage,
          );
          return;
        }
      },
      child: Scaffold(
        backgroundColor: Color(0xF5F5F5F5),
        appBar: AppBar(
          backgroundColor: colorBg.primaryC,
          flexibleSpace: SafeArea(
            child: Container(
              child: Center(
                child: Text(
                  "Deteksi",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Container(
                  height: 250,
                  width: Get.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 3,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: detectController.pickImage,
                        child: Container(
                          width: MediaQuery.of(context).size.width - 200,
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 17,
                          ),
                          decoration: BoxDecoration(
                            color: colorBg.primaryC,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text(
                            'Camera',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: detectController.pickGalleryImage,
                        child: Container(
                          width: MediaQuery.of(context).size.width - 200,
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 17,
                          ),
                          decoration: BoxDecoration(
                            color: colorBg.primaryC,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text(
                            'Gallery',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.offAllNamed(RouteName.allImage);
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width - 200,
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 17,
                          ),
                          decoration: BoxDecoration(
                            color: colorBg.primaryC,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text(
                            'History',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: colorBg.primaryC,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Obx(
                      () => detectController.loading.value
                          ? SizedBox.shrink()
                          : Container(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 16, horizontal: 8),
                                child: Column(
                                  children: [
                                    Text(
                                      "Result",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return Dialog(
                                              child: Container(
                                                child: Image.file(
                                                    detectController
                                                        .image.value!,
                                                    fit: BoxFit.contain),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      child: Container(
                                        height: 254,
                                        width: 254,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          child: Image.file(
                                            detectController.image.value!,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Divider(
                                      height: 25,
                                      thickness: 1,
                                      color: Colors.white,
                                    ),
                                    detectController.output != null &&
                                            detectController.output!.isNotEmpty
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Center(
                                                child: Text(
                                                  '${detectController.getLabelDisplayName(detectController.output![0]['label'])}',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              // SizedBox(height: 20),
                                              // Text(
                                              //   'Confidence: ${(detectController.output![0]['confidence'] * 100).toStringAsFixed(2)}%',
                                              //   style: TextStyle(
                                              //     color: Colors.white,
                                              //     fontSize: 16,
                                              //     fontWeight: FontWeight.w300,
                                              //   ),
                                              // ),
                                              SizedBox(height: 10),
                                              Text(
                                                detectController.output![0]
                                                            ['label'] ==
                                                        'Tomato___healthy'
                                                    ? 'Keterangan:'
                                                    : 'Treatment:',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              TreatmentInfoWidget(
                                                  label: detectController
                                                      .output![0]['label']),
                                              SizedBox(height: 20),
                                              ElevatedButton(
                                                onPressed: () {
                                                  if (detectController.output !=
                                                          null &&
                                                      detectController
                                                          .output!.isNotEmpty) {
                                                    _showFormDialog(context);
                                                  }
                                                },
                                                child: Center(
                                                  child: Text(
                                                    'Save Detection Result',
                                                    style: TextStyle(
                                                      color: colorBg.primaryC,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        : Column(
                                            children: [
                                              Text(
                                                'Gambar Tidak Cocok!!!',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Container(
                                                alignment: Alignment.center,
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    detectController
                                                        .pickImage();
                                                  },
                                                  child: Text('Retry'),
                                                ),
                                              ),
                                            ],
                                          ),
                                    Divider(
                                      height: 25,
                                      thickness: 1,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: ConvexAppBar(
          backgroundColor: colorBg.primaryC,
          style: TabStyle.fixedCircle,
          items: [
            TabItem(
              icon: Icons.home,
              title: 'Home',
            ),
            TabItem(
              icon: Icons.camera_alt_outlined,
              title: 'Kamera',
            ),
            TabItem(
              icon: Icons.monitor,
              title: 'Monitoring',
            ),
          ],
          initialActiveIndex: 1,
          onTap: (int i) {
            switch (i) {
              case 0:
                Get.offAllNamed(
                  RouteName.homePage,
                );
                break;
              case 1:
                Get.offAllNamed(
                  RouteName.detectPage,
                );
                break;
              case 2:
                Get.offAllNamed(
                  RouteName.monitoringPage,
                );
                break;
              default:
                break;
            }
          },
        ),
      ),
    );
  }

  void _showFormDialog(BuildContext context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.info,
      animType: AnimType.rightSlide,
      title: 'Informasi',
      desc: 'Apakah anda yakin untuk menyimpannya?',
      btnCancelOnPress: () {
        Get.back();
      },
      btnCancelText: "Tidak",
      btnOkText: "Iya",
      btnOkOnPress: () async {
        Get.back();
        AwesomeDialog(
          context: context,
          dialogBackgroundColor: Colors.transparent,
          dialogType: DialogType.noHeader,
          body: Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: SpinKitFadingCircle(
              color: colorBg.primaryC,
              size: 70.0,
              duration: Duration(milliseconds: 500),
            ),
          ),
        )..show();
        await detectController.saveDetectionResult(
          detectController.image.value!,
          detectController.output,
        );
        AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.rightSlide,
          title: 'Tersimpan',
          btnOkOnPress: () {
            Get.back();
          },
        )..show();
      },
    )..show();
  }
}
