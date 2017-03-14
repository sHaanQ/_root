def split_and_join(line):
    line = line.split()
    print "line is now a list chopped at spaces ->", line
    line = "-".join(line)
    return line
print split_and_join("This is the end")

# => line is now a list chopped at spaces -> ['This', 'is', 'the', 'end']
# => This-is-the-end
