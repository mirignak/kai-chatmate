from tensorflow import keras

def count_words(text):
    tokenizer = keras.preprocessing.text.Tokenizer()
    tokenizer.fit_on_texts([text])
    word_counts = tokenizer.word_counts
    return word_counts

# 단어 종류 수에 따른 어려움 수준 분류
def count_level(text):
    counts = count_words(text)
    unique_words = len(counts)
    
    if unique_words <= 5:
        level = "Beginner"
    elif unique_words <= 10:
        level = "Intermediate"
    else:
        level = "Advanced"
    return level


