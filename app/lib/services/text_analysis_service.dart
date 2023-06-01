import 'package:flat/api/api_services.dart';

class TextAnalysisService {
  static String analysis(String message) {
    print('analysis service: $message');

    int level = 1;
    var _currLevel = getLevel(message);
    print('evaluate level : $_currLevel');
    //prompt 조립
    // APIService.queryToGPT(message, level, 'topic');
    return 'd';
  }

  static Future<int> getLevel(String message) {
    return APIService.getLevel(message);
  }
}
