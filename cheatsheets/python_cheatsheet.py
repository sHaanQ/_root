"""
 _                    __
|_) \/_|_|_  _ __    /  |_  _  _ _|_    _ |_  _  _ _|_
|   /  |_| |(_)| |   \__| |(/_(_| |_   _> | |(/_(/_ |_

[BigFig]

"""

#[Print statement]

	print "Turn", turn + 1
	print '%s/%s/%s' % (now.year, now.month, now.day)
	print "Let's not go to %s. 'Tis a silly %s." % (string_1, string_2)
	print 'This isn\'t flying, this is falling with style!'

	#[Printing a List]
		name = ["bhargav", "bhargi", "berg"]
		id = [1, 2, 3]
		for i in id:
			print "My name is {0}. ID {1}".format(name[i-1], id[i-1])

#[Functions]

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


#[Function Imports]

	import math
	print math.sqrt(25)

	"""
	Nice work! Now Python knows how to take the square root of a number.

	However, we only really needed the sqrt function, and it can be frustrating
	to have to keep typing math.sqrt().

	It's possible to import only certain variables or functions from a given module.
	Pulling in just a single function from a module is called a function import, and
	it's done with the from keyword:
	"""

	from module import function

	"""
	Now you can just type sqrt() to get the square root of a number—no more math.sqrt()!
	"""

	#[List all functions in a module]

	import math            # Imports the math module
	everything = dir(math) # Sets everything to a list of things from math
	print everything       # Prints 'em all!

	#[Universal Import]

	'''
	What if we still want all of the variables and functions in a module but don't want to
	have to constantly type math.?

	Universal import can handle this for you. The syntax for this is:
	'''

	from module import *

	Ex:

	from math import *
	print sqrt(25)

	#[Don't use Universal Imports]

	'''
	Here Be Dragons

	Universal imports may look great on the surface, but they're not a good idea for one very
	important reason:
	they fill your program with a ton of variable and function names without the safety of
	those names still being associated with the module(s) they came from.

	If you have a function of your very own named sqrt and you import math, your function
	is safe: there is your sqrt and there is math.sqrt. If you do from math import *, however,
	you have a problem: namely, two different functions with the exact same name.

	Even if your own definitions don't directly conflict with names from imported modules, if
	you import * from several modules at once, you won't be able to figure out which
	variable or function came from where.

	For these reasons, it's best to stick with either import module and type module.name
	or just import specific variables and functions from various modules as needed.
	'''

	#[Passing multiple arguments]

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

#[String methods]

	fifth_letter = "MONTY"[4]

	ministry = "The ministry of Defence"

	len()	- len(ministry)
	lower()	- "Ryan".lower()
	upper()	- ministry.upper()
	str()	- str(2), would turn 2 into "2".

	x = "J123"
	x.isalpha()  # False

	"""
	In the first line, we create a string with letters and numbers.

	The second line then runs the function isalpha() which returns
	False since the string contains non-letter characters.
	"""

	#[Concatenation]

		"""
		Remember how to concatenate (i.e. add) strings together?
		"""

		greeting = "Hello "
		name = "D. Y."
		welcome = greeting + name

		print "Spam" + " and" + " eggs"
			This will print I have 2 coconuts!


		print "I have " + str(2) + " coconuts!"

		"""
		The str() method converts non-strings into strings. In the above example,
		you convert the number 2 into a string and then you concatenate the strings
		together just like in the previous exercise.
		"""

	#[Sub-String]
		s = "Charlie"

		print s[0]
		# will print "C"

		print s[1:4]
		# will print "har"

	#[String Looping]
		"""
		Strings are like lists with characters as elements.
		You can loop through strings the same way you loop through lists
		"""
		for letter in "Codecademy":
		    print letter

		for x in S: print(x, end=' ') # Iterate over a string
		...
		l u m b e r j a c k

		# Empty lines to make the output pretty
		print
		print

		word = "Programming is fun!"

		for letter in word:
		    # Only print out the letter i
		    if letter == "i":
			print letter

