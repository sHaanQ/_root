def remove_duplicates(lst):
    L = []
    for i in lst:
        if i not in L:
            L.append(i)
    return L

print remove_duplicates([1,1,2,2])
