from controllers.tokenizer import count_words

def getText():
  return input("텍스트를 입력하세요: ")
def count_test():
  text = getText()
  count = count_words(text)
  return count

def count_level_text():
  text = getText()
  # level check
  
