import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'animal/animals.dart';
import 'body/body.dart';
import 'color/colors.dart';
import 'family/family.dart';
import 'food/food.dart';
import 'fruit/fruits.dart';
import 'vegetable/vegetable.dart';
import 'job/jobs.dart';
import 'number/numbers.dart';
import 'weather/weather.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  final List<Map<String, String>> categories = [
    {'name': 'Colors', 'image': 'assets/images/1.png'},
    {'name': 'Numbers', 'image': 'assets/images/2.png'},
    {'name': 'Family', 'image': 'assets/images/3.png'},
    {'name': 'Animals', 'image': 'assets/images/4.png'},
    {'name': 'Fruits', 'image': 'assets/images/5.png'},
    {'name': 'Body', 'image': 'assets/images/6.png'},
    {'name': 'Food', 'image': 'assets/images/7.png'},
    {'name': 'Vegetable', 'image': 'assets/images/8.png'},
    {'name': 'Jobs', 'image': 'assets/images/9.png'},
    {'name': 'Weather', 'image': 'assets/images/10.png'},
  ];

  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double gridItemWidth = screenWidth * 0.3;
    double gridItemHeight = screenHeight * 0.25;
    double imageWidth = gridItemWidth * 0.64;
    double imageHeight = gridItemHeight * 0.45;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'KATEGORİLER',
          style: TextStyle(
            color: Color.fromARGB(255, 35, 74, 172),
            fontSize: screenHeight * 0.04,
          ),
        ),
        centerTitle: true, //başlığın tam ortada durması için
        backgroundColor: Colors.white.withOpacity(0),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: GridView.builder(
          padding: EdgeInsets.only(
              top: screenWidth * 0.20,
              bottom: screenWidth * 0.0,
              left: screenHeight * 0.02,
              right: screenHeight * 0.02),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Her satırda 2 öğe
            crossAxisSpacing: screenWidth * 0.03, // Sütunlar arasındaki boşluk
            mainAxisSpacing: screenHeight * 0.013, // Satırlar arasındaki boşluk
            childAspectRatio: 3 / 2.2, // Çocukların genişlik-yükseklik oranı
          ),
          itemCount: categories.length, // Kategori sayısı
          itemBuilder: (context, index) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(20.0), // Köşeleri yuvarlama
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFF7EA9CE).withOpacity(0.4),
                  border: Border.all(
                    color: Color.fromARGB(255, 35, 74, 172), // Çerçevenin rengi
                    width: 2.0, // Çerçevenin kalınlığı
                  ),
                  borderRadius: BorderRadius.circular(
                      20.0), // Çerçevenin kenarlarını yuvarlama
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context,
                        '/${categories[index]['name']!.toLowerCase()}');
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          margin: EdgeInsets.only(
                            top: screenHeight * 0.0,
                            bottom:
                                screenHeight * 0.0, // Resmin üst ve alt boşluğu
                          ),
                          child: Image.asset(
                            categories[index]['image']!,
                            width: imageWidth, // Resim genişliği
                            height: imageHeight, // Resim yüksekliği
                          ),
                        ),
                      ),
                      SizedBox(
                        height: screenWidth * 0.0,
                      ), // Resim ile metin arasındaki boşluk
                      Text(
                        categories[index]['name'] ?? 'Unknown', // Kategori adı
                        style: TextStyle(
                            color: Color.fromARGB(255, 35, 74, 172),
                            fontSize: screenWidth * 0.042),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
