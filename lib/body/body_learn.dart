import 'package:flutter/material.dart';
import 'package:flutter_application_4/learn.dart';

class BodyLearn extends StatelessWidget {
  const BodyLearn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 247, 205, 225),
        title: const Text('Hayvanları Öğren'),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/animallearn.png', // Arka plan resmi
              fit: BoxFit.cover, // Ekranı kaplayacak şekilde ayarla
            ),
          ),
          Center(
            child: Learn(
              imagePaths: [
                'animal1.png',
                'animal2.png',
                'animal3.png',
                'animal4.png',
                'animal5.png',
                'animal6.png',
                'animal7.png',
                'animal8.png',
                'animal9.png',
                'animal10.png',
              ],
              audioPaths: [
                'animal1.MP3',
                'animal2.MP3',
                'animal3.MP3',
                'animal4.MP3',
                'animal5.MP3',
                'animal6.MP3',
                'animal7.MP3',
                'animal8.MP3',
                'animal9.MP3',
                'animal10.MP3',
              ],
            ),
          ),
        ],
      ),
    );
  }
}
