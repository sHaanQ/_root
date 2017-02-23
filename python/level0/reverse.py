def reverse(text):
    rev = ""
    n = len(text) - 1
    while n >= 0:
        print text[n]
        rev += text[n]
        n -= 1

    print rev
    return rev

reverse("hello")
