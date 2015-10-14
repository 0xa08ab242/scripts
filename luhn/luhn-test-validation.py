# Luhn Test of Credit Card Numbers
import sys
#
# TODO:
# adjust file output to create a new file (overwrite existing) and add results
#
# Luhn Test function
#
# I tried a few different ways, but eventually I borrowed the core function
# from the Python example in rosettacode.org 
# http://rosettacode.org/wiki/Luhn_test_of_credit_card_numbers#Python
#
def luhn_test(line):
	line_out = line.rstrip()
	reverse = [int(character) for character in str(line_out)][::-1]
	return (sum(reverse[0::2]) + sum(sum(divmod(digit*2,10)) for digit in reverse[1::2])) % 10 == 0
#
# Main loop
#
# open file and assign file handle
with open('CreditCard-input.txt') as fileHandleIn:
# split into per line feed
	for line in fileHandleIn:
# call the function and direct its output
		fileHandleOut = open('CreditCard_validation_results.txt', 'a')
		sys.stdout = fileHandleOut
		print luhn_test(line), int(line.rstrip())
		sys.stdout = sys.__stdout__
		fileHandleOut.close()
# EOF