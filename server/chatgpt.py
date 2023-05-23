import openai

miri_api_key = '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'
openai.api_key = miri_api_key  # OpenAI API 키로 대체하세요

def generate_response(message): #질의
    response = openai.Completion.create(
        engine='text-davinci-003',
        prompt=message,
        max_tokens=50,
        temperature=0.7
    )
    return response.choices[0].text.strip()

