from flask import Flask, request, jsonify
from controllers.chatgpt import generate_response
from controllers.tokenizer import count_words

app = Flask(__name__)

# 예시로 사용할 데이터
data = [
    {'id': 1, 'name': 'John'},
    {'id': 2, 'name': 'Jane'}
]

@app.route('/')
def home():
    return 'Home'

@app.route('/api/chat', methods=['POST'])
def chat():
    data = request.json
    message = data['message']
    
    # ChatGPT와의 통신
    response = generate_response(message)

    # 응답 전송
    return jsonify({'response': response})

@app.route('/api/test', methods=['GET'])
def test():
    return 'Test success'

@app.route('/api/count/', methods=['POST'])
def count():
    data = request.json
    text = data['message']
    
    count = count_words(text)
    return count

@app.route('/api/data', methods=['POST'])
def create_data():
    new_data = request.get_json()
    data.append(new_data)
    return jsonify(new_data)

if __name__ == '__main__':
    app.run(debug=True)