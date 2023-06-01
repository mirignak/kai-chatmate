import 'dart:async';
import 'package:flat/services/text_analysis_service.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class SpeechScreen extends StatefulWidget {
  @override
  _SpeechScreenState createState() => _SpeechScreenState();
}

class _SpeechScreenState extends State<SpeechScreen> {
  stt.SpeechToText _speechToText = stt.SpeechToText();
  String _recognizedText = '';
  bool _isListening = false;

  @override
  void initState() {
    super.initState();
    _speechToText = stt.SpeechToText();
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

      Timer(Duration(seconds: 5), () {
        print('Timeout occurred');
        _stopListening();
      });
      _speechToText.listen(
        onResult: (result) {
          setState(() {
            _recognizedText = result.recognizedWords;
          });
        },
        listenFor: Duration(seconds: 5),
        pauseFor: Duration(seconds: 5),
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
  }
}
