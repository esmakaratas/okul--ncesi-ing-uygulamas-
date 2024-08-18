import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;
import 'dart:async';

class PuzzleGame extends StatefulWidget {
  final List<String> images;
  final String audio;

  const PuzzleGame({super.key, required this.images, required this.audio});

  @override
  State<PuzzleGame> createState() => _PuzzleGameState();
}

class _PuzzleGameState extends State<PuzzleGame> {
  List<ui.Image?> pieces = List<ui.Image?>.filled(9, null);
  List<ui.Image> pieceImages = [];
  List<ui.Image> correctOrder = [];
  final AudioPlayer _audioPlayer = AudioPlayer();
  ui.Image? fullImage;
  int currentImageIndex = 0;
  OverlayEntry? feedbackOverlay;

  @override
  void initState() {
    super.initState();
    _loadAndSplitImage(widget.images[currentImageIndex]).then((images) {
      setState(() {
        pieceImages = images;
        correctOrder = List.from(images);
        pieceImages.shuffle(Random());
      });
    });
  }

  Future<void> _loadNextImage() async {
    currentImageIndex = (currentImageIndex + 1) % widget.images.length;
    final ui.Image image =
        await _loadAssetImage(widget.images[currentImageIndex]);
    final List<ui.Image> pieces = await _splitImage(image);
    setState(() {
      pieceImages = pieces;
      correctOrder = List.from(pieces);
      pieceImages.shuffle(Random());
      this.pieces = List<ui.Image?>.filled(9, null);
      fullImage = image;
    });
  }

  Future<List<ui.Image>> _loadAndSplitImage(String asset) async {
    final ui.Image image = await _loadAssetImage(asset);
    fullImage = image;
    return _splitImage(image);
  }

  Future<List<ui.Image>> _splitImage(ui.Image image) async {
    // Resmi 9 parçaya böler
    final List<ui.Image> pieces = [];
    final int pieceWidth = (image.width / 3).round();
    final int pieceHeight = (image.height / 3).round();

    for (int row = 0; row < 3; row++) {
      for (int col = 0; col < 3; col++) {
        final ui.PictureRecorder recorder = ui.PictureRecorder();
        final Canvas canvas = Canvas(recorder);
        final Rect srcRect = Rect.fromLTWH(
          col * pieceWidth.toDouble(),
          row * pieceHeight.toDouble(),
          pieceWidth.toDouble(),
          pieceHeight.toDouble(),
        );
        final Rect dstRect =
            Rect.fromLTWH(0, 0, pieceWidth.toDouble(), pieceHeight.toDouble());
        canvas.drawImageRect(image, srcRect, dstRect, Paint());
        final ui.Image pieceImage =
            await recorder.endRecording().toImage(pieceWidth, pieceHeight);
        pieces.add(pieceImage);
      }
    }
    return pieces;
  }

  Future<ui.Image> _loadAssetImage(String asset) async {
    final ByteData data = await rootBundle.load(asset);
    final Completer<ui.Image> completer = Completer();
    ui.decodeImageFromList(Uint8List.view(data.buffer), (ui.Image img) {
      completer.complete(img);
    });
    return completer.future;
  }

  bool _isPuzzleCompleted() {
    // Puzzle'ın tamamlandığını kontrol eder
    for (int i = 0; i < pieces.length; i++) {
      if (pieces[i] != correctOrder[i]) {
        return false;
      }
    }
    return true;
  }

  void _showFeedback(bool isCorrect) {
    if (feedbackOverlay != null) {
      feedbackOverlay!.remove();
      feedbackOverlay = null;
    }

    feedbackOverlay = OverlayEntry(
      builder: (context) {
        return Center(
          child: Icon(
            isCorrect ? Icons.check_circle : Icons.cancel,
            color: isCorrect ? Colors.green : Colors.red,
            size: 180,
          ),
        );
      },
    );

    Overlay.of(context)?.insert(feedbackOverlay!);

    Future.delayed(const Duration(seconds: 1), () {
      feedbackOverlay?.remove();
      feedbackOverlay = null;
    });
  }

  void _checkPuzzleCompletion() {
    if (_isPuzzleCompleted()) {
      _audioPlayer.play(DeviceFileSource(
          widget.audio)); // AudioFileSource yerine DeviceFileSource kullanımı
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(widget.images[currentImageIndex]),
                const SizedBox(height: 20),
                const Text(
                  'Correct!',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _loadNextImage();
                },
                child: const Text('Next'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Oyun ekranının tasarımını yapar
    return Scaffold(
      appBar: AppBar(
        title: const Text('Puzzle Oyunu'),
        backgroundColor: const Color.fromARGB(255, 247, 205, 225), // Pembe renk
      ),
      body: Container(
        color: const Color.fromARGB(
            255, 247, 205, 225), // Tek renkli pembe arka plan
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: fullImage != null
                    ? RawImage(image: fullImage, width: 100, height: 100)
                    : Container(),
              ),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 2,
                ),
                itemCount: pieces.length,
                itemBuilder: (context, index) {
                  return DragTarget<ui.Image>(
                    onAccept: (data) {
                      setState(() {
                        if (data == correctOrder[index]) {
                          pieces[index] = data;
                          _showFeedback(true);
                        } else {
                          _showFeedback(false);
                        }
                        _checkPuzzleCompletion();
                      });
                    },
                    builder: (context, candidateData, rejectedData) {
                      return Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: candidateData.isEmpty
                                ? Colors.black
                                : Colors.red,
                            width: 2,
                          ),
                          color: Colors.white.withOpacity(0.6),
                        ),
                        child: Center(
                          child: pieces[index] != null
                              ? RawImage(image: pieces[index])
                              : Container(),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            Container(
              height: 150,
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(5, (index) {
                      if (index >= pieceImages.length) return Container();
                      return Draggable<ui.Image>(
                        data: pieceImages[index],
                        child: pieces.contains(pieceImages[index])
                            ? Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  color: Colors.grey,
                                ),
                              )
                            : Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                ),
                                child: RawImage(
                                  image: pieceImages[index],
                                  width: 50,
                                  height: 50,
                                ),
                              ),
                        feedback: RawImage(
                          image: pieceImages[index],
                          width: 50,
                          height: 50,
                        ),
                        childWhenDragging: Container(
                          width: 50,
                          height: 50,
                          color: Colors.grey,
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(4, (index) {
                      if (5 + index >= pieceImages.length) return Container();
                      return Draggable<ui.Image>(
                        data: pieceImages[5 + index],
                        child: pieces.contains(pieceImages[5 + index])
                            ? Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  color: Colors.grey,
                                ),
                              )
                            : Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                ),
                                child: RawImage(
                                  image: pieceImages[5 + index],
                                  width: 50,
                                  height: 50,
                                ),
                              ),
                        feedback: RawImage(
                          image: pieceImages[5 + index],
                          width: 50,
                          height: 50,
                        ),
                        childWhenDragging: Container(
                          width: 50,
                          height: 50,
                          color: Colors.grey,
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
