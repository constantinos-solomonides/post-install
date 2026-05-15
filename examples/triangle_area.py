<<<<<<< HEAD
#!/usr/bin/python3
||||||| ce5242d
=======
#!/usr/bin/env python3
>>>>>>> branch_a
# Python Program to find the area of triangle

<<<<<<< HEAD
a = 6
b = 7
c = 8
||||||| ce5242d
a = 5
b = 6
c = 7

# Uncomment below to take inputs from the user
# a = float(input('Enter first side: '))
# b = float(input('Enter second side: '))
# c = float(input('Enter third side: '))
=======
a = 5
b = 6
c = 9

# Uncomment below to take inputs from the user
# a = float(input('Enter first side: '))
# b = float(input('Enter second side: '))
c = float(input('Enter third side: '))
>>>>>>> branch_a

# calculate the semi-perimeter
s = (a + b + c) / 2

# calculate the area
# Use the previous values to do so
area = (s*(s-a)*(s-b)*(s-c)) ** 0.5
print('The area of the triangle is %0.2f' %area)
