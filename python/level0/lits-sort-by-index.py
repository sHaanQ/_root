lst = []
for _ in range(int(raw_input())):
    name = raw_input()
    score = float(raw_input())
    lst.append((name,score))
    lst.sort(key=lambda x:x[1])

'''
Sample Input:

3
abc
12
def
23
ghi
2


Output:
[('ghi', 2.0), ('def', 4.0), ('abc', 12.0)]
'''
    
