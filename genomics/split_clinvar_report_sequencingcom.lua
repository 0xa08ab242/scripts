-- file output
outputfilename = "clinvar_rsids_and_alleles.csv"
f_1 = io.open(outputfilename, "a")
m_1 = "SNP_RSid,Chr,Pos,Allele1,Allele2,Zygosity\n"
f_1:write(m_1)
-- TODO: sort output by starting position

-- global functions

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

-- input5 sequencing.com clinvar report format
for line in io.lines("55001608268385A-ClinVar-Report-SequencingCom.csv")
	do
	testcomment = (string.find(line, "#"))
if testcomment == nil then


-- apply fromCSV function to each line
	table2 = fromCSV2(line)

-- populate variables from table
	local Chrid =  table2[1]
		if Chrid == nil then
		Chrid = " "
		end
	local Position =  table2[2]
		if Position == nil then
		Position = " "
		end
	local SNPid = table2[3]
		if SNPid == nil then
		SNPid = " "
		end
	local RefAllele = string.char(string.byte(table2[4], 1))
		if RefAllele == nil then
		RefAllele = " "
		end
	local AltAllele = string.char(string.byte(table2[5], 1))
		if AltAllele == nil then
		AltAllele = " "
		end
	local Zygos = table2[8]
		if Zygos == nil then
		Zygos = " "
		end

	if string.find(Zygos,"Het") then
		local Allele1 = RefAllele
		local Allele2 = AltAllele
		local Zygosity = "Heterozygous"
		print("found: "..SNPid..","..Chrid..","..Position..","..Allele1..","..Allele2..","..Zygosity.."\n")
		m_3 = SNPid..","..Chrid..","..Position..","..Allele1..","..Allele2..","..Zygosity.."\n"
		f_1:write(m_3)
		elseif string.find(Zygos,"Hom") then
		local Allele1 = RefAllele
		local Allele2 = RefAllele
		local Zygosity = "Homozygous"
		print("found: "..SNPid..","..Chrid..","..Position..","..Allele1..","..Allele2..","..Zygosity.."\n")
		m_3 = SNPid..","..Chrid..","..Position..","..Allele1..","..Allele2..","..Zygosity.."\n"
		f_1:write(m_3)
	end
end
end

-- close file output
io.close(f_1)