#[Reading input]

	name = raw_input("What is your name?")
	var = input("Enter a number")
		OR
	var = int(input("Enter a number"))

	"""
	There were two functions to get user input, called input and raw_input.
	The difference between them is, "raw_input" doesn't evaluate the data and returns as it is,
	in string form.
	But, "input" will evaluate whatever you entered and the result of evaluation will be returned
	"""

	name = raw_input("What is your name?")
	quest = raw_input("What is your quest?")
	color = raw_input("What is your favorite color?")

	print "Ah, so your name is %s, your quest is %s, " \
	"and your favorite color is %s." % (name, quest, color)
	
	# Example 
	number = raw_input("Enter a number: ")
	if int(number) == 0:
	    print "You entered 0"

	'''
	raw_input asks the user for input and returns it as a string. But we're going to
	want to use integers for our guesses! To do this, we'll wrap the raw_inputs with int()
	to convert the string to an integer.
	'''

#[Comparators]

	3 < 4
	5 >= 5
	10 == 10
	12 != 13

#[Boolean operators]

	True or False
	(3 < 4) and (5 >= 5)
	this() and not that()

#[Conditional statements]

	if this_might_be_true():
		print "This really is true."
	elif that_might_be_true():
		print "That is true."
	else:
		print "None of the above."

	"""Don't forget to include a : after your if statements!"""

#[type()]

	'''Finally, the type() function returns the type of the data it receives as an argument.
	If you ask Python to do the following:'''

	print type(42)
	print type(4.2)
	print type('spam')

	#Python will output:

	<type 'int'>
	<type 'float'>
	<type 'str'>

