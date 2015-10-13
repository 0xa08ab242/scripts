#!C:\Strawberry\perl\bin\perl.exe
########################################################################################
# README - General comments and instructions
########################################################################################
# This template assumes the use of Strawberry perl on Microsoft Windows
# Project Euler Problem Solving Programs
# Problem 001
#	If we list all the natural numbers below 10 that are multiples of 3 or 5, we get 3, 5, 6 and 9. 
#	The sum of these multiples is 23.
#	Find the sum of all the multiples of 3 or 5 below 1000.
#
#	My approach to this is to use several loops to iterate through the multiples.
#  Sum the sums of the multiples of 3 with the multiples of 5.
#  Then, subtract the multiples of (3*5) to remove the duplicates.
# The remaining value should be the correct one.
##
# SAMPLE OUTPUT FROM THIS PROGRAM TO DEMONSTRATE IT PRODUCE THE CORRECT REFERENCE DATA
#The value of sum_of_multiple for 3 is 18
#The value of sum_of_multiple for 5 is 5
#The value of sum_of_multiple for 15 is 0
#The final value is 23
#END OF LINE
#
##
# SAMPLE OUTPUT FROM THIS PROGRAM TO DEMONSTRATE THE INTENDED OUTPUT DATA
#The value of sum_of_multiple for 3 is 166833
#The value of sum_of_multiple for 5 is 99500
#The value of sum_of_multiple for 15 is 33165
#The final value is 233168
#END OF LINE
#
########################################################################################

########################################################################################
# Perl Module Dependencies (--max-depth = 1) | (alphabetized)
########################################################################################
use Carp;
use diagnostics;
use strict;
use warnings;

########################################################################################
# Constants and variable initialization
########################################################################################
my $first_number = 3;
my $loop_limit = 1000;
my $second_number = 5;
my $sum_of_multiple = 0;
my $number_product = $first_number * $second_number;
$SIG{INT}					= \&graceful_close ;
$SIG{QUIT}					= \&graceful_close ;
$SIG{HUP}					= \&graceful_close ;

########################################################################################
# Runtime Execution Logic
########################################################################################
# calculate and store the value for the first number
sum_multiples_of_number($first_number);
print "The value of sum_of_multiple for " . $first_number ." is ";
print $sum_of_multiple . ".\n";
my $multiple_total_for_first_number = $sum_of_multiple;
# calculate and store the value for the second number
sum_multiples_of_number($second_number);
print "The value of sum_of_multiple for " . $second_number ." is ";
print $sum_of_multiple . ".\n";
my $multiple_total_for_second_number = $sum_of_multiple;
# calculate and store the value for the product of the first and second numbers
sum_multiples_of_number($number_product);
print "The value of sum_of_multiple for " . $number_product ." is ";
print $sum_of_multiple . ".\n";
my $multiple_total_for_third_number = $sum_of_multiple;
# combine the output of the three prior steps and report it to the console
my $final_value = $multiple_total_for_first_number + $multiple_total_for_second_number - $multiple_total_for_third_number;
print "The final value is " . $final_value . ".\n";

print "END OF LINE";
exit 0;

########################################################################################
# Subroutines
# Define subroutines and functions not part of the MAIN program loop here
########################################################################################
sub sum_multiples_of_number {
	my $input = shift @_;
	my $iterator = 0;
	$sum_of_multiple = 0;
	while ($iterator < ($loop_limit - $input)) {
		$iterator = ($iterator + $input);
		$sum_of_multiple = $sum_of_multiple + $iterator;
	}
	return $sum_of_multiple;
}
########################################################################################
# Press CTRL-C to Close the program, if it gets stuck.
sub graceful_close {
	print "In Graceful Close...\n"; 
	exit 0;
}
########################################################################################