def is_int(x):
    if x > 0:
        print x
    else:
        x = abs(x) 
        print x

    print round(x)
        
    if x - round(x) > 0:
    	print "No"
        return False
    else:
    	print "Yes"
        return True

is_int(-3.4)
is_int(0.9)
is_int(10.0)
is_int(1)
is_int(7.5)