#[Lists]

	'''
	Lists are a datatype you can use to store a collection of different pieces of information as a
	sequence under a single variable name. (Datatypes you've already learned about include strings,
	numbers, and booleans.)
	'''

	zoo_animals = ["pangolin", "cassowary", "sloth", "Optimus"];
	if len(zoo_animals) > 3:
		print "The first animal at the zoo is the " + zoo_animals[0]
		print "The second animal at the zoo is the " + zoo_animals[1]
		print "The third animal at the zoo is the " + zoo_animals[2]
		print "The fourth animal at the zoo is the " + zoo_animals[3]

	#[List Append]

		'''
		A list doesn't have to have a fixed length. You can add items to the end of a
		list any time you like!
		'''

		letters = ['a', 'b', 'c']
		letters.append('d')
		print len(letters)
		print letters

	#[List remove]

		'''
		We can remove an item from the list.
		'''

		letters.remove('a')


	#[List pop]
		'''
		n.pop(index) will remove the item at index from the list and return it to you:
		'''

		n = [1, 3, 5]
		n.pop(1)
		# Returns 3 (the item at index 1)
		print n
		# prints [1, 5]

	#[List remove]
		'''
		n.remove(item) will remove the actual item if it finds it:
		'''

		n.remove(1)
		# Removes 1 from the list,
		# NOT the item at index 1
		print n
		# prints [3, 5]

	#[List delete]	
		'''
		del(n[1]) is like .pop in that it will remove the item at the given
		index, but it won't return it:
		'''

		del(n[1])
		# Doesn't return anything
		print n
		# prints [1, 5]

	#[List concatenate]
		a = [1, 2, 3]
		b = [4, 5, 6]
		print a + b
		# prints [1, 2, 3, 4, 5, 6]

		'''
		The example above is just a reminder of how to concatenate two lists.
		'''

		m = [1, 2, 3]
		n = [4, 5, 6]

		# Add your code here!
		def join_lists(x, y):
		    return x + y

		print join_lists(m, n)
		# You want this to print [1, 2, 3, 4, 5, 6]
		
	#[List Slicing]

		'''
		Access a portion of a list.

		We take a subsection and store it in the slice list.
		We start at the index before the colon and continue up to
		but not including the index after the colon.
		'''

		letters = ['a', 'b', 'c', 'd', 'e']
		slice = letters[1:3]
		print slice
		print letters

		'''
		Another exmaple
		'''

		suitcase = ["sunglasses", "hat", "passport", "laptop", "suit", "shoes"]

		first  = suitcase[0:2]  # The first and second items (index zero and one)
		middle = suitcase[2:4]  # Third and fourth items (index two and three)
		last   = suitcase[4:6]  # The last two items (index four and five)

		'''
		Another one
		'''

		animals = "catdogfrog"
		cat  = animals[:3]   # The first three characters of animals
		dog  = animals[3:6]  # The fourth through sixth characters
		frog = animals[6:]   # From the seventh character to the end

	#[List Insertion & Indexing]

		'''
		Search for an item in a list
		'''
		animals = ["ant", "bat", "cat"]
		print animals.index("bat")

		'''
		We can also insert items into a list.
		'''
		animals.insert(1, "dog")
		print animals

		'''
		We insert "dog" at index 1, which moves everything down by 1
		animals will be ["ant", "dog", "bat", "cat"]
		'''

	#[Looping in lists]

		for variable in list_name:
		# Do stuff!

		'''
		A variable name follows the for keyword; it will be assigned the value
		of each list item in turn.

		Then in list_name designates list_name as the list the loop will work on.
		'''

		Ex:
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

		'''
		Method 1 is useful to loop through the list, but it's not possible
		to modify the list this way. Method 2 uses indexes to loop through
		the list, making it possible to also modify the list if needed.
		'''

	#[List of Lists]
		
		'''
		Single list that contains multiple lists and how to use them in a function
		'''
		
		# Example One
		list_of_lists = [[1,2,3], [4,5,6]]

		for lst in list_of_lists:
		    for item in lst:
			print item

		# Example Two
		n = [[1, 2, 3], [4, 5, 6, 7, 8, 9]]
		# Add your function here
		def flatten(lists):
		    results = []
		    for numbers in lists:
			for i in numbers:
			    results.append(i)
		    return results

		print flatten(n)
		
		# Creates a list containing 5 lists, each of 8 items, all set to 0
		w, h = 8, 5
		Matrix = [[0 for x in range(w)] for y in range(h)]

	#[Printing Pretty]

		'''
		We're getting pretty close to a playable board, but wouldn't it be nice to get
		rid of those quote marks and commas?
		'''

		letters = ['a', 'b', 'c', 'd']
		print " ".join(letters)
		print "---".join(letters)

		'''
		In the example above, we create a list called letters.
		Then, we print a b c d.

		The .join method uses the string to combine the items in the list.

		Finally, we print a---b---c---d.
		We are calling the .join function on the "---" string.
		'''

		# Example

		board = []
		# Creates a list containing 5 lists, each of 5 items, all set to 0
		w, h = 5, 5 
		board = [['O' for x in range(w)] for y in range(h)] 

		def print_board(board):
		    for lst in board:
			print " ".join(lst)

		print_board(board)


	#[Sorting the List]

		'''
		Sorting can happen on numbers and strings. Others I do not know yet.
		'''

		start_list = [5, 3, 1, 2, 4]
		square_list = []

		# Your code here!

		for i in start_list:
			square_list.append(i ** 2)

		square_list.sort()
		print square_list
		
	#[Range in lists]
	
		n = [3, 5, 7]

		def double_list(x):
		    for i in range(0, len(x)):
			x[i] = x[i] * 2
		    # Don't forget to return your new list!
		    return x

		print double_list(n)

		# Passing a range into a function
		
		'''
		Okay! Range time. The Python range() function is just a shortcut for generating a
		list, so you can use ranges in all the same places you can use lists.

		range(6) # => [0,1,2,3,4,5]
		range(1,6) # => [1,2,3,4,5]
		range(1,6,3) # => [1,4]

		The range function has three different versions:

		    range(stop)
		    range(start, stop)
		    range(start, stop, step)

		In all cases, the range() function returns a list of numbers from start up to
		(but not including) stop. Each item increases by step.

		If omitted, start defaults to zero and step defaults to one.
		'''

		# Example 1
		
		def my_function(x):
		    for i in range(0, len(x)):
			x[i] = x[i] * 2
		    return x

		print my_function(range(2)) # Add your range between the parentheses!
		
		# Example 2
		
		n = ["Michael", "Lieberman"]
		# Add your function here

		def join_strings(words):
		    result = ""
		    for i in range(0, len(words)):
			result = result + words[i]
		    return result

		print join_strings(n)

