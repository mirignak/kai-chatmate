import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flat/widgets/speech_input_widget.dart';
import 'package:flat/widgets/text_input_widget.dart';

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
        title: Text('Speech Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_recognizedText),
            // TextInputWidget(),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _startListening,
              child: Text('Start Listening'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _stopListening,
              child: Text('Stop Listening'),
            ),
            SpeechInputWidget(),
          ],
        ),
      ),
    );
  }

  void _startListening() async {
    bool available = await _speechToText.initialize(
      onError: (error) => print('Error: $error'),
    );
    if (available) {
      setState(() {
        _isListening = true;
      });

      _speechToText.listen(
        onResult: (result) {
          setState(() {
            _recognizedText = result.recognizedWords;
          });
        },
      );
    }
  }

  void _stopListening() {
    _speechToText.stop();
    setState(() {
      _isListening = false;
    });
  }
}
