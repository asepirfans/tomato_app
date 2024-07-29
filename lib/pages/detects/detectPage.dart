import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import '../../routes/route_name.dart';

import '../../helper/auth.dart';
import '../../tools/color.dart';

class ImageDisplay extends StatefulWidget {
  final String imageId;

  ImageDisplay({required this.imageId});

  @override
  _ImageDisplayState createState() => _ImageDisplayState();
}

class _ImageDisplayState extends State<ImageDisplay> {
  late Future<Map<String, dynamic>> _futureImage;

  @override
  void initState() {
    super.initState();
    _futureImage = fetchImage();
  }

  Future<Map<String, dynamic>> fetchImage() async {
    final response = await AuthHelper.authenticatedGet(
      Uri.parse(
          'https://be-ta-gwuo7fgaxq-uc.a.run.app/user/detect/${widget.imageId}'),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load image');
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (!didPop) {
          Get.offAllNamed(
            RouteName.allImage,
          );
          return;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Image Display',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: FutureBuilder<Map<String, dynamic>>(
            future: _futureImage,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: SpinKitFadingCircle(
                    color: colorBg.grayC,
                    size: 70.0,
                    duration: Duration(milliseconds: 500),
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData) {
                final label = snapshot.data!['label'];
                final treatment = snapshot.data!['treatment'];
                final imageData = snapshot.data!['imageUrl'];

                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    imageData != null && imageData.isNotEmpty
                        ? GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Dialog(
                                    child: Container(
                                      child: Image.network(imageData,
                                          fit: BoxFit.contain),
                                    ),
                                  );
                                },
                              );
                            },
                            child: Image.network(
                              imageData,
                              width: Get.width,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Text('No image available'),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        '$label',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(label == 'Tomato___healthy'
                          ? 'Keterangan: \n$treatment'
                          : 'Treatment: \n$treatment'),
                    ),
                  ],
                );
              } else {
                return Text('No data available');
              }
            },
          ),
        ),
      ),
    );
  }
}
