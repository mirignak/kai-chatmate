import 'package:http/http.dart' as http;

class APIService {
  static Future<void> queryToGPT(
      String message, int level, String topic) async {
    final url = Uri.parse('http://localhost:5000/api/endpoint'); // gpt url
    try {
      final response = await http.post(
        url,
        body: {
          'message': message,
          'level': level.toString(),
          'topic': topic
        }, // POST 요청의 body에 전송할 데이터
      );

      if (response.statusCode == 200) {
        print('API 호출 성공');
        print(response.body); // 응답의 내용 출력
      } else {
        print('API 호출 실패');
      }
    } catch (e) {
      print('API 호출 중 오류 발생: $e');
    }
  }

  static Future<void> getLevel() async {
    final url =
        Uri.parse('http://localhost:5000/api/endpoint'); // python server의 url
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        print('API 호출 성공');
        print(response.body); // 응답의 내용 출력
      } else {
        print('API 호출 실패');
      }
    } catch (e) {
      print('API 호출 중 오류 발생: $e');
    }
  }
}
