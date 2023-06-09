import 'package:flat/api/api_services.dart';

class TextAnalysisService {
  static Future<String> analysis(String message) async {
    print('analysis service: $message');
    var _currLevel = await APIService.getLevel(message);
    print('evaluate level : $_currLevel');
    return _currLevel;
  }
}
