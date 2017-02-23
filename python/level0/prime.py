# A nice use of while/else

def is_prime(x):
    if x < 2:
        return False
#    elif x == 2:
#        return True
    else:
        n = 2
        while n <= x-1:
            if x % n == 0:
                return False
                break
            n += 1
        else:
            return True

if is_prime(10):
    print "Yes"
else:
    print "No"
if is_prime(3):
    print "yes"
else:
    print "No"
