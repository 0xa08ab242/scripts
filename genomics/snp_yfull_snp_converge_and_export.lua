-- work in progress, output is broken
--
-- file output
outputfilename4 = "James_SNPs_yfull_exported_as_FTDNA.csv"
f_4 = io.open(outputfilename4, "a")

m_1 = "SNP_prefix,SNP_suffix,Chr,Pos,Allele1,Allele2,Zygosity,23andme,AncestryDNA,FTDNA,Geno2,SeqDotCom\n"
f_4:write(m_1)

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

-- pipe '|' delimited field splitter
    function fromCSV3 (source3)
		-- ending semicolon
		source3 = source3 .. '|'
		-- table to collect fields
		local table3 = {}
		local fieldstart = 1
		repeat
		-- next field is quoted? (start with `"'?)
			if string.find(source3, '^"', fieldstart) then
				local a, c
				local i  = fieldstart
				repeat
		-- find closing quote
					a, i, c = string.find(source3, '"("?)', i+1)
		-- quote not followed by quote?
				until c ~= '"'
				if not i then
					error('unmatched "')
				end
				local f = string.sub(source3, fieldstart+1, i-1)
				table.insert(table3, (string.gsub(f, '""', '"')))
				fieldstart = string.find(source3, '|', i) + 1
			else
		-- unquoted; find next semicolon
				local nexti = string.find(source3, '|', fieldstart)
				table.insert(table3, string.sub(source3, fieldstart, nexti-1))
				fieldstart = nexti + 1
			end
		until fieldstart > string.len(source3)
		return table3
    end

-- file input
--	auto closes when complete
--	need to modify for command line input option

-- input YFULL SNPs CSV and Output in FTDNA export format
for line in io.lines("SNP_for_YF08375_20180911.csv")
	do
	testcomment = (string.find(line, "#"))
if testcomment == nil then
-- set test name
	local test_name = "YFULL"

-- apply fromCSV function to each line
	table1 = fromCSV1(line)

-- populate variables from table
--~ may need to split SNPid
	local SNP = string.upper(table1[1])
		if SNP == nil then
		SNP = " "
		end
	local Allele1 =  table1[2]
		if Allele1 == nil then
		Allele1 = " "
		end
--~ need to split reads
	local Reads =  table1[3]
		if Reads == nil then
		Reads = " "
		end

	local Quality = (table1[4])
		if Quality == nil then
		Quality = " "
		end

	tablereads = fromCSV3(Reads)
	local SNPReads =	table1[1]
	if SNPReads == nil then
		SNPReads = " "
	end
	local Readcomment =	table1[2]
	if Readcomment == nil then
		Readcomment = " "
	end

	local Chrid = "Y"
	local Position = " "
	local Allele2 = "-"

	if string.find(Allele1,"-") then
		Zygosity = "No Call"

	elseif string.find(Allele1, "1") then
		Zygosity = "Haploid"
	end

	local SNPs23andme = " "
	local SNPsAncestry = " "
	local SNPsFTDNA = Allele1..Allele2
	local SNPsGeno2 = " "
	local SNPsSeqDotCom = " "

	print("found: "..SNP.."\t Reads:"..SNPReads.."\t Quality:"..Quality.."\n")


	if string.find(SNP,"|") ~= nil then
		table3 = fromCSV3(SNP)
		SNPid1 =table3[1]
		if SNPid1 == nil then
		SNPid1 = "null"
		else
			local SNPid = SNPid1
			local snp_suffix_stop = string.len(SNPid)
			local snp_prefix_test = string.len(SNPid)

			while snp_prefix_test > 0 do
				if string.byte(SNPid,snp_prefix_test) < 64 then
					snp_prefix_test = snp_prefix_test - 1
				else
					snp_prefix_stop = snp_prefix_test
					snp_suffix_start = snp_prefix_stop + 1
					snp_prefix_test = 0
				end
			end

			local snp_prefix = string.sub(SNPid,1,snp_prefix_stop)
			local snp_suffix = string.sub(SNPid,snp_suffix_start,snp_suffix_stop)

			print("found: "..snp_prefix..","..snp_suffix..","..Chrid..","..Position..","..Allele1..","..Allele2..","..Zygosity..","..SNPs23andme..","..SNPsAncestry..","..SNPsFTDNA..","..SNPsGeno2..","..SNPsSeqDotCom.."\n")
			m_5 = snp_prefix..","..snp_suffix..","..Chrid..","..Position..","..Allele1..","..Allele2..","..Zygosity..","..SNPs23andme..","..SNPsAncestry..","..SNPsFTDNA..","..SNPsGeno2..","..SNPsSeqDotCom.."\n"
			f_4:write(m_5)
		end
		SNPid2 =table3[2]
		if SNPid2 == nil then
		SNPid2 = "null"
		else
			local SNPid = SNPid2
			local snp_suffix_stop = string.len(SNPid)
			local snp_prefix_test = string.len(SNPid)

			while snp_prefix_test > 0 do
				if string.byte(SNPid,snp_prefix_test) < 64 then
					snp_prefix_test = snp_prefix_test - 1
				else
					snp_prefix_stop = snp_prefix_test
					snp_suffix_start = snp_prefix_stop + 1
					snp_prefix_test = 0
				end
			end

			local snp_prefix = string.sub(SNPid,1,snp_prefix_stop)
			local snp_suffix = string.sub(SNPid,snp_suffix_start,snp_suffix_stop)

			print("found: "..snp_prefix..","..snp_suffix..","..Chrid..","..Position..","..Allele1..","..Allele2..","..Zygosity..","..SNPs23andme..","..SNPsAncestry..","..SNPsFTDNA..","..SNPsGeno2..","..SNPsSeqDotCom.."\n")
			m_5 = snp_prefix..","..snp_suffix..","..Chrid..","..Position..","..Allele1..","..Allele2..","..Zygosity..","..SNPs23andme..","..SNPsAncestry..","..SNPsFTDNA..","..SNPsGeno2..","..SNPsSeqDotCom.."\n"
			f_4:write(m_5)
		end
		SNPid3 =table3[3]
		if SNPid3 == nil then
		SNPid3 = "null"
		else
			local SNPid = SNPid3
			local snp_suffix_stop = string.len(SNPid)
			local snp_prefix_test = string.len(SNPid)

			while snp_prefix_test > 0 do
				if string.byte(SNPid,snp_prefix_test) < 64 then
					snp_prefix_test = snp_prefix_test - 1
				else
					snp_prefix_stop = snp_prefix_test
					snp_suffix_start = snp_prefix_stop + 1
					snp_prefix_test = 0
				end
			end

			local snp_prefix = string.sub(SNPid,1,snp_prefix_stop)
			local snp_suffix = string.sub(SNPid,snp_suffix_start,snp_suffix_stop)

			print("found: "..snp_prefix..","..snp_suffix..","..Chrid..","..Position..","..Allele1..","..Allele2..","..Zygosity..","..SNPs23andme..","..SNPsAncestry..","..SNPsFTDNA..","..SNPsGeno2..","..SNPsSeqDotCom.."\n")
			m_5 = snp_prefix..","..snp_suffix..","..Chrid..","..Position..","..Allele1..","..Allele2..","..Zygosity..","..SNPs23andme..","..SNPsAncestry..","..SNPsFTDNA..","..SNPsGeno2..","..SNPsSeqDotCom.."\n"
			f_4:write(m_5)
		end
		SNPid4 =table3[4]
		if SNPid4 == nil then
		SNPid4 = "null"
		else
			local SNPid = SNPid4
			local snp_suffix_stop = string.len(SNPid)
			local snp_prefix_test = string.len(SNPid)

			while snp_prefix_test > 0 do
				if string.byte(SNPid,snp_prefix_test) < 64 then
					snp_prefix_test = snp_prefix_test - 1
				else
					snp_prefix_stop = snp_prefix_test
					snp_suffix_start = snp_prefix_stop + 1
					snp_prefix_test = 0
				end
			end

			local snp_prefix = string.sub(SNPid,1,snp_prefix_stop)
			local snp_suffix = string.sub(SNPid,snp_suffix_start,snp_suffix_stop)

			print("found: "..snp_prefix..","..snp_suffix..","..Chrid..","..Position..","..Allele1..","..Allele2..","..Zygosity..","..SNPs23andme..","..SNPsAncestry..","..SNPsFTDNA..","..SNPsGeno2..","..SNPsSeqDotCom.."\n")
			m_5 = snp_prefix..","..snp_suffix..","..Chrid..","..Position..","..Allele1..","..Allele2..","..Zygosity..","..SNPs23andme..","..SNPsAncestry..","..SNPsFTDNA..","..SNPsGeno2..","..SNPsSeqDotCom.."\n"
			f_4:write(m_5)
		end
		SNPid5 =table3[5]
		if SNPid5 == nil then
		SNPid5 = "null"
		else
			local SNPid = SNPid5
			local snp_suffix_stop = string.len(SNPid)
			local snp_prefix_test = string.len(SNPid)

			while snp_prefix_test > 0 do
				if string.byte(SNPid,snp_prefix_test) < 64 then
					snp_prefix_test = snp_prefix_test - 1
				else
					snp_prefix_stop = snp_prefix_test
					snp_suffix_start = snp_prefix_stop + 1
					snp_prefix_test = 0
				end
			end

			local snp_prefix = string.sub(SNPid,1,snp_prefix_stop)
			local snp_suffix = string.sub(SNPid,snp_suffix_start,snp_suffix_stop)

			print("found: "..snp_prefix..","..snp_suffix..","..Chrid..","..Position..","..Allele1..","..Allele2..","..Zygosity..","..SNPs23andme..","..SNPsAncestry..","..SNPsFTDNA..","..SNPsGeno2..","..SNPsSeqDotCom.."\n")
			m_5 = snp_prefix..","..snp_suffix..","..Chrid..","..Position..","..Allele1..","..Allele2..","..Zygosity..","..SNPs23andme..","..SNPsAncestry..","..SNPsFTDNA..","..SNPsGeno2..","..SNPsSeqDotCom.."\n"
			f_4:write(m_5)
		end
		SNPid6 =table3[6]
		if SNPid6 == nil then
		SNPid6 = "null"
		else
			local SNPid = SNPid6
			local snp_suffix_stop = string.len(SNPid)
			local snp_prefix_test = string.len(SNPid)

			while snp_prefix_test > 0 do
				if string.byte(SNPid,snp_prefix_test) < 64 then
					snp_prefix_test = snp_prefix_test - 1
				else
					snp_prefix_stop = snp_prefix_test
					snp_suffix_start = snp_prefix_stop + 1
					snp_prefix_test = 0
				end
			end

			local snp_prefix = string.sub(SNPid,1,snp_prefix_stop)
			local snp_suffix = string.sub(SNPid,snp_suffix_start,snp_suffix_stop)

			print("found: "..snp_prefix..","..snp_suffix..","..Chrid..","..Position..","..Allele1..","..Allele2..","..Zygosity..","..SNPs23andme..","..SNPsAncestry..","..SNPsFTDNA..","..SNPsGeno2..","..SNPsSeqDotCom.."\n")
			m_5 = snp_prefix..","..snp_suffix..","..Chrid..","..Position..","..Allele1..","..Allele2..","..Zygosity..","..SNPs23andme..","..SNPsAncestry..","..SNPsFTDNA..","..SNPsGeno2..","..SNPsSeqDotCom.."\n"
			f_4:write(m_5)
		end
		SNPid7 =table3[7]
		if SNPid7 == nil then
		SNPid7 = "null"
		else
			local SNPid = SNPid7
			local snp_suffix_stop = string.len(SNPid)
			local snp_prefix_test = string.len(SNPid)

			while snp_prefix_test > 0 do
				if string.byte(SNPid,snp_prefix_test) < 64 then
					snp_prefix_test = snp_prefix_test - 1
				else
					snp_prefix_stop = snp_prefix_test
					snp_suffix_start = snp_prefix_stop + 1
					snp_prefix_test = 0
				end
			end

			local snp_prefix = string.sub(SNPid,1,snp_prefix_stop)
			local snp_suffix = string.sub(SNPid,snp_suffix_start,snp_suffix_stop)

			print("found: "..snp_prefix..","..snp_suffix..","..Chrid..","..Position..","..Allele1..","..Allele2..","..Zygosity..","..SNPs23andme..","..SNPsAncestry..","..SNPsFTDNA..","..SNPsGeno2..","..SNPsSeqDotCom.."\n")
			m_5 = snp_prefix..","..snp_suffix..","..Chrid..","..Position..","..Allele1..","..Allele2..","..Zygosity..","..SNPs23andme..","..SNPsAncestry..","..SNPsFTDNA..","..SNPsGeno2..","..SNPsSeqDotCom.."\n"
			f_4:write(m_5)
		end
		SNPid8 =table3[8]
		if SNPid8 == nil then
		SNPid8 = "null"
		else
			local SNPid = SNPid8
			local snp_suffix_stop = string.len(SNPid)
			local snp_prefix_test = string.len(SNPid)

			while snp_prefix_test > 0 do
				if string.byte(SNPid,snp_prefix_test) < 64 then
					snp_prefix_test = snp_prefix_test - 1
				else
					snp_prefix_stop = snp_prefix_test
					snp_suffix_start = snp_prefix_stop + 1
					snp_prefix_test = 0
				end
			end

			local snp_prefix = string.sub(SNPid,1,snp_prefix_stop)
			local snp_suffix = string.sub(SNPid,snp_suffix_start,snp_suffix_stop)

			print("found: "..snp_prefix..","..snp_suffix..","..Chrid..","..Position..","..Allele1..","..Allele2..","..Zygosity..","..SNPs23andme..","..SNPsAncestry..","..SNPsFTDNA..","..SNPsGeno2..","..SNPsSeqDotCom.."\n")
			m_5 = snp_prefix..","..snp_suffix..","..Chrid..","..Position..","..Allele1..","..Allele2..","..Zygosity..","..SNPs23andme..","..SNPsAncestry..","..SNPsFTDNA..","..SNPsGeno2..","..SNPsSeqDotCom.."\n"
			f_4:write(m_5)
		end
		SNPid9 =table3[9]
		if SNPid9 == nil then
		SNPid9 = "null"
		else
			local SNPid = SNPid9
			local snp_suffix_stop = string.len(SNPid)
			local snp_prefix_test = string.len(SNPid)

			while snp_prefix_test > 0 do
				if string.byte(SNPid,snp_prefix_test) < 64 then
					snp_prefix_test = snp_prefix_test - 1
				else
					snp_prefix_stop = snp_prefix_test
					snp_suffix_start = snp_prefix_stop + 1
					snp_prefix_test = 0
				end
			end

			local snp_prefix = string.sub(SNPid,1,snp_prefix_stop)
			local snp_suffix = string.sub(SNPid,snp_suffix_start,snp_suffix_stop)

			print("found: "..snp_prefix..","..snp_suffix..","..Chrid..","..Position..","..Allele1..","..Allele2..","..Zygosity..","..SNPs23andme..","..SNPsAncestry..","..SNPsFTDNA..","..SNPsGeno2..","..SNPsSeqDotCom.."\n")
			m_5 = snp_prefix..","..snp_suffix..","..Chrid..","..Position..","..Allele1..","..Allele2..","..Zygosity..","..SNPs23andme..","..SNPsAncestry..","..SNPsFTDNA..","..SNPsGeno2..","..SNPsSeqDotCom.."\n"
			f_4:write(m_5)
		end
		SNPid10 =table3[10]
		if SNPid10 == nil then
		SNPid10 = "null"
		else
			local SNPid = SNPid10
			local snp_suffix_stop = string.len(SNPid)
			local snp_prefix_test = string.len(SNPid)

			while snp_prefix_test > 0 do
				if string.byte(SNPid,snp_prefix_test) < 64 then
					snp_prefix_test = snp_prefix_test - 1
				else
					snp_prefix_stop = snp_prefix_test
					snp_suffix_start = snp_prefix_stop + 1
					snp_prefix_test = 0
				end
			end

			local snp_prefix = string.sub(SNPid,1,snp_prefix_stop)
			local snp_suffix = string.sub(SNPid,snp_suffix_start,snp_suffix_stop)

			print("found: "..snp_prefix..","..snp_suffix..","..Chrid..","..Position..","..Allele1..","..Allele2..","..Zygosity..","..SNPs23andme..","..SNPsAncestry..","..SNPsFTDNA..","..SNPsGeno2..","..SNPsSeqDotCom.."\n")
			m_5 = snp_prefix..","..snp_suffix..","..Chrid..","..Position..","..Allele1..","..Allele2..","..Zygosity..","..SNPs23andme..","..SNPsAncestry..","..SNPsFTDNA..","..SNPsGeno2..","..SNPsSeqDotCom.."\n"
			f_4:write(m_5)
		end
	end

	local SNPid = SNP
	local snp_suffix_stop = string.len(SNPid)
	local snp_prefix_test = string.len(SNPid)

	while snp_prefix_test > 0 do
		if string.byte(SNPid,snp_prefix_test) < 64 then
			snp_prefix_test = snp_prefix_test - 1
		else
			snp_prefix_stop = snp_prefix_test
			snp_suffix_start = snp_prefix_stop + 1
			snp_prefix_test = 0
		end
	end

	local snp_prefix = string.sub(SNP,1,snp_prefix_stop)
	local snp_suffix = string.sub(SNP,snp_suffix_start,snp_suffix_stop)

	print("found: "..snp_prefix..","..snp_suffix..","..Chrid..","..Position..","..Allele1..","..Allele2..","..Zygosity..","..SNPs23andme..","..SNPsAncestry..","..SNPsFTDNA..","..SNPsGeno2..","..SNPsSeqDotCom.."\n")
	m_5 = snp_prefix..","..snp_suffix..","..Chrid..","..Position..","..Allele1..","..Allele2..","..Zygosity..","..SNPs23andme..","..SNPsAncestry..","..SNPsFTDNA..","..SNPsGeno2..","..SNPsSeqDotCom.."\n"
	f_4:write(m_5)

end
end

-- close file output
io.close(f_4)
