from controllers.tokenizer import count_level, count_words

def getText():
  return input("텍스트를 입력하세요: ")
def count_test():
  text = getText()
  count = count_words(text)
  return count

def count_level_text():
  text = getText()
  level = count_level(text)
  return level
  # level check

# 단어별 개수 세기
counts = count_test()
# 결과 출력 및 어려움 수준 분류
print("텍스트 내 단어 개수:")
for word, count in counts.items():
    print(f"{word}: {count}")

# 레벨 도출
level = count_level_text()
# 어려움 수준 출력
print("텍스트의 어려움 수준:", level)
