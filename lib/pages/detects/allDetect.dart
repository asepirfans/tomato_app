import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'detectPage.dart';
import '../../routes/route_name.dart';
import '../../helper/auth.dart';
import '../../tools/color.dart';

class AllImagesDisplay extends StatefulWidget {
  @override
  _AllImagesDisplayState createState() => _AllImagesDisplayState();
}

class _AllImagesDisplayState extends State<AllImagesDisplay> {
  late Future<List<Map<String, dynamic>>> _futureImages;
  int _currentPage = 0;
  final int _itemsPerPage = 7;

  @override
  void initState() {
    super.initState();
    _futureImages = fetchAllImages();
  }

  Future<List<Map<String, dynamic>>> fetchAllImages() async {
    final response = await AuthHelper.authenticatedGet(
      Uri.parse('https://be-ta-gwuo7fgaxq-uc.a.run.app/user/detects'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body)['data'];
      return responseData.cast<Map<String, dynamic>>().toList();
    } else {
      final errorMessage = json.decode(response.body)['message'];
      throw (errorMessage);
    }
  }

  List<Map<String, dynamic>> _getCurrentPageData(
      List<Map<String, dynamic>> allImages) {
    final int startIndex = _currentPage * _itemsPerPage;
    int endIndex = startIndex + _itemsPerPage;
    if (endIndex > allImages.length) {
      endIndex = allImages.length;
    }
    return allImages.sublist(startIndex, endIndex);
  }

  Future<void> _deleteImage(String id) async {
    try {
      final response = await AuthHelper.authenticatedDelete(
        Uri.parse('https://be-ta-gwuo7fgaxq-uc.a.run.app/user/detect/$id'),
      );
      if (response.statusCode == 200) {
        // Gambar berhasil dihapus, refresh data
        setState(() {
          _futureImages = fetchAllImages();
        });
        AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          title: 'Terhapus',
          btnOkOnPress: () {
            Get.back();
          },
        )..show();

        // showSnackBar(
        //   SnackBar(content: Text('Image deleted successfully')),
        // );
      } else {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          title: 'Gagal',
          btnOkOnPress: () {
            Get.back();
          },
        )..show();
        // Gagal menghapus gambar
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(content: Text('Failed to delete image')),
        // );
      }
    } catch (error) {
      print('Error deleting image: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting image')),
      );
    }
  }

  void _nextPage() {
    setState(() {
      _currentPage++;
    });
  }

  void _previousPage() {
    setState(() {
      _currentPage--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (!didPop) {
          Get.offAllNamed(
            RouteName.detectPage,
          );
          return;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'History',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Get.offAllNamed(RouteName.detectPage);
            },
            icon: Icon(Icons.arrow_back_rounded),
          ),
        ),
        body: FutureBuilder<List<Map<String, dynamic>>>(
          future: _futureImages,
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
              return Center(child: Text('${snapshot.error}'));
            } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              final List<Map<String, dynamic>> currentPageData =
                  _getCurrentPageData(snapshot.data!);
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: currentPageData.length,
                      itemBuilder: (context, index) {
                        final id = currentPageData[index]['id'];
                        final label = currentPageData[index]['label'];
                        final waktuString = currentPageData[index]['waktu'];
                        final waktu = DateTime.parse(waktuString);
                        final imageData = currentPageData[index]['imageUrl'];

                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadiusDirectional.circular(20),
                              color: colorBg.grayC,
                            ),
                            child: ListTile(
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '$label',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                      Text(
                                        DateFormat(
                                                'EEEE, dd MMMM yyyy HH:mm:ss')
                                            .format(waktu.toLocal()),
                                        style: TextStyle(
                                            fontSize: 10, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      AwesomeDialog(
                                        context: context,
                                        dialogType: DialogType.info,
                                        animType: AnimType.leftSlide,
                                        title: 'Informasi',
                                        desc:
                                            'Apakah anda yakin untuk menghapusnya?',
                                        btnCancelOnPress: () {
                                          Get.back();
                                        },
                                        btnCancelText: "Tidak",
                                        btnOkText: "Iya",
                                        btnOkOnPress: () async {
                                          Get.back();
                                          _deleteImage(id);
                                        },
                                      )..show();
                                    },
                                    icon: Icon(Icons.delete),
                                    color: Colors.red,
                                  ),
                                ],
                              ),
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(imageData),
                                // MemoryImage(
                                //   base64Decode(imageData),
                                // ),
                              ),
                              onTap: () {
                                Get.to(() => ImageDisplay(imageId: '$id'));
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: _currentPage > 0 ? _previousPage : null,
                        icon: Icon(Icons.arrow_back),
                      ),
                      Text('Page ${_currentPage + 1}'),
                      IconButton(
                        onPressed: _currentPage <
                                (snapshot.data!.length / _itemsPerPage).ceil() -
                                    1
                            ? _nextPage
                            : null,
                        icon: Icon(Icons.arrow_forward),
                      ),
                    ],
                  ),
                ],
              );
            } else {
              return Center(child: Text('No images available'));
            }
          },
        ),
      ),
    );
  }
}
