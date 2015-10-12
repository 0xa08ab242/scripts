--
-- README - General comments and instructions
--
-- This template assumes the use of Lua for Windows Windows
-- Project Euler Problem Solving Programs
-- Problem 001
--	If we list all the natural numbers below 10 that are multiples of 3 or 5, we get 3, 5, 6 and 9.
--	The sum of these multiples is 23.
--	Find the sum of all the multiples of 3 or 5 below 1000.
--
--	My approach to this is to use several loops to iterate through the multiples.
--  Sum the sums of the multiples of 3 with the multiples of 5.
--  Then, subtract the multiples of (3*5) to remove the duplicates.
-- The remaining value should be the correct one.
--
-- SAMPLE OUTPUT FROM THIS PROGRAM TO DEMONSTRATE IT PRODUCE THE CORRECT REFERENCE DATA
--The value of sum_of_multiple for 3 is 18
--The value of sum_of_multiple for 5 is 5
--The value of sum_of_multiple for 15 is 0
--The final value is 23
--END OF LINE
--
-- SAMPLE OUTPUT FROM THIS PROGRAM TO DEMONSTRATE THE INTENDED OUTPUT DATA
--The value of sum_of_multiple for 3 is 166833
--The value of sum_of_multiple for 5 is 99500
--The value of sum_of_multiple for 15 is 33165
--The final value is 233168
--END OF LINE
--
-- Constants and configuration information
--
--	REVIEW IT
first_number = 3
loop_limit = 1000
second_number = 5
sum_of_multiple = 0
sum_of_sums = 3
--
-- Variables declaration, initialization, etc.
--
number = second_number
number_product = first_number * second_number
--
-- Runtime Execution Logic
--
-- global functions
--
-- Subroutines
-- Define subroutines and functions not part of the MAIN program loop here
--
-- sum_multiples_of_number
	function sum_multiples_of_number (number_in)
	local decrementor = number_in
	local iterator = 0
	sum_of_multiple = 0
	while (iterator < loop_limit - decrementor) do
		iterator = (iterator + decrementor)
		sum_of_multiple = sum_of_multiple + iterator
	end
	return sum_of_multiple
	end
--
-- comma ',' delimited field splitter
    function fromCSV1 (source1)
		-- ending comma
		source1 = source1 .. ','
		-- table to collect fields
		local table1 = {}
		local fieldstart = 1
		repeat
		-- next field is quoted? (start with `"'?)
			if string.find(source1, '^"', fieldstart) then
				local a, c
				local i  = fieldstart
				repeat
		-- find closing quote
					a, i, c = string.find(source1, '"("?)', i+1)
		-- quote not followed by quote?
				until c ~= '"'
				if not i then
					error('unmatched "')
				end
				local f = string.sub(source1, fieldstart+1, i-1)
				table.insert(table1, (string.gsub(f, '""', '"')))
				fieldstart = string.find(source1, ',', i) + 1
			else
		-- unquoted; find next comma
				local nexti = string.find(source1, ',', fieldstart)
				table.insert(table1, string.sub(source1, fieldstart, nexti-1))
				fieldstart = nexti + 1
			end
		until fieldstart > string.len(source1)
		return table1
    end
--
-- calculate and store the value for the first number
sum_multiples_of_number(first_number)
print("The value of sum_of_multiple for "..first_number.." is ")
print(sum_of_multiple.."\n")
multiple_total_for_first_number = sum_of_multiple
-- calculate and store the value for the second number
sum_multiples_of_number(second_number)
print("The value of sum_of_multiple for "..second_number.." is ")
print(sum_of_multiple.."\n")
multiple_total_for_second_number = sum_of_multiple
-- calculate and store the value for the product of the first and second numbers
sum_multiples_of_number(number_product)
print("The value of sum_of_multiple for "..number_product.." is ")
print(sum_of_multiple.."\n")
multiple_total_for_third_number = sum_of_multiple
-- combine the output of the three prior steps and report it to the console
final_value = multiple_total_for_first_number + multiple_total_for_second_number - multiple_total_for_third_number
print("The final value is "..final_value.."\n.")
--
print("END OF LINE\n")
--
