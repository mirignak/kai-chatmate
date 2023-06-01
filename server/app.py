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

@app.route('/api/data', methods=['GET'])
def get_data():
    return jsonify(data)

@app.route('/api/test', methods=['GET'])
def test():
    return 'Test success'

@app.route('/api/count/', methods=['GET'])
def count():
    text = request.args.get('text')
    count = count_words(text)
    return count

@app.route('/api/data/<int:data_id>', methods=['GET'])
def get_single_data(data_id):
    for item in data:
        if item['id'] == data_id:
            return jsonify(item)
    return jsonify({'error': 'Data not found'})

@app.route('/api/data', methods=['POST'])
def create_data():
    new_data = request.get_json()
    data.append(new_data)
    return jsonify(new_data)

@app.route('/api/data/<int:data_id>', methods=['PUT'])
def update_data(data_id):
    update_data = request.get_json()
    for item in data:
        if item['id'] == data_id:
            item['name'] = update_data['name']
            return jsonify(item)
    return jsonify({'error': 'Data not found'})

@app.route('/api/data/<int:data_id>', methods=['DELETE'])
def delete_data(data_id):
    for item in data:
        if item['id'] == data_id:
            data.remove(item)
            return jsonify({'message': 'Data deleted'})
    return jsonify({'error': 'Data not found'})

if __name__ == '__main__':
    app.run(debug=True)