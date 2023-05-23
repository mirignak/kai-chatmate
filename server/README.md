# Server
### API
- 사용자는 영어 말하기의 피드백을 Text로 받을 수 있다
  1. [VoiceToText] 사용자 음성(영어)을 입력받아 Text로 변환
  2. Text를 적절한 질의문으로 변환
  3. openai를 통해 질의 후 답변을 받음
  4. 답변을 저장하고 응답

- 사용자는 영어 말하기의 수준을 평가받을 수 있다
  1. [VoiceToText] 사용자 음성(영어)을 입력받아 Text로 변환
  2. Text에 사용된 단어 수 카운트
  3. 단어 수에 따라 수준을 판별하고 응답

### 공통 기능
- VoiceToText : 사용자 음성(영어)을 입력받아 Text로 변환
- TextToVoice : Text를 음성으로 출력