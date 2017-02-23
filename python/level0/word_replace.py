def censor(text, word):
    text = text.split(word)
    star  = "*" * len(word)
    text = star.join(text)
    return text

print censor("this hacker is wacko", "hacker")
