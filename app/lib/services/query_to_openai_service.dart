import 'package:flat/api/api_services.dart';

class QueryToOpenAIService {
  static String getPrompt(String topic, String message) {
    String roleGpt = "Cafe staff"; //topic에 따라 변경
    String roleMine = "Customer at the cafe"; //topic에 따라 변경
    String preparedPrompt = '''
        I'd like to practice my English speaking through role-play. The situation is $topic. Wait for my input before giving a simple reply. Take on the role of $roleGpt.
    ''';
    //Question: What are some useful phrases I can practice as a $roleMine in this conversation? Give me 15, and also provide a Korean translation.
    //Review all my input and act as an English teacher to provide English improvement advice.

    return preparedPrompt + message;
  }

  static Future<String> sendQuery(String topicId, String message) async {
    String prompt = getPrompt(topicId, message);
    print(prompt);

    // OpenAI에 질의를 보내는 로직 구현
    String response = await APIService.sendQueryToChatGPT(prompt);
    print('sendQueryService: $response');
    return response;
  }
}
