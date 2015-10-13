#!C:\Python27\python.exe
# README - General comments and instructions
#
# This template assumes the use of Python 2 on Windows
# Project Euler Problem Solving Programs
# Problem 001
#	If we list all the natural numbers below 10 that are multiples of 3 or 5, we get 3, 5, 6 and 9. 
#	The sum of these multiples is 23.
#	Find the sum of all the multiples of 3 or 5 below 1000.
#
#	My approach to this is to use several loops to iterate through the multiples.
#  Sum the sums of the multiples of 3 with the multiples of 5.
#  Then, subtract the multiples of (3*5) to remove the duplicates.
#  The remaining value should be the correct one.
#
# SAMPLE OUTPUT FROM THIS PROGRAM TO DEMONSTRATE IT PRODUCE THE CORRECT REFERENCE DATA
#The value of sum_of_multiple for 3 is 18
#The value of sum_of_multiple for 5 is 5
#The value of sum_of_multiple for 15 is 0
#The final value is 23
#END OF LINE
#
# SAMPLE OUTPUT FROM THIS PROGRAM TO DEMONSTRATE THE INTENDED OUTPUT DATA
#The value of sum_of_multiple for 3 is 166833
#The value of sum_of_multiple for 5 is 99500
#The value of sum_of_multiple for 15 is 33165
#The final value is 233168
#END OF LINE
#
# Python Module Dependencies (--max-depth = 1) | (alphabetized)
# none needed
#
# Constants and variable initialization
#
first_number = 3
loop_limit = 1000
second_number = 5
sum_of_multiple = 0
number_product = first_number * second_number
# Runtime Execution Logic
def sum_multiples_of_number(number_in):
	decrementor = number_in
	iterator = 0
	global sum_of_multiple
	sum_of_multiple = 0
	while (iterator < (loop_limit - decrementor)):
		iterator = (iterator + decrementor)
		sum_of_multiple = sum_of_multiple + iterator
	print "The value of sum_of_multiple for %s is %s." % (number_in, sum_of_multiple)
	return sum_of_multiple
# calculate, print, and store the value for the first number
sum_multiples_of_number(first_number)
multiple_total_for_first_number = sum_of_multiple
# calculate, print, and store the value for the second number
sum_multiples_of_number(second_number)
multiple_total_for_second_number = sum_of_multiple
# calculate, print, and store the value for the product of the 1st & 2nd numbers
sum_multiples_of_number(number_product)
multiple_total_for_third_number = sum_of_multiple
# use the stored values to derive and print the final value
final_value = multiple_total_for_first_number + multiple_total_for_second_number - multiple_total_for_third_number
print "The final value is %s.\n" % (final_value)
print "END OF LINE"