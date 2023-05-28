import tensorflow as tf
from tensorflow import keras
from collections import Counter

def count_words(text):
    tokenizer = keras.preprocessing.text.Tokenizer()
    tokenizer.fit_on_texts([text])
    word_counts = tokenizer.word_counts
    return word_counts

# 사용자로부터 텍스트 입력 받기
text = input("텍스트를 입력하세요: ")

# 단어별 개수 세기
counts = count_words(text)

# 결과 출력 및 어려움 수준 분류
print("텍스트 내 단어 개수:")
for word, count in counts.items():
    print(f"{word}: {count}")

# 단어 종류 수에 따른 어려움 수준 분류
unique_words = len(counts)
if unique_words <= 5:
    level = "Beginner"
elif unique_words <= 10:
    level = "Intermediate"
else:
    level = "Advanced"

# 어려움 수준 출력
print("텍스트의 어려움 수준:", level)
