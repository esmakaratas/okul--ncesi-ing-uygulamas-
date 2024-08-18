import 'package:flutter/material.dart';
import 'package:flutter_application_4/matching_game.dart'; // `MatchingGame` widget'ını import ediyoruz
import '/puzzlegame.dart'; // PuzzleGame widgetını import ediyoruz

class BodyGames extends StatelessWidget {
  const BodyGames({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animals Games'),
        backgroundColor: const Color.fromARGB(255, 247, 205, 225), // Pembe renk
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/arka3.png'), // Arka plan resmi
            fit: BoxFit.cover, // Resmi kapsayacak şekilde ayarla
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // İlk bölüm: MatchingGame ekranı
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MatchingGame(
                        audioFiles: [
                          'animal1.MP3',
                          'animal2.MP3',
                          'animal4.MP3',
                          'animal10.MP3',
                        ],
                        imageFiles: [
                          'animal1.png',
                          'animal2.png',
                          'animal4.png',
                          'animal10.png',
                        ],
                        audioPath: 'assets/audios',
                        imagePath: 'assets/images',
                      ),
                    ),
                  );
                },
                child: Container(
                  color: Colors.transparent, // Arka plan rengini şeffaf yap
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(255, 176, 54, 146)
                                .withOpacity(0.6),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      margin: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'LEVEL 1',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Image.asset(
                            'assets/images/fruitsgame2.png',
                            width: 250,
                            height: 250,
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'EŞLEŞTİRME OYUNU',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 102, 97, 97),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              // İkinci bölüm: PuzzleGame widgetı
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PuzzleGame(
                        images: [
                          'assets/images/animal1.1.png',
                          'assets/images/animal2.2.png',
                          'assets/images/animal3.3.png',
                        ],
                        audio: 'assets/audio/success.mp3',
                      ),
                    ),
                  );
                },
                child: Container(
                  color: Colors.transparent, // Arka plan rengini şeffaf yap
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(255, 178, 43, 135)
                                .withOpacity(0.6),
                            spreadRadius: 6,
                            blurRadius: 8,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      margin: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'LEVEL 2',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Image.asset(
                            'assets/images/fruitsgames1.png', // İkinci ekranın resmi
                            width: 250,
                            height: 250,
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'PUZZLE OYUNU',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 102, 97, 97),
                            ),
                          ),
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
    );
  }
}
