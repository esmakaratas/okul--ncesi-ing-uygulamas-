import 'package:flutter/material.dart';
import 'package:flutter_application_4/quiz.dart'; // Quiz widgetini import ediyoruz

class AnimalsQuiz extends StatelessWidget {
  const AnimalsQuiz({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animals Quiz'),
        backgroundColor: const Color(0xFFF7CDE1), // Pembe renk
      ),
      body: Container(
        child: QuizGame(
          images: [
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
          audios: [
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
    );
  }
}
