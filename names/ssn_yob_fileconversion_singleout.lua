year_to_start=1879
year_to_stop=2017
first_year=year_to_start +1
last_year=year_to_stop
-- file output
outputfilename = "ssn_names_"..first_year.."-thru-"..last_year.."_byyear_byrank_byalpha.csv"
f_1 = io.open(outputfilename, "a")
m_1 = "BirthYear,GivenName,Gender,NameCount\n"
f_1:write(m_1)

-- global functions
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

-- file input
--	auto closes when complete
yearcounter=year_to_start
while yearcounter<year_to_stop
	do
	yearcounter = yearcounter + 1
	inputfilename = "yob"..yearcounter..".txt"

	local BirthYear = yearcounter
		if BirthYear == nil then
		BirthYear = " "
		end
	for line in io.lines(inputfilename)
		do
-- apply fromCSV function to each line
	table1 = fromCSV1(line)
-- populate variables from table
	local GivenName = 		table1[1]
		if GivenName == nil then
		GivenName = " "
		end
	local Gender = 		table1[2]
		if Gender == nil then
		Gender = " "
		end
	local AnnualNameCount = 	table1[3]
		if AnnualNameCount == nil then
		AnnualNameCount = " "
		end
-- write out results
	if (GivenName ~= " ") then
		m_2 = BirthYear..","..GivenName..","..Gender..","..AnnualNameCount.."\n"
		f_1:write(m_2)
	end

end
end
io.close(f_1)

