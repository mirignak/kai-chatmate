import 'package:flat/api/api_services.dart';

class TextAnalysisService {
  static String analysis(String message) {
    int level = 1;
    //prompt 조립

    APIService.queryToGPT(message, level, 'topic');
    return 'd';
  }
}
