import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class QuizGame extends StatefulWidget {
  final List<String> images;
  final List<String> audios;

  const QuizGame({super.key, required this.images, required this.audios});

  @override
  State<QuizGame> createState() => _QuizGameState();
}

class _QuizGameState extends State<QuizGame> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  int currentQuestionIndex = 0;
  late List<String> options;
  late String correctImage;
  String? selectedAnswer;
  int correctAnswers = 0; // Doğru cevap sayısı
  bool isQuizCompleted = false; // Test tamamlandı mı?

  @override
  void initState() {
    super.initState();
    correctImage = widget.images[currentQuestionIndex];
    options = _generateOptions(currentQuestionIndex);
  }

  List<String> _generateOptions(int index) {
    List<String> tempOptions = [widget.images[index]]; // Doğru resmi başa ekle
    List<String> remainingImages = List.from(widget.images);
    remainingImages.removeAt(index); // Doğru resmi kalan resimlerden çıkar
    remainingImages.shuffle(); // Kalan resimleri karıştır
    tempOptions.addAll(remainingImages.take(3)); // 3 tane yanlış seçenek ekle
    tempOptions.shuffle(); // Seçenekleri karıştır
    return tempOptions;
  }

  void _playAudio(String audio) async {
    await _audioPlayer.stop(); // Önce mevcut sesi durdur
    await _audioPlayer.play(AssetSource('audios/$audio')); // Yeni sesi çal
  }

  void _checkAnswer(String selectedImage) {
    setState(() {
      selectedAnswer = selectedImage; // Seçilen cevabı kaydet
      if (selectedImage == correctImage) {
        correctAnswers++; // Doğru cevap ise sayacı artır
      }
    });
  }

  void _nextQuestion() {
    setState(() {
      currentQuestionIndex = (currentQuestionIndex + 1) %
          widget.images.length; // Sonraki soruya geç
      correctImage =
          widget.images[currentQuestionIndex]; // Yeni doğru resmi ayarla
      options =
          _generateOptions(currentQuestionIndex); // Yeni seçenekleri oluştur
      selectedAnswer = null; // Seçilen cevabı sıfırla

      // Eğer tüm sorular bitmişse, testi tamamlandı olarak işaretle
      if (currentQuestionIndex == 0) {
        isQuizCompleted = true;
        if (correctAnswers == widget.images.length) {
          _showCompletionDialog(); // Tüm sorular doğruysa başarı mesajı göster
        }
      }
    });
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Center(
            child: Icon(
              Icons.check_circle,
              size: 100,
              color: Colors.green,
            ),
          ),
          // Bu buton artık yukarıdaki "Yeşil Tik"i göstermekte ve diğer işlevlere sahip değil.
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final double containerWidth = MediaQuery.of(context).size.width *
        0.5; // Kapsayıcı genişliğini %50 ayarla
    final double containerHeight =
        containerWidth; // Yüksekliği genişlik ile eşit yaparak kare şeklinde tut

    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/arka3.png'), // Arka plan resmi
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 0), // Üst boşluk
            GestureDetector(
              onTap: () => _playAudio(widget
                  .audios[currentQuestionIndex]), // Resme tıklandığında ses çal
              child: Image.asset(
                'assets/images/soundicon5.png', // Ses ikonunun resmi
                width: 700, // Resmin genişliği
                height: 250, // Resmin yüksekliği
              ),
            ),
            const SizedBox(height: 0), // Üst boşluk
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(16.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Her satırda 2 öğe
                  crossAxisSpacing: 15, // Sütunlar arasındaki boşluk
                  mainAxisSpacing: 15, // Satırlar arasındaki boşluk
                ),
                itemCount: options.length,
                itemBuilder: (context, index) {
                  String option = options[index];
                  String optionLabel = String.fromCharCode(
                      65 + index); // A, B, C, D gibi etiketler
                  bool isOptionCorrect = option ==
                      correctImage; // Seçeneğin doğru olup olmadığını kontrol et

                  return Stack(
                    children: [
                      Container(
                        width: containerWidth,
                        height: containerHeight,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: selectedAnswer == option
                              ? (isOptionCorrect
                                  ? Colors.green
                                  : Colors
                                      .red) // Seçilen doğru cevap yeşil, yanlış cevap kırmızı
                              : Color.fromARGB(255, 255, 255, 255),
                          border: Border.all(
                            color: selectedAnswer == option
                                ? (isOptionCorrect
                                    ? Colors.green
                                    : Colors.red) // Kenarlık rengi
                                : Colors.transparent,
                            width: 5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(255, 198, 56, 148)
                                  .withOpacity(0.5),
                              spreadRadius: 6,
                              blurRadius: 5,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: GestureDetector(
                          onTap: () => _checkAnswer(
                              option), // Seçeneğe tıklandığında cevabı kontrol et
                          child: Image.asset(
                              'assets/images/$option'), // Seçenek resmini göster
                        ),
                      ),
                      Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(10),
                              topLeft: Radius.circular(10),
                            ),
                          ),
                          child: Text(
                            optionLabel,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            if (selectedAnswer != null && !isQuizCompleted)
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: ElevatedButton(
                  onPressed: _nextQuestion, // Sonraki soruya geç
                  child: const Text(
                    'Next Question',
                    style: TextStyle(
                      color: Color.fromARGB(255, 198, 36, 142),
                    ),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
