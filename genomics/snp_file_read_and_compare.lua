-- set the input file
inputfilename1 = "James_SNPs_exported_Geno2.csv"
--~ inputfilename2 = "James_SNPs_exported_23andme.csv"
--~ inputfilename3 = "James_SNPs_exported_AncestryDNA.csv"
--~ inputfilename4 = "James_SNPs_exported_FTDNA.csv"
inputfilename5 = "James_SNPs_exported_SeqDotCom.csv"

--~ input file Field Labels = "SNP_prefix,SNP_suffix,Chr,Pos,Allele1,Allele2,Zygosity,23andme,AncestryDNA,FTDNA,Geno2,SeqDotCom\n"
--~ input file Field Variable Labels = SNP_prefix..","..SNP_suffix..","..Chrid..","..Position..","..Allele1..","..Allele2..","..Zygosity..","..SNPs23andme..","..SNPsAncestry..","..SNPsFTDNA..","..SNPsGeno2..","..SNPsSeqDotCom.."\n"
-- set the output file names
outputfilename1 = "SNP_matches_test"
outputfilename2 = "SNP_nonmatches_test"
-- open the output files
f_1 = io.open(outputfilename1, "a")
--~ f_2 = io.open(outputfilename2, "a")
-- global variables
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

-- comma ',' delimited field splitter
    function fromCSV2 (source2)
		-- ending comma
		source2 = source2 .. ','
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
				fieldstart = string.find(source2, ',', i) + 1
			else
		-- unquoted; find next comma
				local nexti = string.find(source2, ',', fieldstart)
				table.insert(table2, string.sub(source2, fieldstart, nexti-1))
				fieldstart = nexti + 1
			end
		until fieldstart > string.len(source2)
		return table2
    end

-- read data from first file
for line in io.lines(inputfilename1)
	do
-- apply fromCSV function to each line
	table1 = fromCSV1(line)

-- populate variables from table
	SNP_prefix_A = 	table1[1]
	if SNP_prefix_A == nil then
		SNP_prefix_A = " "
	end
	SNP_suffix_A = 	table1[2]
	if SNP_suffix_A == nil then
		SNP_suffix_A = " "
	end
	Chr_A = 	table1[3]
	if Chr_A == nil then
		Chr_A = " "
	end
	Pos_A = 	table1[4]
	if Pos_A == nil then
		Pos_A = " "
	end
	Allele1_A =	table1[5]
	if Allele1_A == nil then
		Allele1_A = " "
	end
	Allele2_A = table1[6]
	if Allele2_A == nil then
		Allele2_A = " "
	end
	Zygosity_A = table1[7]
	if Zygosity_A == nil then
		Zygosity_A = " "
	end
	SNPs23andme_A = table1[8]
	if SNPs23andme_A == nil then
		SNPs23andme_A = " "
	end
	SNPsAncestry_A = table1[9]
	if SNPsAncestry_A == nil then
		SNPsAncestry_A = " "
	end
	SNPsFTDNA_A = table1[10]
	if SNPsFTDNA_A == nil then
		SNPsFTDNA_A = " "
	end
	SNPsGeno2_A = table1[11]
	if SNPsGeno2_A == nil then
		SNPsGeno2_A = " "
	end
	SNPsSeqDotCom_A = table1[12]
	if SNPsSeqDotCom_A == nil then
		SNPsSeqDotCom_A = " "
	end
-- set local variables
	SNP_prefix = SNP_prefix_A
	SNP_suffix = SNP_suffix_A
	Chrid = Chr_A
	Position = Pos_A
	Allele1 = Allele1_A
	Allele2 = Allele2_A
	Zygosity = Zygosity_A
	SNPs23andme= SNPs23andme_A
	SNPsAncestry = SNPsAncestry_A
	SNPsFTDNA = SNPsFTDNA_A
	SNPsGeno2 = SNPsGeno2_A
	SNPsSeqDotCom = SNPsSeqDotCom_A

	testcomment = (string.find(SNP_prefix, "SNP_prefix"))
-- prepend all files with commented lines
	if testcomment ~= nil then
		print("found: "..line.."\n")
		m_c = line.."\n"
		f_1:write(m_c)
	end

-- read data from second file
	for line in io.lines(inputfilename5)
		do
	-- apply fromCSV function to each line
		table2 = fromCSV2(line)

	-- populate variables from table
		SNP_prefix_B = 	table2[1]
		if SNP_prefix_B == nil then
			SNP_prefix_B = " "
		end
		SNP_suffix_B = 	table2[2]
		if SNP_suffix_B == nil then
			SNP_suffix_B = " "
		end
		Chr_B = 	table2[3]
		if Chr_B == nil then
			Chr_B = " "
		end
		Pos_B = 	table2[4]
		if Pos_B == nil then
			Pos_B = " "
		end
		Allele1_B =	table2[5]
		if Allele1_B == nil then
			Allele1_B = " "
		end
		Allele2_B = table2[6]
		if Allele2_B == nil then
			Allele2_B = " "
		end
		Zygosity_B = table2[7]
		if Zygosity_B == nil then
			Zygosity_B = " "
		end
		SNPs23andme_B = table2[8]
		if SNPs23andme_B == nil then
			SNPs23andme_B = " "
		end
		SNPsAncestry_B = table2[9]
		if SNPsAncestry_B == nil then
			SNPsAncestry_B = " "
		end
		SNPsFTDNA_B = table2[10]
		if SNPsFTDNA_B == nil then
			SNPsFTDNA_B = " "
		end
		SNPsGeno2_B = table2[11]
		if SNPsGeno2_B == nil then
			SNPsGeno2_B = " "
		end
		SNPsSeqDotCom_B = table2[12]
		if SNPsSeqDotCom_B == nil then
			SNPsSeqDotCom_B = " "
		end

		if SNP_prefix_A == SNP_prefix_B then
			if SNP_suffix_A == SNP_suffix_B then
				SNPsSeqDotCom = SNPsSeqDotCom_B
				print("found: "..SNP_prefix..","..SNP_suffix..","..Chrid..","..Position..","..Allele1..","..Allele2..","..Zygosity..","..SNPs23andme..","..SNPsAncestry..","..SNPsFTDNA..","..SNPsGeno2..","..SNPsSeqDotCom.."\n")
				m_2 = SNP_prefix..","..SNP_suffix..","..Chrid..","..Position..","..Allele1..","..Allele2..","..Zygosity..","..SNPs23andme..","..SNPsAncestry..","..SNPsFTDNA..","..SNPsGeno2..","..SNPsSeqDotCom.."\n"
				f_1:write(m_2)
			end
		end
	end
end
-- close file output
io.close(f_1)


