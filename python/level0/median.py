def median(lst):
    lst.sort()
    l = len(lst)
    median = 0
    if l % 2 == 0:
        median = (lst[l/2] + lst[l/2 - 1]) / 2.0
    else:
        median = lst[l//2]
    return median

print median([1,1,2])
print median([4,5,5,4])
