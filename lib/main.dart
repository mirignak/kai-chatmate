import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _generatedText = "";

  Future<void> generateText() async {
    String prompt = "The quick brown fox jumps over the lazy dog";
    String model = "text-davinci-002";
    String apiKey = "<YOUR_API_KEY>";

    var response = await http.post(
      Uri.parse('https://api.openai.com/v1/engines/$model/completions'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode({
        'prompt': prompt,
        'max_tokens': 100,
        'temperature': 0.5,
        'n': 1,
        'stop': '.'
      }),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      setState(() {
        _generatedText = data['choices'][0]['text'];
      });
    } else {
      setState(() {
        _generatedText = "Error: ${response.reasonPhrase}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('GPT-3 Text Generation'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: generateText,
                child: Text('Generate Text'),
              ),
              SizedBox(height: 20),
              Text(_generatedText),
            ],
          ),
        ),
      ),
    );
  }
}
