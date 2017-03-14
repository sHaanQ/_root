def split_and_join(line):
    # write your code here
    line = line.split()
    line = "-".join(line)
    return line
print split_and_join("This is the end")

# => This-is-the-end
