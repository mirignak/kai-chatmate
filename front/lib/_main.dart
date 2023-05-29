import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'dart:convert';

void main() {
  runApp(ChatApp());
}

class ChatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Study English with ChatGPT',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController _textEditingController = TextEditingController();
  stt.SpeechToText _speechToText = stt.SpeechToText();
  String _spokenText = '';

  @override
  void initState() {
    super.initState();
    _initializeSpeechToText();
  }

  void _initializeSpeechToText() async {
    bool isAvailable = await _speechToText.initialize();
    if (isAvailable) {
      _speechToText.errorListener =
          (error) => print('Speech recognition error: $error');
    } else {
      print('Speech recognition not available');
    }
  }

  void _startListening() async {
    bool isListening = await _speechToText.listen(
      onResult: (result) {
        setState(() {
          _spokenText = result.recognizedWords;
        });
      },
    );
    if (isListening) {
      print('Speech recognition started');
    } else {
      print('Speech recognition failed to start');
    }
  }

  void _stopListening() {
    _speechToText.stop();
    print('Speech recognition stopped');
  }

  void _clearText() {
    setState(() {
      _textEditingController.clear();
    });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Study English with ChatGPT'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _textEditingController,
                decoration: InputDecoration(
                  hintText: 'Enter text...',
                ),
              ),
              SizedBox(height: 16.0),
              Text('Spoken Text: $_spokenText'),
            ],
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _startListening,
            child: Icon(Icons.mic),
          ),
          SizedBox(width: 16.0),
          FloatingActionButton(
            onPressed: _stopListening,
            child: Icon(Icons.stop),
          ),
          SizedBox(width: 16.0),
          FloatingActionButton(
            onPressed: _clearText,
            child: Icon(Icons.clear),
          ),
        ],
      ),
    );
  }
  // void _sendMessage(String text) async {
  //   setState(() {
  //     _messages.add(ChatMessage(text: text, isUserMessage: true));
  //   });

  // final response = await http.post(
  //   Uri.parse('https://api.openai.com/v1/chat/completions'),
  //   headers: {
  //     'Content-Type': 'application/json',
  //     'Authorization': 'Bearer YOUR_API_KEY',
  //   },
  //   body: jsonEncode({
  //     'messages': [
  //       {'role': 'system', 'content': 'You are a helpful assistant.'},
  //       {'role': 'user', 'content': text},
  //     ],
  //   }),
  // );

  // if (response.statusCode == 200) {
  //   final jsonResponse = jsonDecode(response.body);
  //   final completions = jsonResponse['choices'][0]['message']['content'];
  //   setState(() {
  //     _messages.add(ChatMessage(text: completions, isUserMessage: false));
  //   });
  // }
}

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('ChatGPT English Study App'),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               itemCount: _messages.length,
//               itemBuilder: (context, index) {
//                 final message = _messages[index];
//                 return ListTile(
//                   title: Text(
//                     message.text,
//                     textAlign: message.isUserMessage
//                         ? TextAlign.right
//                         : TextAlign.left,
//                   ),
//                 );
//               },
//             ),
//           ),
//           Container(
//             padding: EdgeInsets.symmetric(horizontal: 8.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: _inputController,
//                     decoration: InputDecoration(hintText: 'Enter your message'),
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.send),
//                   onPressed: () {
//                     final text = _inputController.text.trim();
//                     if (text.isNotEmpty) {
//                       _sendMessage(text);
//                       _inputController.clear();
//                     }
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class ChatMessage {
  final String text;
  final bool isUserMessage;

  ChatMessage({required this.text, required this.isUserMessage});
}
