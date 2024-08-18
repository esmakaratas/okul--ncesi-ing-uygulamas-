import 'package:flutter/material.dart';
import 'numbers_quiz.dart';
import 'numbers_learn.dart'; // FruitsTest sayfasının dosya yolunu ekleyin
import 'numbers_games.dart'; // AnimalsGames sayfasının dosya yolunu ekleyin

class NumbersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(28.0), // AppBar yüksekliğini ayarlayın
        child: AppBar(
          title: Text(
            "Animals",
            style: TextStyle(fontSize: 20),
          ),
          automaticallyImplyLeading: true,
          backgroundColor: const Color.fromARGB(255, 198, 56, 148),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Image.asset(
              'assets/images/animalscreen4.png',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 80.0, horizontal: 40.0),
              child: ListView(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AnimalsLearn()),
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(90.0),
                      child: Container(
                        height: 140.0,
                        margin: EdgeInsets.symmetric(vertical: 25.0),
                        color: Colors.white.withOpacity(0.5),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(
                                'assets/images/kategori2.2.png',
                                height: 130.0,
                              ),
                              SizedBox(width: 10.0),
                              Text('Learn', style: TextStyle(fontSize: 35.0)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                AnimalsGames()), // Burada AnimalsGames ekranını açıyoruz
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(80.0),
                      child: Container(
                        height: 140.0,
                        margin: EdgeInsets.symmetric(vertical: 15.0),
                        color: Colors.white.withOpacity(0.5),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text('Games', style: TextStyle(fontSize: 35.0)),
                              SizedBox(width: 10.0),
                              Image.asset(
                                'assets/images/kategori1.1.png',
                                height: 130.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AnimalsQuiz()),
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(80.0),
                      child: Container(
                        height: 140.0,
                        margin: EdgeInsets.symmetric(vertical: 15.0),
                        color: Colors.white.withOpacity(0.55),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(
                                'assets/images/kategori3.3.png',
                                height: 130.0,
                              ),
                              SizedBox(width: 10.0),
                              Text('Quiz', style: TextStyle(fontSize: 35.0)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
