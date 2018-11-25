-- set the input file
inputfilename = "james_plus_inferred_from_parents_sorted.csv"

-- file output
outputfilename1 = "genome_James_Pittman_v3_Full_20181001100110.txt"
f_1 = io.open(outputfilename1, "a")
m_0 = "# replace this string with usual 23andm3 v3 header text and append Y chromosome values for males\n"
f_1:write(m_0)

m_1 = "# rsid\tchromosome\tposition\tgenotype\n"
f_1:write(m_1)

-- TODO: sort output by starting position

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

-- tab '\t' delimited field splitter
    function fromCSV2 (source2)
		-- ending semicolon
		source2 = source2 .. '\t'
		-- table to collect fields
		local table2 = {}
		local fieldstart = 1
		repeat
		-- next field is quoted? (start with `"'?)
			if string.find(source2, '^"', fieldstart) then
				local a, c
				local i  = fieldstart
				repeat
		-- find closing quote
					a, i, c = string.find(source2, '"("?)', i+1)
		-- quote not followed by quote?
				until c ~= '"'
				if not i then
					error('unmatched "')
				end
				local f = string.sub(source2, fieldstart+1, i-1)
				table.insert(table2, (string.gsub(f, '""', '"')))
				fieldstart = string.find(source2, '\t', i) + 1
			else
		-- unquoted; find next semicolon
				local nexti = string.find(source2, '\t', fieldstart)
				table.insert(table2, string.sub(source2, fieldstart, nexti-1))
				fieldstart = nexti + 1
			end
		until fieldstart > string.len(source2)
		return table2
    end

-- file input
--	auto closes when complete
--	need to modify for command line input option

-- input csv export

for line in io.lines(inputfilename)
	do

	testcomment = (string.find(line, "snp_pre"))
if testcomment == nil then
-- apply fromCSV function to each line
	table1 = fromCSV1(line)

-- populate variables from table
	local SNP_prefix = 	table1[1]
		if SNP_prefix == nil then
		SNP_prefix = " "
		end
	local SNP_suffix = 	table1[2]
		if SNP_suffix == nil then
		SNP_suffix = " "
		end
	local Chrid = 	table1[3]
		if Chrid == nil then
		Chrid = " "
		end
	local Position = 	table1[4]
		if Position == nil then
		Position = " "
		end
	local Allele1 =	table1[5]
		if Allele1 == nil then
		Allele1 = " "
		end
	local Allele2 = table1[6]
		if Allele2 == nil then
		Allele2 = " "
		end
	local Zygosity = table1[7]
		if Zygosity == nil then
		Zygosity = " "
		end
	local SNPs23andme = table1[8]
		if SNPs23andme == nil then
		SNPs23andme = " "
		end
	local SNPsAncestry = table1[9]
		if SNPsAncestry == nil then
		SNPsAncestry = " "
		end
	local SNPsFTDNA = table1[10]
		if SNPsFTDNA == nil then
		SNPsFTDNA = " "
		end
	local SNPsGeno2 = table1[11]
		if SNPsGeno2 == nil then
		SNPsGeno2 = " "
		end
	local SNPsSeqDotCom = table1[12]
		if SNPsSeqDotCom == nil then
		SNPsSeqDotCom = " "
		end

	local rsid = SNP_prefix..SNP_suffix
		if rsid == nil then
		rsid = " "
		end

	local genotype = Allele1..Allele2
		if genotype == nil then
		genotype = " "
		end

	print("found: "..rsid.."\t"..Chrid.."\t"..Position.."\t"..genotype.."\n")
	m_2 = rsid.."\t"..Chrid.."\t"..Position.."\t"..genotype.."\n"
	f_1:write(m_2)
end
end

-- close file output
io.close(f_1)
