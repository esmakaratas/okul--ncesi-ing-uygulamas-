import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class Learn extends StatefulWidget {
  final List<String> imagePaths;
  final List<String> audioPaths;

  const Learn({required this.imagePaths, required this.audioPaths, Key? key})
      : super(key: key);

  @override
  State<Learn> createState() => _LearnState();
}

class _LearnState extends State<Learn> {
  int currentIndex = 0;
  late final AudioPlayer audioPlayer;

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  void playAudio(String audioPath) async {
    try {
      await audioPlayer.stop(); // Çalmaya başlamadan önce var olan sesi durdur
      await audioPlayer.play(AssetSource(audioPath)); // Yeni sesi çal
    } catch (e) {
      print('Error playing audio: $e');
    }
  }

  void nextImage() {
    setState(() {
      currentIndex = (currentIndex + 1) % widget.imagePaths.length;
    });
  }

  void previousImage() {
    setState(() {
      currentIndex = (currentIndex - 1 + widget.imagePaths.length) %
          widget.imagePaths.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    double iconSize = 50 * 0.4; // Simge boyutunu yüzde 70 küçültüyoruz

    return SingleChildScrollView(
      child: Column(
        children: [
          // Resmin boyutunu küçültmek için BoxFit.contain kullandık
          Image.asset(
            'assets/images/${widget.imagePaths[currentIndex]}',
            width: 270, // Resim genişliği
            height: 270, // Resim yüksekliği
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: previousImage,
                icon: Image.asset(
                    'assets/images/geri1.png'), // Geri tuşu için sol.png
                iconSize:
                    iconSize, // Simge boyutunu yüzde 70 olarak ayarlıyoruz
              ),
              IconButton(
                onPressed: () =>
                    playAudio('audios/${widget.audioPaths[currentIndex]}'),
                icon: Image.asset(
                    'assets/images/oynat2.png'), // Oynat butonu için oynat.png
                iconSize:
                    iconSize, // Simge boyutunu yüzde 70 olarak ayarlıyoruz
              ),
              IconButton(
                onPressed: nextImage,
                icon: Image.asset(
                    'assets/images/ileri1.png'), // İleri tuşu için sag.png
                iconSize:
                    iconSize, // Simge boyutunu yüzde 70 olarak ayarlıyoruz
              ),
            ],
          ),
        ],
      ),
    );
  }
}
