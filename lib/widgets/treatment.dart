// Buat file baru, misalnya treatment_info.dart
import 'package:flutter/material.dart';

class TreatmentInfoWidget extends StatelessWidget {
  final String label;

  TreatmentInfoWidget({required this.label});

  @override
  Widget build(BuildContext context) {
    return getTreatmentInfo(label);
  }

  Widget getTreatmentInfo(String label) {
    switch (label) {
      case 'Tomato___Bacterial_spot':
        return Text(
          'Pengendalian penyakit bakteri ini melibatkan praktik sanitasi yang baik, seperti membersihkan peralatan tani dan area tanaman, serta memperhatikan rotasi tanaman. Penggunaan fungisida atau antibiotik juga dapat membantu.',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w300,
          ),
          textAlign: TextAlign.justify,
        );
      case 'Tomato___Early_blight':
        return Text(
          'Ini disebabkan oleh jamur dan bisa dikelola dengan menggunakan rotasi tanaman, membuang bagian tanaman yang terinfeksi, penggunaan mulsa, dan aplikasi fungisida jika diperlukan.',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w300,
          ),
          textAlign: TextAlign.justify,
        );
      case 'Tomato___Late_blight':
        return Text(
          'Perlakuan meliputi penggunaan varietas tahan penyakit, praktik sanitasi, rotasi tanaman, dan penggunaan fungisida seperti klorotalonil.',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w300,
          ),
          textAlign: TextAlign.justify,
        );
      case 'Tomato___Leaf_Mold':
        return Text(
          'Pengendalian mencakup menjaga kelembaban rendah di area tanaman, meningkatkan sirkulasi udara, dan menggunakan fungisida jika infeksi parah.',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w300,
          ),
          textAlign: TextAlign.justify,
        );
      case 'Tomato___Septoria_leaf_spot':
        return Text(
          'Praktik pengelolaan meliputi penghapusan daun yang terinfeksi, rotasi tanaman, penyiraman tanaman dari bawah, dan penggunaan fungisida.',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w300,
          ),
          textAlign: TextAlign.justify,
        );
      case 'Tomato___Spider_mites Two-spotted_spider_mite':
        return Text(
          'Pengendalian melibatkan penyemprotan air untuk menghilangkan kutu laba-laba, mempertahankan kelembaban udara yang tinggi, penggunaan predator alami seperti ladybug, dan penggunaan insektisida jika diperlukan.',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w300,
          ),
          textAlign: TextAlign.justify,
        );
      case 'Tomato___Target_Spot':
        return Text(
          'Menghilangkan daun yang terinfeksi, praktik sanitasi, dan penggunaan fungisida jika diperlukan adalah bagian dari pengelolaan penyakit ini.',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w300,
          ),
          textAlign: TextAlign.justify,
        );
      case 'Tomato___Tomato_Yellow_Leaf_Curl_Virus':
        return Text(
          'Tanaman yang terinfeksi harus dihapus dan dimusnahkan untuk mencegah penyebaran virus. Penggunaan varietas tahan penyakit dan kontrol serangga vektor juga penting.',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w300,
          ),
          textAlign: TextAlign.justify,
        );
      case 'Tomato___Tomato_mosaic_virus':
        return Text(
          'Tanaman yang terinfeksi harus dihapus dan dimusnahkan. Pengendalian serangga vektor dan penggunaan varietas yang tahan terhadap virus juga penting.',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w300,
          ),
          textAlign: TextAlign.justify,
        );
      case 'Tomato___healthy':
        return Text(
          'Daun Sehat, Tolong Jaga Tanamanmu!!!',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w300,
          ),
          textAlign: TextAlign.justify,
        );
      // Tambahkan kasus untuk kategori lainnya sesuai kebutuhan
      // ...
      default:
        return Container();
    }
  }
}
