year_to_start=1879
year_to_stop=2017
first_year=year_to_start +1
last_year=year_to_stop

-- search GivenName
nametofind = "James"
namelength = string.len (nametofind)
nametofind = string.gsub (nametofind, "%f[%a]%u+%f[%A]", string.lower)

-- search Gender
gendertofind = "f"
gendertofind = string.gsub (gendertofind, "%f[%a]%u+%f[%A]", string.lower)

-- file input
inputfilename = "ssn_names_"..first_year.."-thru-"..last_year.."_byyear_byrank_byalpha.csv"

-- file output
outputfilename = "ssn_namesearch_"..nametofind.."_with_gender_"..gendertofind..".csv"
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
for line in io.lines(inputfilename)
	do
-- apply fromCSV function to each line
	table1 = fromCSV1(line)
-- populate variables from table
	local BirthYear = 		table1[1]
		if BirthYear == nil then
		BirthYear = " "
		end
	local GivenName = 		table1[2]
		if GivenName == nil then
		GivenName = " "
		end
	local Gender = 		table1[3]
		if Gender == nil then
		Gender = " "
		end
	local AnnualNameCount = 	table1[4]
		if AnnualNameCount == nil then
		AnnualNameCount = " "
		end
-- search criteria
	local namesearch = string.gsub (GivenName, "%f[%a]%u+%f[%A]", string.lower)
	local testname = (string.find(namesearch, nametofind))
	local gendersearch = string.gsub (Gender, "%f[%a]%u+%f[%A]", string.lower)
	local testgender = (string.find(gendersearch, gendertofind))
	local length_of_name = string.len (namesearch)
-- write out results
	if (testname ~= nil) and (testgender ~=nil) and (namelength == length_of_name) then
		m_2 = BirthYear..","..GivenName..","..Gender..","..AnnualNameCount.."\n"
		f_1:write(m_2)
	end
end
io.close(f_1)

