def digit_sum(n):
    s = 0
    while(n != 0):
        d = n % 10
        n = n / 10
        s = s + d
    return s

print digit_sum(1234)
