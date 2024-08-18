import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class MatchingGame extends StatefulWidget {
  final List<String> audioFiles;
  final List<String> imageFiles;
  final String audioPath;
  final String imagePath;

  const MatchingGame({
    Key? key,
    required this.audioFiles,
    required this.imageFiles,
    required this.audioPath,
    required this.imagePath,
  }) : super(key: key);

  @override
  _MatchingGameState createState() => _MatchingGameState();
}

class _MatchingGameState extends State<MatchingGame> {
  late List<String> audioFiles;
  late List<String> imageFiles;
  late String audioPath;
  late String imagePath;

  final Map<String, bool> matchedPairs = {};
  final Set<String> pendingPairs = {};
  String? selectedAudio;
  String? wrongImage;
  String? wrongAudio;
  late AudioPlayer player;

  @override
  void initState() {
    super.initState();
    audioFiles = widget.audioFiles;
    imageFiles = widget.imageFiles;
    audioPath = widget.audioPath;
    imagePath = widget.imagePath;
    audioFiles.shuffle();
    imageFiles.shuffle();
    player = AudioPlayer();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Matching Game'),
        backgroundColor: Color.fromARGB(255, 247, 205, 225),
      ),
      backgroundColor: Color.fromARGB(255, 247, 205, 225),
      body: _buildGameContent(),
    );
  }

  Widget _buildGameContent() {
    if (matchedPairs.length == audioFiles.length) {
      return const Center(
        child: Icon(
          Icons.check_circle,
          color: Colors.green,
          size: 150,
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: _buildList(audioFiles, _buildAudioItem),
        ),
        Expanded(
          child: _buildList(imageFiles, _buildImageItem),
        ),
      ],
    );
  }

  Widget _buildList(
      List<String> items, Widget Function(String item) itemBuilder) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: items
          .where((item) => !matchedPairs.containsKey(item.split('.').first))
          .map((item) => itemBuilder(item))
          .toList(),
    );
  }

  Widget _buildAudioItem(String audio) {
    String fruitName = audio.split('.').first; // fruitsX.mp3 -> fruitsX
    return GestureDetector(
      onTap: () async {
        setState(() {
          selectedAudio = fruitName;
          wrongAudio = null;
          wrongImage = null;
        });
        _playAudio(audio);
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: _getBorderColor(fruitName, true),
            width: 3,
          ),
          color: Color.fromARGB(255, 124, 185, 234),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 10,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        width: 150,
        height: 150,
        child: Center(
          child: Icon(
            Icons.volume_up,
            color: Colors.black,
            size: 50,
          ),
        ),
      ),
    );
  }

  void _playAudio(String audio) async {
    try {
      await player.stop(); // Önce mevcut sesi durdur
      await player.play(AssetSource('audios/$audio')); // Yeni sesi çal
    } catch (e) {
      print('Error playing audio: $e');
    }
  }

  Widget _buildImageItem(String image) {
    String fruitName = image.split('.').first; // fruitsX.png -> fruitsX
    return GestureDetector(
      onTap: () {
        if (selectedAudio != null) {
          if (selectedAudio == fruitName) {
            setState(() {
              pendingPairs.add(fruitName);
              wrongImage = null;
              wrongAudio = null;
            });
            Future.delayed(const Duration(seconds: 1), () {
              setState(() {
                matchedPairs[fruitName] = true;
                pendingPairs.remove(fruitName);
                selectedAudio = null;
              });
            });
          } else {
            setState(() {
              wrongImage = fruitName;
              wrongAudio = selectedAudio;
              selectedAudio = null;
            });
            Future.delayed(const Duration(seconds: 1), () {
              setState(() {
                wrongImage = null;
                wrongAudio = null;
              });
            });
          }
        }
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: _getBorderColor(fruitName, false),
            width: 3,
          ),
          color: Color.fromARGB(255, 226, 226, 226),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 10,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        width: 150, // Resim genişliği artırıldı
        height: 150, // Resim yüksekliği artırıldı
        child: matchedPairs.containsKey(fruitName) && matchedPairs[fruitName]!
            ? const SizedBox()
            : Image.asset(
                '$imagePath/$image',
                width: 150, // Resim genişliği artırıldı
                height: 150, // Resim yüksekliği artırıldı
              ),
      ),
    );
  }

  Color _getBorderColor(String fruitName, bool isAudio) {
    if (pendingPairs.contains(fruitName)) {
      return Colors.green;
    } else if (matchedPairs.containsKey(fruitName) &&
        matchedPairs[fruitName]!) {
      return Colors.transparent;
    } else if ((isAudio && wrongAudio == fruitName) ||
        (!isAudio && wrongImage == fruitName)) {
      return Colors.red;
    } else {
      return Color.fromARGB(255, 20, 103, 171);
    }
  }
}