#[Dictionary]

	'''
	A dictionary is similar to a list, but you access values by looking up a key instead
	of an index. A key can be any string or number. Dictionaries are enclosed in
	curly braces, like so:
	'''

	d = {'key1' : 1, 'key2' : 2, 'key3' : 3}

	'''
	This is a dictionary called d with three key-value pairs. The key 'key1' points to the
	value 1, 'key2' to 2, and so on.

	Dictionaries are great for things like phone books (pairing a name with a phone number),
	login pages (pairing an e-mail address with a username), and more!
	'''

	#[Assigning a dictionary with three key-value pairs to residents]

		residents = {'Puffin' : 104, 'Sloth' : 105, 'Burmese Python' : 106}

		print residents['Puffin'] # Prints Puffin's room number

		# Your code here!
		print residents['Sloth']
		print residents['Burmese Python']

	#[Adding New entries]

		'''
		An empty pair of curly braces {} is an empty dictionary, just like an empty pair of []
		is an empty list.
		'''

		menu = {} # Empty dictionary
		menu['Chicken Alfredo'] = 14.50 # Adding new key-value pair
		print menu['Chicken Alfredo']

		# Your code here: Add some dish-price pairs to menu!
		menu['Letuce Sandwich'] = 3.50
		menu['Mango Juice'] = 12.70
		menu['Sweet Corn + Chat Masala'] = 1.80

		print "There are " + str(len(menu)) + " items on the menu."
		print menu

	#[Add & Delete]

		'''
		Because dictionaries are mutable, they can be changed in many ways. Items can be removed
		from a dictionary with the del command:
		'''

		del dict_name[key_name]

		'''
		will remove the key key_name and its associated value from the dictionary.

		A new value can be associated with a key by assigning a value to the key, like so:
		'''

		dict_name[key] = new_value

	#[Retrieve key and value]

		knights = {'gallahad': 'the pure', 'robin': 'the brave'}
		for k, v in knights.iteritems():
			print k, v

		''' Prints the key and the value '''
		gallahad the pure
		robin the brave

	#[Lists and Dictionaries]

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

	#[Looping in dictionaries]
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

	#[More Looping techniques]
		'''
		To loop over two or more sequences at the same time, the
		entries can be paired with the zip() function.
		'''
		questions = ['name', 'quest', 'favorite color']
		answers = ['lancelot', 'the holy grail', 'blue']
		for q, a in zip(questions, answers):
			print 'What is your {0}?  It is {1}.'.format(q, a)

	#[List of Dictionaries]
		'''
		Iterating over a list of dictionaries
		'''
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

	#[Iterate over both keys and values]

		>>> D = {'a': 1, 'b': 2, 'c': 3}
		>>> for key in D:
			print(key, '=>', D[key]) # Use dict keys iterator and index

		a => 1
		c => 3
		b => 2

		>>> list(D.items())
		[('a', 1), ('c', 3), ('b', 2)]
		>>> for (key, value) in D.items():
			print(key, '=>', value)		# Iterate over both keys and values

		a => 1
		c => 3
		b => 2

