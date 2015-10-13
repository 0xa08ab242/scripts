#!C:\Ruby22-x64\bin\ruby.exe
#
# README - General comments and instructions
#
# This template assumes the use of Ruby 2 on Windows
# Project Euler Problem Solving Programs
# Problem 001
#	If we list all the natural numbers below 10 that are multiples of 3 or 5, we get 3, 5, 6 and 9. 
#	The sum of these multiples is 23.
#	Find the sum of all the multiples of 3 or 5 below 1000.
#
#	My approach to this is to use several loops to iterate through the multiples.
#	Sum the sums of the multiples of 3 with the multiples of 5.
#	Then, subtract the multiples of (3*5) to remove the duplicates.
# The remaining value should be the correct one.
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
# Ruby Module Dependencies (--max-depth = 1) | (alphabetized)
#	none needed
# Constants and variable initialization
#
first_number = 3
second_number = 5
loop_limit = 1000
number_product = first_number * second_number
# Runtime Execution Logic
## I had problems getting a single subroutine to work, reverting to bloated way
## using 3 separate loops; need to review variable passing to/from functions
#loop 1
iterator_1 = 0
decrementor_1 = first_number
sum_of_multiple_1 = 0
while (iterator_1 < loop_limit - decrementor_1)
	iterator_1 = iterator_1 + decrementor_1
	sum_of_multiple_1 = sum_of_multiple_1 + iterator_1
end
puts "The value of sum_of_multiple for #{first_number} is #{sum_of_multiple_1}."
#loop 2
iterator_2 = 0
decrementor_2 = second_number
sum_of_multiple_2 = 0
while (iterator_2 < loop_limit - decrementor_2)
	iterator_2 = iterator_2 + decrementor_2
	sum_of_multiple_2 = sum_of_multiple_2 + iterator_2
end
puts "The value of sum_of_multiple for #{second_number} is #{sum_of_multiple_2}."
#loop 3
iterator_3 = 0
decrementor_3 = number_product
sum_of_multiple_3 = 0
while (iterator_3 < loop_limit - decrementor_3)
	iterator_3 = iterator_3 + decrementor_3
	sum_of_multiple_3 = sum_of_multiple_3 + iterator_3
end
puts "The value of sum_of_multiple for #{number_product} is #{sum_of_multiple_3}."
# calculate sum of the first two outputs less that of their product
final_value = sum_of_multiple_1 + sum_of_multiple_2 - sum_of_multiple_3
puts "The final value is #{final_value}."
puts "END OF LINE"
