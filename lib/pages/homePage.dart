import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';

// import 'package:giffy_dialog/giffy_dialog.dart';
// import 'package:tomato_apps/routes/route_name.dart';

import '../controllers/user_controller.dart';
import '../controllers/sensor_con.dart';
import '../routes/route_name.dart';
import '../tools/color.dart';

// import 'monitoringPage.dart';

class HomePage extends StatelessWidget {
  final UserController _userController = Get.find();
  final SensorController _sensorControler = Get.find();
  // const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    _userController.checkLoggedIn();
    _sensorControler.statusPlant();
    return Scaffold(
      backgroundColor: Color(0xF5F5F5F5),
      appBar: AppBar(
          backgroundColor: colorBg.primaryC,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey,
                      image: DecorationImage(
                        image: AssetImage('images/ava.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(() => Text(
                              "Hallo, ${_userController.username.value}",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                        Text(
                          "#PetaniGenZ",
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // IconButton(
              //   // alignment: Alignment.centerLeft,
              //   onPressed: () {
              //     _userController.logout();
              //     Get.offAllNamed(RouteName.login);
              //   },
              //   icon: Icon(Icons.logout),
              //   color: Colors.white,
              // ),
            ],
          ),
          actions: [
            PopupMenuButton(
                iconColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                itemBuilder: (context) => [
                      // PopupMenuItem(child: Text('Settings')),
                      // PopupMenuItem(child: Text('Options')),
                      PopupMenuItem(
                        child: Text(
                          'Logout',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onTap: () {
                          _userController.logout();
                          Get.offAllNamed(RouteName.login);
                        },
                      ),
                      // PopupMenuItem(
                      //   child: Text(
                      //     'Kontrol',
                      //     style: TextStyle(
                      //       fontWeight: FontWeight.bold,
                      //     ),
                      //   ),
                      //   onTap: () {
                      //     Get.offAllNamed(RouteName.pumpPage);
                      //   },
                      // ),
                    ])
          ]),
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    decoration: BoxDecoration(
                      color: colorBg.primaryC,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 160,
                      decoration: BoxDecoration(
                        color: Color(0xF5F5F5F5),
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      "Tomato\nSmart Farm",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        height: 1,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      "Tomato Smart Farm, Solusi Cerdas untuk Monitoring Kelembapan, Suhu, dan Deteksi Penyakit Tomat",
                                      style: TextStyle(
                                        fontSize: 10,
                                        wordSpacing: 0.5,
                                      ),
                                      textAlign: TextAlign.justify,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Image.asset(
                              './images/tomato.png',
                              width: 130,
                              // height: 300,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Text(
                  "Informasi",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        List<Widget> images = [
                          Image.network(
                            'https://res.cloudinary.com/drmtgn0li/image/upload/v1713096532/pgeb8rgvvzh1p2dcfc2a.jpg',
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                          Image.network(
                            'https://res.cloudinary.com/drmtgn0li/image/upload/v1713096532/pgeb8rgvvzh1p2dcfc2a.jpg',
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                        ];
                        _showInfoPopup(
                          context,
                          "Kelembapan Tanah",
                          images,
                          "Kelembapan tanah yang ideal bagi pertumbuhan tanaman tomat berkisar antara 60% hingga 80%. Tingkat kelembapan ini memberikan kondisi yang optimal bagi akar tanaman untuk menyerap air dan nutrisi dengan baik. Pastikan untuk memantau kelembapan tanah secara teratur dan menjaga agar tetap dalam kisaran yang diperlukan untuk pertumbuhan tanaman yang sehat dan hasil panen yang melimpah.",
                        );
                      },
                      child: Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 1,
                              offset: Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              './images/soil.png',
                              width: 40,
                            ),
                            Text(
                              "Kelembapan\nTanah",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                              ),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        List<Widget> images = [
                          Image.network(
                            'https://res.cloudinary.com/drmtgn0li/image/upload/v1713096532/pgeb8rgvvzh1p2dcfc2a.jpg',
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                          Image.network(
                            'https://res.cloudinary.com/drmtgn0li/image/upload/v1713096532/pgeb8rgvvzh1p2dcfc2a.jpg',
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                        ];
                        _showInfoPopup(
                          context,
                          "Suhu Udara",
                          images,
                          "Suhu yang ideal bagi pertumbuhan tanaman tomat berkisar antara 24 hingga 30 derajat Celsius. Rentang suhu ini memberikan lingkungan yang optimal bagi tanaman untuk tumbuh dan berkembang dengan baik. Dengan suhu udara yang stabil dalam kisaran ini, tanaman tomat dapat menyerap nutrisi dengan baik, mengoptimalkan proses fotosintesis, dan menghasilkan buah yang berkualitas tinggi.",
                        );
                      },
                      child: Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 1,
                              offset: Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              './images/suhu.png',
                              width: 40,
                            ),
                            Text(
                              "Suhu\nUdara",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        List<Widget> images = [
                          Image.network(
                            'https://res.cloudinary.com/drmtgn0li/image/upload/v1713148696/assets/uwmeqghylk0bl77fsfpb.jpg',
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                          Image.network(
                            'https://res.cloudinary.com/drmtgn0li/image/upload/v1713096532/pgeb8rgvvzh1p2dcfc2a.jpg',
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                          Image.network(
                            'https://res.cloudinary.com/drmtgn0li/image/upload/v1713150373/assets/lbffsfeqjiapnbqbxrdo.jpg',
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                          Image.network(
                            'https://res.cloudinary.com/drmtgn0li/image/upload/v1713148795/assets/r36lpmafqy6akegga6dw.jpg',
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                          Image.network(
                            'https://res.cloudinary.com/drmtgn0li/image/upload/v1713150162/assets/pjmenqcp78b0apono8aj.jpg',
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                          Image.network(
                            'https://res.cloudinary.com/drmtgn0li/image/upload/v1713150274/assets/rr2m5xkp25gw1rhrcnzl.jpg',
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                          Image.network(
                            'https://res.cloudinary.com/drmtgn0li/image/upload/v1713148840/assets/vlv30cswyi26tpogerey.jpg',
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                          Image.network(
                            'https://res.cloudinary.com/drmtgn0li/image/upload/v1713148857/assets/ru6j05c5xa5y2eupkwx7.jpg',
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                          Image.network(
                            'https://res.cloudinary.com/drmtgn0li/image/upload/v1713148827/assets/pthl3z9jroezpts1jtoo.png',
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                        ];
                        _showInfoPopup(
                          context,
                          "Jenis Penyakit",
                          images,
                          "Ada beberapa jenis penyakit daun pada tanaman tomat, diantaranya yaitu:\n1. Bacterial Spot\n2. Early Blight\n3. Late Blight\n4. Leaf Mold\n5. Septoria Leaf Spot\n6. Spider Mites\n7. Target Spot\n8. Tomato Yellow Leaf Curl Virus\n9. Tomato Mosaic Virus",
                        );
                      },
                      child: Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 1,
                              offset: Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              './images/detect.png',
                              width: 40,
                            ),
                            Text(
                              "Penyakit\nTomat",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                              ),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: Text(
                  "Fitur Utama",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16, left: 16, bottom: 30),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 170,
                      width: (Get.width - (2 * 20)) / 2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 1,
                            offset: Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Container(
                                height: 80,
                                decoration: BoxDecoration(
                                  color: Color(0xFFBED3FB),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16),
                                child: Transform.scale(
                                  scale: 1.2,
                                  child: Image.asset('./images/monitoring.png'),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "Monitoring",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              "Memantau tanaman secara real-time",
                              style: TextStyle(
                                fontSize: 10,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.offAllNamed(
                                RouteName.monitoringPage,
                              );
                            },
                            child: Container(
                              width: 70,
                              height: 20,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Color(0xFFBED3FB),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.1),
                                    spreadRadius: 1,
                                    blurRadius: 1,
                                    offset: Offset(0, 1),
                                  ),
                                ],
                              ),
                              child: Text(
                                "Lihat",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Container(
                      height: 170,
                      width: (Get.width - (2 * 20)) / 2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 1,
                            offset: Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Container(
                                height: 80,
                                decoration: BoxDecoration(
                                  color: Color(0xFFFFEA9F),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16),
                                child: Transform.scale(
                                  scale: 1.1,
                                  child: Image.asset('./images/deteksi.png'),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "Deteksi Penyakit",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              "Mendeteksi penyakit tanaman dengan mudah",
                              style: TextStyle(
                                fontSize: 10,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.offAllNamed(
                                RouteName.detectPage,
                              );
                            },
                            child: Container(
                              width: 70,
                              height: 20,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Color(0xFFFFEA9F),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.1),
                                    spreadRadius: 1,
                                    blurRadius: 1,
                                    offset: Offset(0, 1),
                                  ),
                                ],
                              ),
                              child: Text(
                                "Lihat",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
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
        initialActiveIndex: 0,
        onTap: (int i) {
          switch (i) {
            case 0:
              print('click index= 0');
              Get.offAllNamed(
                RouteName.homePage,
              );
              break;
            case 1:
              print('click index= 1');
              Get.offAllNamed(
                RouteName.detectPage,
              );
              break;
            case 2:
              print('click index= 2');
              Get.offAllNamed(
                RouteName.monitoringPage,
              );
              break;
            default:
              break;
          }
        },
      ),
    );
  }

  void _showInfoPopup(
      BuildContext context, String title, List<Widget> images, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          contentPadding:
              EdgeInsets.symmetric(horizontal: 16, vertical: 8), // Atur padding
          content: SingleChildScrollView(
            child: Container(
              width: Get.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CarouselSlider(
                    items: images,
                    options: CarouselOptions(
                      height: 150,
                      aspectRatio: 16 / 9,
                      viewportFraction: 1,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 3),
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    content,
                    // textAlign: TextAlign.justify,
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
