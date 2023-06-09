import 'dart:async';
import 'package:flat/services/text_analysis_service.dart';
import 'package:flat/services/query_to_openai_service.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flat/api/api_services.dart';

class SpeechScreen extends StatefulWidget {
  @override
  _SpeechScreenState createState() => _SpeechScreenState();
}

class _SpeechScreenState extends State<SpeechScreen> {
  stt.SpeechToText _speechToText = stt.SpeechToText();
  String _recognizedText = '';
  String topicId = 'orderCoffee';
  bool _isListening = false;

  @override
  void initState() {
    super.initState();
    _speechToText = stt.SpeechToText();
  }

  // bool _hasSpeech = false;
  // bool _logEvents = false;
  // bool _onDevice = false;
  // final TextEditingController _pauseForController =
  //     TextEditingController(text: '3');
  // final TextEditingController _listenForController =
  //     TextEditingController(text: '30');
  // double level = 0.0;
  // double minSoundLevel = 50000;
  // double maxSoundLevel = -50000;
  // String lastWords = '';
  // String lastError = '';
  // String lastStatus = '';
  // String _currentLocaleId = '';
  // List<LocaleName> _localeNames = [];
  // final SpeechToText speech = SpeechToText();

  // Future<void> initSpeechState() async {
  //     _logEvent('Initialize');
  //     try {
  //       var hasSpeech = await speech.initialize(
  //         onError: errorListener,
  //         onStatus: statusListener,
  //         debugLogging: _logEvents,
  //       );
  //       if (hasSpeech) {
  //         // Get the list of languages installed on the supporting platform so they
  //         // can be displayed in the UI for selection by the user.
  //         _localeNames = await speech.locales();

  //         var systemLocale = await speech.systemLocale();
  //         _currentLocaleId = systemLocale?.localeId ?? '';
  //       }
  //       if (!mounted) return;

  //       setState(() {
  //         _hasSpeech = hasSpeech;
  //       });
  //     } catch (e) {
  //       setState(() {
  //         lastError = 'Speech recognition failed: ${e.toString()}';
  //         _hasSpeech = false;
  //       });
  //     }
  //   }
  String getTopic() {
    return '주제 : 카페에서 커피 주문하기';
  }

  void handleClickButton() async {
    String text = 'Your text to analyze';
    String analysisResult = await TextAnalysisService.analysis(text);
    print(analysisResult);
    // 분석 결과를 다른 작업에 활용하거나 UI에 표시하는 등의 동작을 수행
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Speech'),
        ),
        body: Stack(
          children: [
            Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(getTopic()),
                    SizedBox(height: 40),
                    Text(_recognizedText),
                    SizedBox(height: 16),
                    FloatingActionButton(
                      onPressed: _startListening,
                      child: Icon(Icons.mic),
                    ),
                    SizedBox(height: 16),
                    FloatingActionButton(
                      //ElevatedButton
                      onPressed: _stopListening,
                      child: Icon(Icons.stop),
                    ),
                    // SpeechInputWidget(),
                    ElevatedButton(
                      onPressed: handleClickButton,
                      child: Text('ask'),
                    ),
                  ],
                )),
            Positioned(top: 16, right: 16, child: _buildListeningStatus())
          ],
        ));
  }

  Widget _buildListeningStatus() {
    Color backgroundColor = _isListening ? Colors.green : Colors.red;
    String statusText = _isListening ? 'Listening...' : 'Not Listening';

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: backgroundColor,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 8),
        Text(
          statusText,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  void _startListening() async {
    bool available = await _speechToText.initialize(
      onError: (error) => print('Error: $error'),
    );

    if (available) {
      setState(() {
        _isListening = true;
        _recognizedText = '';
      });

      // Timer(Duration(seconds: 5), () {
      //   print('Timeout occurred');
      //   _stopListening();
      // });
      _speechToText.listen(
        onResult: (result) {
          setState(() {
            _recognizedText = result.recognizedWords;
          });
        },
        listenFor: Duration(seconds: 60),
        pauseFor: Duration(seconds: 10),
      );
    }
  }

  void _stopListening() {
    _speechToText.stop();
    print('stop');
    setState(() {
      _isListening = false;
    });
    TextAnalysisService.analysis(_recognizedText);
    QueryToOpenAIService.sendQuery(topicId, _recognizedText);
  }
}
