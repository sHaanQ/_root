def censor(text, word):
    text = text.split(word)
    star  = "*"*len(word)
    text = star.join(text)
    print text

censor("this hacker is wack hack", "hacker")
