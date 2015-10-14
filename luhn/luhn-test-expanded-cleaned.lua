-- Luhn Test of Credit Card Numbers
--
-- file output
-- set the output file name
outputfilename = "LuhnTestResults.csv"
-- open the output file
f_1 = io.open(outputfilename, "a")
-- set the value of the output header
outputheader = "Tested Number, Test Results\n"
-- write the contents of the output header to the file
f_1:write(outputheader)
-- Luhn Test
function luhn(numbertotest)
	length=string.len(numbertotest)
	r=string.reverse(numbertotest)
	local sumodd=0
	for i=1,r:len(),2 do
		sumodd=sumodd+r:sub(i,i)
	end
	local sumeven=0
	for i=2,r:len(),2 do
		local doubled=r:sub(i,i)*2
		doubled=string.gsub(doubled,'(%d)(%d)',function(a,b)return a+b end)
		sumeven=sumeven+doubled
	end
	local total=sumodd+sumeven
	t2 = total%10
	if t2==0 then
		testresult = "Valid Credit Card Number"
		outputentry0 = numbertotest..", "..testresult.."\n"
		f_1:write(outputentry0)
		return true
	end
		testresult = "Invalid Credit Card Number"
		outputentry1 = numbertotest..", "..testresult.."\n"
		f_1:write(outputentry1)
	return false
end
-- file input
for line in io.lines("CreditCard-input.txt")
	do local testresultbool = luhn(line)
end
-- close file output
io.close(f_1)
