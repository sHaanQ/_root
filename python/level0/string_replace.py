def anti_vowel(text):
    for c in text:
        if c in "aeiouAEIOU":
            text = text.replace(c, "")
    return text

print anti_vowel("This is the end")
