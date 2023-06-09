import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class APIService {
  static Future<String> sendQueryToChatGPT(String prompt) async {
    const model = 'text-davinci-002';
    const apiUrl = 'https://api.openai.com/v1/engines/$model/completions';
    const headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'Bearer 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',
    };
    var data = {
      'prompt': prompt,
      'temperature': 0.5,
      'max_tokens': 50,
      'top_p': 1,
      'frequency_penalty': 0,
      'presence_penalty': 0
    };

    final response = await http.post(Uri.parse(apiUrl),
        headers: headers, body: jsonEncode(data));

    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      var completion = result['choices'][0]['text'];
      print(completion);
      return completion;
    } else {
      throw Exception(
          'Failed to send query to ChatGPT: ${response.statusCode}');
    }
  }

  static void fetchTestData() async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:5000/api/test'));

    if (response.statusCode == 200) {
      // 요청이 성공한 경우
      print(response.body);
    } else {
      // 요청이 실패한 경우
      print('Request failed with status: ${response.statusCode}');
    }
  }

  static Future<String> getLevel(String message) async {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:5000/api/countlevel/'), // python server의 url
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'message': message,
      }),
    );

    if (response.statusCode == 200) {
      final result = response.body;
      final jsonData = jsonDecode(result);
      final level = jsonData['result'];

      print('API 호출 성공: $level');
      return level; //level
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
    return 'error';
  }
}
