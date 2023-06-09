from flask import Flask, request, jsonify
from flask_cors import CORS
from controllers.chatgpt import generate_response
from controllers.tokenizer import count_level

app = Flask(__name__)
CORS(app, resources={r"/*": {"origins": "*"}})

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

@app.route('/api/countlevel/', methods=['POST'])
def count_level_api():
    data = request.json
    text = data['message']
    
    level = count_level(text)
    return jsonify(result=level)

@app.route('/api/data', methods=['POST'])
def create_data():
    new_data = request.get_json()
    data.append(new_data)
    return jsonify(new_data)

if __name__ == '__main__':
    app.run(debug=True)