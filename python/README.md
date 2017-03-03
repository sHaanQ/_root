
```
 _                    __
|_) \/_|_|_  _ __    /  |_  _  _ _|_    _ |_  _  _ _|_
|   /  |_| |(_)| |   \__| |(/_(_| |_   _> | |(/_(/_ |_
```

1. [Print statement](#1-print-statement)  
  1.1 [Printing a List](#11-printing-a-list)   
  1.2 [Comma after print](#12-comma-after-print)  
2. [Reading input](#2-Reading-input)  
3. [Bitwise Operators](#3-bitwise-operators)  
  3.1 [Shift Operations](#31-shift-operations)  
  3.2 [NOT Operator](#32-not-operator)  
  3.3 [Example: Flip Bit](#33-example-flip-bit)  
4. [Conditional statements](#4-conditional-statements)  
5. [String methods](#5-string-methods)  
  5.1 [Concatenation](51-concatenation)  
  5.2 [Sub-String](#52-sub-string)  
  5.3 [String Looping](#53-string-looping)  
  5.4 [Reverse](#54-reverse)  
6. [Loops - While](#6-Loops-While)   
  6.1 [While / else](#61-while-else)  
  6.2 [For Loops](#62-for-loops)  
7. [Functions](#7-functions)  
	7.1 [Function Imports](#71-function-imports)  
	 7.1.1 [List all functions in a module](#711-list-all-functions-in-a-module)  
	 7.1.2 [Universal Import](#712-universal-import)  
	7.2 [Passing multiple arguments](#72-passing-multiple-arguments)  
	7.3 [Anonymous Functions / lambda Operator](#73-anonymous-functions-/-lambda-operator)  
	7.4 [Filter](#74-filter)   
8. [Lists](#8-lists)  
  8.1 [Building Lists / List Comprehension](#81-building-lists-list-comprehension)  
  8.2 [List Append](#82-list-append)   
  8.3 [List remove](#83-list-remove)   
  8.4 [List pop](#84-list-pop)   
  8.5 [List delete](#85-list-delete)  
  8.6 [List concatenate](#86-list-concatenate)   
  8.7 [List Reverse](#87-list-reverse)   
  8.8 [List Slicing](#88-list-slicing)   
  8.9 [List Insertion & Indexing](#89-list-insertion-indexing)   
  8.10 [Looping in lists](#810-looping-in-lists)   
  8.11 [Printing Pretty](#811-printing-pretty)   
  8.12 [Sorting the List](#812-sorting-the-list)   
  8.13 [Range in lists](#813-range-in-lists)   
  8.14 [Enumerate](#814-enumerate)   
  8.15 [Iterating Multiple Lists](#815-iterating-multiple-lists)   
9. [Dictionary](#9-dictionary)   
  9.1 [Assigning a dictionary](#91-assigning-a-dictionary)   
  9.2 [Adding New entries](#92-adding-new-entries)   
  9.3 [Add & Delete](#93-add-delete)   
  9.4 [Retrieve key and value](#94-retrieve-key-and-value)   
  9.5 [Lists and Dictionaries](#95-lists-and-dictionaries)  
  9.6 [Looping in dictionaries](#96-looping-in-dictionaries)   
  9.7 [List of Dictionaries](#97-list-of-dictionaries)  
10. [Class ? Get some...](#10-class-get-some)   
  10.1 [Creating object instances](#101-creating-object-instances)   
  10.2 [Every method’s first argument is self.](#102-every-methods-first-argument-is-self)   
  10.3 [Extending the class to store values](#103-extending-the-class-to-store-values)   





## 1. Print statement

```python
print "Turn", turn + 1
print '%s/%s/%s' % (now.year, now.month, now.day)
print "Let's not go to %s. 'Tis a silly %s." % (string_1, string_2)
print 'This isn\'t flying, this is falling with style!'
```
### 1.1 Printing a List
```python
name = ["bhargav", "bhargi", "berg"]
id = [1, 2, 3]
for i in id:
  print "My name is {0}. ID {1}".format(name[i-1], id[i-1])
```
### 1.2 Comma after print

String manipulation is useful in for loops if you want to modify
some content in a string.

```python
word = "Marble"
for char in word:
    print char,
```

The example above iterates through each character in word and,
in the end, prints out `M a r b l e`. The `,` character after our print
statement means that our next print statement keeps printing on the same line.

```python
phrase = "A bird in the hand..."

# Add your for loop
for i in phrase:
    if i == 'A' or i == 'a':
        print 'X',
    else:
        print i,

#Don't delete this print statement!
print
```
## 2. Reading input

There were two functions to get user input, called `input` and `raw_input`.
The difference between them is, `raw_input` *doesn't evaluate the data and returns as it is,
in __string form__*. But, `input` will evaluate whatever you entered and the result of evaluation will be returned

```python
name = raw_input("What is your name?")
var = input("Enter a number")
  #OR
var = int(input("Enter a number"))
```

###### Example One
  ```python
      name = raw_input("What is your name?")
      quest = raw_input("What is your quest?")
      color = raw_input("What is your favorite color?")

      print "Ah, so your name is %s, your quest is %s, " \
      "and your favorite color is %s." % (name, quest, color)
  ```
###### Example Two

  `raw_input` turns user input into a string, so we use int() to make it a number again.
  But we're going to want to use integers for our guesses! To do this, we'll wrap the `raw_inputs`
  with `int()` to convert the string to an integer.

  ```python
      number = raw_input("Enter a number: ")
      if int(number) == 0:
          print "You entered 0"
```
  ```python
      guess = int(raw_input("Your guess: "))
  ```

## 3. Bitwise Operators
```python
print 5 >> 4  # Right Shift
print 5 << 1  # Left Shift
print 8 & 5   # Bitwise AND
print 9 | 4   # Bitwise OR
print 12 ^ 42 # Bitwise XOR
print ~88     # Bitwise NOT

print bin(4)
# => 0b100

print int("0b11001001", 2)
# => 201

print int("111",2)
# => 7

print int(bin(5),2)
# => 5
```
### 3.1 Shift Operations
  ```python
      shift_right = 0b1100
      shift_left = 0b1

      # Your code here!
      shift_right >>= 2
      shift_left <<= 2

      print bin(shift_right)
      print bin(shift_left)

      # => 0b11
      # => 0b100
  ```
### 3.2 NOT Operator
  ```python
      print ~2
      # => -3
  ```
### 3.3 Example: Flip Bit
  ```python
      def flip_bit(number, n):
        result = 0b0
        result = number ^ (1 << (n-1))
        return bin(result)
  ```
## 4. Conditional statements
```python
if this_might_be_true():
	print "This really is true."
elif that_might_be_true():
	print "That is true."
else:
	print "None of the above."
```
Don't forget to include a `:` after your if statements!
###### Example
  ```python
      if guess_row not in range(5) or guess_col not in range(5):
          print "Oops, that's not even in the ocean."
  ```
## 5. String methods

We create a string with letters and numbers, then run the function `isalpha()` which returns
`False` since the string contains non-letter characters

```python
fifth_letter = "MONTY"[4]

ministry = "The ministry of Defence"

len()	- len(ministry)
lower()	- "Ryan".lower()
upper()	- ministry.upper()
str()	- str(2), would turn 2 into "2".

x = "J123"
x.isalpha()  # False
```

### 5.1 Concatenation
The `str()` method converts non-strings into strings. In the below example,
you convert the `number 2` into a string and then you concatenate the strings
together.

  ```python
      greeting = "Hello "
      name = "D. Y."
      welcome = greeting + name

      print "Spam" + " and" + " eggs"
      # => Spam and eggs

      print "I have " + str(2) + " coconuts!"
      # =>  I have 2 coconuts!
  ```

### 5.2 Sub-String
  ```python
      s = "Charlie"

      print s[0]
      # => "C"

      print s[1:4]
      # => "har"
  ```
### 5.3 String Looping
Strings are like lists with characters as elements. You can loop through strings
the same way you loop through lists

  ```python
      for letter in "Codecademy":
        print letter
  ```

  ```python
      S = "lumberjack"
      for x in S:
        print(x, end=' ') # Iterate over a string
      # => l u m b e r j a c k
  ```

  ```python
      word = "Programming is fun!"

      for letter in word:
          # Only print out the letter i
          if letter == "i":
        print letter
  ```
### 5.4 Reverse
`reverse("abcd")` should return `dcba`

OR

```python
[::-1] to help you with this.
S = "hello"
S[::-1] will return "olleh"
```
## 6. Loops - While

```python
loop_condition = True

while loop_condition:
    print "I am a loop"
    loop_condition = False
```

### 6.1 While / else

`while/else` is similar to `if/else`, but there is a __difference__: _the else
block will execute anytime the loop condition is evaluated to False_.

*This means that it will execute if the loop is never entered or if the
loop exits normally. If the loop exits as the result of a break, the
else will not be executed.*

###### Example One

In this example, the loop will `break` if a 5 is generated, and the `else`
will not execute. Otherwise, after 3 numbers are generated, the loop
condition will become `false` and the `else` will execute

```python
  import random

  print "Lucky Numbers! 3 numbers will be generated."
  print "If one of them is a '5', you lose!"

  count = 0
  while count < 3:
      num = random.randint(1, 6)
      print num
      if num == 5:
          print "Sorry, you lose!"
          break
      count += 1
  else:
      print "You win!"
```

###### Example Two
```python
  from random import randint

  # Generates a number from 1 through 10 inclusive
  random_number = randint(1, 10)

  guesses_left = 3
  # Start your game!
  while guesses_left > 0:
      guess = int(raw_input("Your Guess : " ))
      if guess == random_number:
          print "You Win"
          break
      else:
          guesses_left -= 1
  else:
      print "You lose."
```

###### Example Three
```python
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
```

## 6.2 For Loops
```python
print "Counting..."

for i in range(20):
    print i
```
### For / else
Just like with while, for loops may have an else associated with them.

In this case, the else statement is executed after the for, but only
if the for ends normally—that is, not with a `break`. This code will `break`
when it hits 'tomato', so the else block won't be executed.

```python
fruits = ['banana', 'apple', 'orange', 'tomato', 'pear', 'grape']

print 'You have...'
for f in fruits:
    if f == 'tomato':
        print 'A tomato is not a fruit!' # (It actually is.)
        break
    print 'A', f
else:
    print 'A fine selection of fruits!'
```

## 7. Functions

```python
def shout(phrase):
  if phrase == phrase.upper():
    return "YOU'RE SHOUTING!"
  else:
    return "Can you speak up?"

shout("I'M INTERESTED IN SHOUTING")

def count_small(numbers):
    total = 0
    for n in numbers:
  if n < 10:
      total = total + 1
    return total

lost = [4, 8, 15, 16, 23, 42]
small = count_small(lost)
print small
```

### 7.1 Function Imports

```python
  import math
  print math.sqrt(25)
```

We only really needed the `sqrt` function, and it can be frustrating to have to keep typing `math.sqrt()`. It's possible to import only certain variables or functions from a given module. Pulling in just a single function from a module is called a function `import`, and it's done with the from keyword:

`from module import function`

Now you can just type `sqrt()` to get the square root of a number—no more `math.sqrt()`

#### 7.1.1 List all functions in a module

```python
    import math            # Imports the math module
    everything = dir(math) # Sets everything to a list of things from math
    print everything       # Prints 'em all!
```

#### 7.1.2 Universal Import

What if we still want all of the variables and functions in a module but don't want to have to constantly type `math.` Universal import can handle this for you. The syntax for this is, `from module import *`

```python
    from math import *
    print sqrt(25)
```
###### Don't use Universal Imports

Here Be Dragons

Universal imports may look great on the surface, but they're not a good idea for one very important reason: they fill your program with a ton of variable and function names without the safety of those names still being associated with the module(s) they came from.

If you have a function of *your very own named `sqrt`* and you import `math`,
your function is safe: there is your `sqrt` and there is `math.sqrt`.
If you do from `math import *`, however, you have a problem: namely,
two different functions with the exact same name.

Even if your own definitions don't directly conflict with names from imported modules, if you `import *` from several modules at once, you won't be able to figure out which variable or function came from where. For these reasons, it's best to stick with either `import module` and type `module.name` or just `import specific variables and functions` from various modules as needed.

### 7.2 Passing multiple arguments

```python
def biggest_number(*args):
  print max(args)
  return max(args)

def smallest_number(*args):
  print min(args)
  return min(args)

def distance_from_zero(arg):
  print abs(arg)
  return abs(arg)


biggest_number(-10, -5, 5, 10)
smallest_number(-10, -5, 5, 10)
distance_from_zero(-10)

Ex:
def shut_down(s):
  if s.lower() == "yes":
    return "Shutting Down"
  elif s.lower() == "no":
    return "Shutdown aborted"
  else:
    return "Sorry"

print shut_down("yEs")
print shut_down("nO")
print shut_down("bleh")
```

### 7.3 Anonymous Functions / lambda Operator

One of the more powerful aspects of Python is that it allows for a style
of programming called functional programming, which means that you're
allowed to pass functions around just as if they were variables or values.

The `lambda operator or lambda function is a way to create small anonymous
functions`, i.e. functions without a name. These functions are throw-away
functions, i.e. they are just needed where they have been created.

Lambda functions are mainly used in combination with the functions
`filter()`, `map()` and `reduce()`.

```python
# lambda
# lambda argument_list: expression

lambda x: x % 3 == 0

# Is the same as

def by_three(x):
    return x % 3 == 0
```

We don't need to actually give the function a name; it does its work
and returns a value without one. That's why the function the lambda
creates is an anonymous function.

### 7.4 Filter

The function `filter(function, list)` offers _an elegant way to filter out
all the elements of a `list`_, for which the function returns `True`.

The function `filter(f,l)` needs a _function_ `f` as its first argument.
`f` returns a Boolean value, i.e. either `True` or `False`.
This function will be applied to every element of the _list_ `l`.
Only if `f` returns `True` will the element of the *list* be included in
the result *list*

###### Example One
```python
	fib = [0,1,1,2,3,5,8,13,21,34,55]
	result = filter(lambda x: x % 2, fib)
	print result
	# => [1, 1, 3, 5, 13, 21, 55]
```

###### Example Two
```python
	my_list = range(16)
	print filter(lambda x: x % 3 == 0, my_list)
	# => [0, 3, 6, 9, 12, 15]
```
###### Example Three
```python
	languages = ["HTML", "JavaScript", "Python", "Ruby"]
	print filter(lambda x: 'Python' in x, languages)
	# => ['Python']
```

###### Example Four
```python
	lst = ['a', 'ab', 'abc', 'bac']
	filter(lambda k: 'ab' in k, lst)
	# => ['ab', 'abc']
```

###### Example Five
```python
	cubes = [x**3 for x in range(1, 11)]    # List Comprehension
	filter(lambda x: x % 3 == 0, cubes)
	# => [27, 216, 729]
```
###### Example Six
```python
	squares = [x**2 for x in range(1,11)]
	print filter(lambda x: x > 30 and x < 70, squares)
	# => [36, 49, 64]
```
###### Example Seven
```python
	garbled = "IXXX aXXmX aXXXnXoXXXXXtXhXeXXXXrX sXXXXeXcXXXrXeXt mXXeXsXXXsXaXXXXXXgXeX!XX"
	message = filter(lambda x: 'X' not in x, garbled)
	print message
	# => "I am another secret message!"
```

## 8. Lists

Lists are a datatype you can use to store a collection of different pieces of information as a
sequence under a single variable name. (Datatypes you've already learned about include strings,
numbers, and booleans.)

```python
zoo_animals = ["pangolin", "cassowary", "sloth", "Optimus"];
if len(zoo_animals) > 3:
  print "The first animal at the zoo is the " + zoo_animals[0]
  print "The second animal at the zoo is the " + zoo_animals[1]
  print "The third animal at the zoo is the " + zoo_animals[2]
  print "The fourth animal at the zoo is the " + zoo_animals[3]
```

### 8.1 Building Lists / List Comprehension

Let's say you wanted to build a list of the numbers from 0 to 50
(inclusive). We could do this pretty easily:

`my_list = range(51)`

But what if we wanted to generate a list according to some logic—for
example, a list of all the even numbers from 0 to 50? We use list comprehension.
List comprehensions	are a powerful way to generate lists using the keywords `for/in` and `if`

```python
evens_to_50 = [i for i in range(51) if i % 2 == 0]
print evens_to_50

# This will create a new_list populated by the numbers one to five.
new_list = [x for x in range(1,6)]
# => [1, 2, 3, 4, 5]

# If you want those numbers doubled, you could use:
doubles = [x*2 for x in range(1,6)]
# => [2, 4, 6, 8, 10]

# And if you only wanted the doubled numbers that are evenly divisible by three:
doubles_by_3 = [x*2 for x in range(1,6) if (x*2)%3 == 0]
# => [6]

# Even Squares
even_squares = [i*i for i in range(1,12) if i*i % 2 == 0]

c = ['C' for x in range(5) if x < 3]
print c
# => ['C', 'C', 'C'].

cubes_by_four = [x ** 3 for x in range(1, 11) if x ** 3 % 4 == 0]
print cubes_by_four
# => [8, 64, 216, 512, 1000]

threes_and_fives = [x for x in range(1,16) if x % 3 == 0 or x % 5 == 0]
print threes_and_fives
# => [3, 5, 6, 9, 10, 12, 15]
```

### 8.2 List Append

A list doesn't have to have a fixed length. You can add items to the end of a
list any time you like!

```python
letters = ['a', 'b', 'c']
letters.append('d')
print len(letters)
print letters
```

### 8.3 List remove

We can remove an item from the list using `letters.remove('a')`

### 8.4 List pop

`n.pop(index)` will remove the item at index from the list and return it to you

```python
n = [1, 3, 5]
n.pop(1)
# Returns 3 (the item at index 1)
print n
# prints [1, 5]
```

### 8.5 List delete
`del(n[1])` is like `.pop` in that it will remove the item at the given
index, but it won't return it:

```python
del(n[1])
# Doesn't return anything
print n
```

### 8.6 List concatenate

```python
a = [1, 2, 3]
b = [4, 5, 6]
print a + b
# prints [1, 2, 3, 4, 5, 6]
```

### 8.7 List Reverse

A negative stride progresses through the list from right to left.

###### Example One
```python
letters = ['A', 'B', 'C', 'D', 'E']
print letters[::-1]
# => ['E', 'D', 'C', 'B', 'A'].
```

###### Example Two
```python
my_list = range(1, 11)
backwards = my_list[::-1]
print backwards
# => [10, 9, 8, 7, 6, 5, 4, 3, 2, 1]
```

### 8.8 List Slicing


Access a portion of a list.

List slicing allows us to access elements of a list in a concise manner.
The syntax looks like this:

`[start:end:stride]`

Where `start` describes where the *slice starts __(inclusive)__*, `end` is where
it *ends __(exclusive)__*, and `stride` describes the *space between items* in
the sliced list. For example, a stride of 2 would select every other
item from the original list to place in the sliced list.

`Stride Length`

A _positive_ stride length traverses the list from _left to right_,
and a _negative_ one traverses the list from _right to left_.

Further, a stride length of 1 traverses the list "by ones," a stride
length of 2 traverses the list "by twos," and so on.
'''

###### Example One
```python
  l = [i ** 2 for i in range(1, 11)]
  # Should be [1, 4, 9, 16, 25, 36, 49, 64, 81, 100]

  print l[2:9:2]
  # => [9, 25, 49, 81]
```

###### Example Two
```python
  letters = ['a', 'b', 'c', 'd', 'e']
  slice = letters[1:3]
  print slice
  print letters
```
###### Example Three
```python
  to_21 = range(1,22)
  odds = to_21[::2]
  middle_third = to_21[7:14:1]

  print odds
  print middle_third

  # => [1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21]
  # => [8, 9, 10, 11, 12, 13, 14]
```
###### Example Four
```python
  suitcase = ["sunglasses", "hat", "passport", "laptop", "suit", "shoes"]

  first  = suitcase[0:2]  # The first and second items (index zero and one)
  middle = suitcase[2:4]  # Third and fourth items (index two and three)
  last   = suitcase[4:6]  # The last two items (index four and five)
```
###### Another one
```python
  animals = "catdogfrog"
  cat  = animals[:3]   # The first three characters of animals
  dog  = animals[3:6]  # The fourth through sixth characters
  frog = animals[6:]   # From the seventh character to the end
```
__Omitting Indices__

If you don't pass a particular index to the list slice,
Python will pick a default.

```python
to_five = ['A', 'B', 'C', 'D', 'E']

print to_five[3:]
# prints ['D', 'E']

print to_five[:2]
# prints ['A', 'B']

print to_five[::2]
# print ['A', 'C', 'E']

to_one_hundred = range(101)
backwards_by_tens = to_one_hundred[::-10]
print backwards_by_tens
# => [100, 90, 80, 70, 60, 50, 40, 30, 20, 10, 0]

garbled = "!XeXgXaXsXsXeXmX XtXeXrXcXeXsX XeXhXtX XmXaX XI"
message = garbled[::-2]
print message
# => 'I am the secret message!'
```

### 8.9 List Insertion & Indexing

Search for an item in a list
```python
animals = ["ant", "bat", "cat"]
print animals.index("bat")
```

We can also insert items into a list.

```python
animals.insert(1, "dog")
print animals
```

We insert `dog` at index 1, which moves everything down by 1
animals will be `["ant", "dog", "bat", "cat"]`

### 8.10 Looping in lists

for variable in list_name:
# Do stuff!

A `variable` name follows the `for` keyword; it will be assigned the value
of each list item in turn. Then in `list_name` designates list_name as the
list the loop will work on.

```python
my_list = [1,9,3,8,5,7]

for number in my_list:
	# Your code here
	print 2 * number

names = ["Adam","Alex","Mariah","Martine","Columbus"]

for i in names:
	print i

# Method 1 - for item in list:

for item in list:
    print item

# Method 2 - iterate through indexes:

for i in range(len(list)):
    print list[i]
```

__Method 1__ is useful to loop through the list, but it's not possible to modify the
list this way. *__Method 2__ uses indexes to loop through the list, making it possible
to also modify the list if needed*.

### 8.11 Printing Pretty

We're getting pretty close to a playable board, but wouldn't it be nice to get
rid of those quote marks and commas?

```python
letters = ['a', 'b', 'c', 'd']
print " ".join(letters)
print "---".join(letters)
```

In the example above, we create a list called letters.
Then, we print `a b c d`. The `.join` method uses the string to combine the items in the list.
Finally, we print `a---b---c---d`. We are calling the `.join` function on the `---` string.

```python
board = []
# Creates a list containing 5 lists, each of 5 items, all set to 0
w, h = 5, 5
board = [['O' for x in range(w)] for y in range(h)]

def print_board(board):
    for lst in board:
	print " ".join(lst)

print_board(board)

# => O O O O O
#    O O O O O
#    O O O O O
#    O O O O O
#    O O O O O

```

### 8.12 Sorting the List

Sorting can happen on numbers and strings. Others I do not know yet.

```python
start_list = [5, 3, 1, 2, 4]
square_list = []

# Your code here!

for i in start_list:
  square_list.append(i ** 2)

square_list.sort()
print square_list

# => [1, 4, 9, 16, 25]
```

### 8.13 Range in lists

Okay! Range time. The Python `range()` function is just a shortcut for generating a
list, so you can use ranges in all the same places you can use lists.

```Python
range(6) # => [0,1,2,3,4,5]
range(1,6) # => [1,2,3,4,5]
range(1,6,3) # => [1,4]
```
The range function has three different versions:

```python
range(stop)
range(start, stop)
range(start, stop, step)
```

In all cases, the `range()` function returns a list of numbers from `start` up to
(but not including) `stop`. Each item increases by `step`.

If omitted, `start` defaults to `zero` and `step` defaults to `one`.

```python
n = [3, 5, 7]

def double_list(x):
  for i in range(0, len(x)):
    x[i] = x[i] * 2
    # Don't forget to return your new list!
  return x

print double_list(n)

# => [6, 10, 14]
```

```python
n = ["Michael", "Lieberman"]
# Add your function here

def join_strings(words):
    result = ""
    for i in range(0, len(words)):
      result = result + words[i]
    return result

print join_strings(n)

# => MichaelLieberman
```

### 8.14 Enumerate

`enumerate` works by supplying a corresponding index to each element in the list that you pass it. Each time you go through the loop, index will be one greater, and item will be the next item in the sequence. It's very similar to using a normal for loop with a list, except this gives us an easy way to count how many items we've seen so far.

```python
choices = ['pizza', 'pasta', 'salad', 'nachos']

print 'Your choices are:'
for index, item in enumerate(choices):
    print index, item

# =>  Your choices are:
#     0 pizza
#     1 pasta
#     2 salad
#     3 nachos
```

### 8.15 Iterating Multiple Lists

It's also common to need to iterate over two lists at once. This is where
the built-in `zip` function comes in handy. `zip` will create pairs of elements when passed two lists, and will stop at the end of the shorter list.

`zip` can handle three or more lists as well!

```python
list_a = [3, 9, 17, 15, 19]
list_b = [2, 4, 8, 10, 30, 40, 50, 60, 70, 80, 90]

for a, b in zip(list_a, list_b):
    # Add your code here!
    if a > b:
        print a
    else:
        print b
```

## 9. Dictionary

A dictionary is similar to a list, but you access values by looking up a key instead of an index. A key can be any string or number. Dictionaries are enclosed in curly braces, like so:

`d = {'key1' : 1, 'key2' : 2, 'key3' : 3}`

This is a dictionary called d with three key-value pairs. The key `key1` points to the `value 1`, `key2` to `2`, and so on. Dictionaries are great for things like phone books (pairing a name with a phone number), login pages (pairing an e-mail address with a username), and more!

### 9.1 Assigning a dictionary

```python
residents = {'Puffin' : 104, 'Sloth' : 105, 'Burmese Python' : 106}

print residents['Puffin'] # Prints Puffin's room number

# Your code here!
print residents['Sloth']
print residents['Burmese Python']
```

### 9.2 Adding New entries

An empty pair of curly braces `{}` is an __empty dictionary__, just like an empty pair of `[]` is an empty list.

```python
menu = {} # Empty dictionary
menu['Chicken Alfredo'] = 14.50 # Adding new key-value pair
print menu['Chicken Alfredo']

# Your code here: Add some dish-price pairs to menu!
menu['Letuce Sandwich'] = 3.50
menu['Mango Juice'] = 12.70
menu['Sweet Corn + Chat Masala'] = 1.80

print "There are " + str(len(menu)) + " items on the menu."
print menu
```

### 9.3 Add & Delete

Because dictionaries are mutable, they can be changed in many ways. Items can be removed from a dictionary with the `del` command `del dict_name[key_name]` will remove the key key_name and its associated value from the dictionary.

A new value can be associated with a key by assigning a value to the key, like so `dict_name[key] = new_value`

### 9.4 Retrieve key and value

```python
#[Method One]
d = {'a': 'apple', 'b': 'berry', 'c': 'cherry'}

for key in d:
    # Your code here!
    print key, d[key]

#[Method Two]
knights = {'gallahad': 'the pure', 'robin': 'the brave'}
for k, v in knights.iteritems():
  print k, v

''' Prints the key and the value '''
# => gallahad the pure
# => robin the brave

# Example
D = {'a': 1, 'b': 2, 'c': 3}
for key in D:
  print(key, '-', D[key]) # Use dict keys iterator and index

# => a - 1
#    c - 3
#    b - 2

list(D.items())
#=> [('a', 1), ('c', 3), ('b', 2)]
for (key, value) in D.items():
  print(key, '-', value)		# Iterate over both keys and values

# => a - 1
#    c - 3
#    b - 2
```

### 9.5 Lists and Dictionaries

```python
inventory = {
'gold' : 500,
'pouch' : ['flint', 'twine', 'gemstone'], # Assigned a new list to 'pouch' key
'backpack' : ['xylophone','dagger', 'bedroll','bread loaf']
}

# Adding a key 'burlap bag' and assigning a list to it
inventory['burlap bag'] = ['apple', 'small ruby', 'three-toed sloth']

# Sorting the list found under the key 'pouch'
inventory['pouch'].sort()

# Your code here
inventory['pocket'] = ['seashell', 'strange berry', 'lint']
inventory['backpack'].sort()

inventory['backpack'].remove('dagger')
inventory['gold'] = inventory['gold'] + 50

print inventory['gold']
print inventory['pocket']
print inventory['pouch']
print inventory['backpack']
```

### 9.6 Looping in dictionaries
```python
prices = {
    "banana" : 4,
    "apple"  : 2,
    "orange" : 1.5,
    "pear"   : 3,
}
stock = {
    "banana" : 6,
    "apple"  : 0,
    "orange" : 32,
    "pear"   : 15,
}

for key in prices:
    print key
    print "price: %s" % prices[key]
    print "stock: %s" % stock[key]

total = 0
for i in prices:
    total = total + prices[i] * stock[i]
  print total
```

###### More Looping techniques

To loop over two or more sequences at the same time, the entries can be paired with the `zip()` function.
```python
questions = ['name', 'quest', 'favorite color']
answers = ['lancelot', 'the holy grail', 'blue']
for q, a in zip(questions, answers):
  print 'What is your {0}?  It is {1}.'.format(q, a)
```

### 9.7 List of Dictionaries

```python
lloyd = {
    "name": "Lloyd",
    "homework": [90.0,97.0, 75.0, 92.0],
    "quizzes": [88.0, 40.0, 94.0],
    "tests": [75.0, 90.0]
}
alice = {
    "name": "Alice",
    "homework": [100.0, 92.0, 98.0, 100.0],
    "quizzes": [82.0, 83.0, 91.0],
    "tests": [89.0, 97.0]
}
tyler = {
    "name": "Tyler",
    "homework": [0.0, 87.0, 75.0, 22.0],
    "quizzes": [0.0, 75.0, 78.0],
    "tests": [100.0, 100.0]
}

students = [lloyd, alice, tyler]

for n in [0,1,2]:
    for k, v in students[n].iteritems():
  print k, v

    #[OR]

for n in range(len(students)):
    for k, v in students[n].iteritems():
  print k, v
```

## 10. Class ? Get some...

Python follows the standard object-oriented programming model of
providing a means for you to define the code and the data it works on as a
class. Once this definition is in place, you can use it to create (or instantiate)
__data objects__ , which inherit their characteristics from your class.

Within the object-oriented world, your code is often referred to as the class’s
__methods__, and your data is often referred to as its __attributes__. Instantiated
data objects are often referred to as __instances__.

Each object is created from the class and shares a similar set of
characteristics. The methods (your code) are the same in each instance, but
each object’s attributes (your data) differ because they were created from your
raw data.

Python uses class to create objects. Every defined class has a special method
called `__init__()`, which allows you to control how objects are initialized.
Methods within your class are defined in much the same way as functions,
that is, using `def`.

```python
class Athlete:
  def __init__(self):
    # The code to initialize a "Athlete" object.
      ...
```

### 10.1 Creating object instances
With the class in place, it’s easy to create object instances. Simply assign a call
to the class name to each of your variables. In this way, the class (together
with the `__init__()` method) provides a mechanism that lets you create
a custom factory function that you can use to create as many object
instances as you require

```python
a = Athlete()
b = Athlete()
c = Athlete()
d = Athlete()
```

`a,b,c & d` are called target identifiers, they hold the reference to your instance.
When Python processes the above lines of code.

`a = Athlete()` becomes `Athlete().__init__(a)`

which identifies the class, the method (which is automatically
set to `__init__()`), and the object instance being operated on i.e. `a`.

`Athlete` - *Name of the class*  
`__init__` - *Name of the method*  
`a` - *The target Identifier of the object instance*

The target identifer is assigned to the `self` argument. Without it, the Python interpreter
can’t work out which object instance to apply the method invocation to. Note
that the class code is designed to be shared among all of the object instances:
the methods are shared, the attributes are __not__. The `self` argument helps
identify which object instance’s data to work on.

### 10.2 Every method’s first argument is self.

Not only does the `__init__()` method require `self` as its first
argument, but so does every other method defined within your class. Python arranges for the first argument of every method to be the invoking (or calling) object instance.

### 10.3 Extending the class to store values

```python
class Athlete:
  def __init__(self, value=0):
    self.thing = value
  def how_big(self):
    return(len(self.thing))
```

When you invoke a class method on an object instance, Python arranges for
the first argument to be the invoking object instance, *which is always assigned
to each method’s* `self` argument. This fact alone explains why `self` is
so important and also why self needs to be the __first argument__ to every object
method you write:


| What you write              | What Python executes                    |
| -------------               |:-------------:                          |
| `d = Athlete("Holy Grail")` | `Athlete.__init__(d, "Holy Grail")`     |
| `d.how_big()`               | `Athlete.how_big(d)`                    |
