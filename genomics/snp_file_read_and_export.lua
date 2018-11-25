-- file output
outputfilename1 = "James_SNPs_exported_Geno2.csv"
outputfilename2 = "James_SNPs_exported_23andme.csv"
outputfilename3 = "James_SNPs_exported_AncestryDNA.csv"
outputfilename4 = "James_SNPs_exported_FTDNA.csv"
outputfilename5 = "James_SNPs_exported_SeqDotCom.csv"
f_1 = io.open(outputfilename1, "a")
f_2 = io.open(outputfilename2, "a")
f_3 = io.open(outputfilename3, "a")
f_4 = io.open(outputfilename4, "a")
f_5 = io.open(outputfilename5, "a")

m_1 = "SNP_prefix,SNP_suffix,Chr,Pos,Allele1,Allele2,Zygosity,23andme,AncestryDNA,FTDNA,Geno2,SeqDotCom\n"

f_1:write(m_1)
f_2:write(m_1)
f_3:write(m_1)
f_4:write(m_1)
f_5:write(m_1)

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

-- input1 Geno2 format
for line in io.lines("James_'BUAJQYMN'.csv")
	do
	testcomment = (string.find(line, "SNP"))
if testcomment == nil then
-- set test name
	local test_name = "Geno2"

-- apply fromCSV function to each line
	table1 = fromCSV1(line)

-- populate variables from table
	local SNPid = string.upper(table1[1])
		if SNPid == nil then
		SNPid = " "
		end
	local Chr =  table1[2]
		if Chr == nil then
		Chr = " "
		end
	local AlleleOne = table1[3]
		if AlleleOne == nil then
		AlleleOne = " "
		end
	local AlleleTwo = table1[4]
		if AlleleTwo == nil then
		AlleleTwo = " "
		end
	local Position = table1[5]
		if Position == nil then
		Position = " "
		end

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
--~ 	print("snp_prefix: "..snp_prefix..", snp_suffix: "..snp_suffix.."\n")


	if AlleleOne < AlleleTwo then
		Allele1 = AlleleOne
		Allele2 = AlleleTwo
	elseif AlleleTwo < AlleleOne then
		Allele1 = AlleleTwo
		Allele2 = AlleleOne
	else
		Allele1 = AlleleOne
		Allele2 = AlleleTwo
	end

	local testchr1 = (string.find(Chr, "1"))
	local testchr2 = (string.find(Chr, "2"))
	local testchr3 = (string.find(Chr, "3"))
	local testchr4 = (string.find(Chr, "4"))
	local testchr5 = (string.find(Chr, "5"))
	local testchr6 = (string.find(Chr, "6"))
	local testchr7 = (string.find(Chr, "7"))
	local testchr8 = (string.find(Chr, "8"))
	local testchr9 = (string.find(Chr, "9"))
	local testchr10 = (string.find(Chr, "10"))
	local testchr11 = (string.find(Chr, "11"))
	local testchr12 = (string.find(Chr, "12"))
	local testchr13 = (string.find(Chr, "13"))
	local testchr14 = (string.find(Chr, "14"))
	local testchr15 = (string.find(Chr, "15"))
	local testchr16 = (string.find(Chr, "16"))
	local testchr17 = (string.find(Chr, "17"))
	local testchr18 = (string.find(Chr, "18"))
	local testchr19 = (string.find(Chr, "19"))
	local testchr20 = (string.find(Chr, "20"))
	local testchr21 = (string.find(Chr, "21"))
	local testchr22 = (string.find(Chr, "22"))
	local testchr23 = (string.find(Chr, "23"))
	local testchr24 = (string.find(Chr, "24"))
	local testchr25 = (string.find(Chr, "25"))
	local testchrMT = (string.find(Chr, "MT"))
	local testchrMt = (string.find(Chr, "Mt"))
	local testchrmt = (string.find(Chr, "mt"))
	local testchrX = (string.find(Chr, "X"))
	local testchrY = (string.find(Chr, "Y"))

	if (testchr1 ~= nil) and (string.len(Chr) == string.len("1")) then
		Chrid = "1"
	elseif (testchr2 ~= nil) and (string.len(Chr) == string.len("2")) then
		Chrid = "2"
	elseif (testchr3 ~= nil) and (string.len(Chr) == string.len("3")) then
		Chrid = "3"
	elseif (testchr4 ~= nil) and (string.len(Chr) == string.len("4")) then
		Chrid = "4"
	elseif (testchr5 ~= nil) and (string.len(Chr) == string.len("5")) then
		Chrid = "5"
	elseif (testchr6 ~= nil) and (string.len(Chr) == string.len("6")) then
		Chrid = "6"
	elseif (testchr7 ~= nil) and (string.len(Chr) == string.len("7")) then
		Chrid = "7"
	elseif (testchr8 ~= nil) and (string.len(Chr) == string.len("8")) then
		Chrid = "8"
	elseif (testchr9 ~= nil) and (string.len(Chr) == string.len("9")) then
		Chrid = "9"
	elseif (testchr10 ~= nil) then
		Chrid = "10"
	elseif (testchr11 ~= nil) then
		Chrid = "11"
	elseif (testchr12 ~= nil) then
		Chrid = "12"
	elseif (testchr13 ~= nil) then
		Chrid = "13"
	elseif (testchr14 ~= nil) then
		Chrid = "14"
	elseif (testchr15 ~= nil) then
		Chrid = "15"
	elseif (testchr16 ~= nil) then
		Chrid = "16"
	elseif (testchr17 ~= nil) then
		Chrid = "17"
	elseif (testchr18 ~= nil) then
		Chrid = "18"
	elseif (testchr19 ~= nil) then
		Chrid = "19"
	elseif (testchr20 ~= nil) then
		Chrid = "20"
	elseif (testchr21 ~= nil) then
		Chrid = "21"
	elseif (testchr22 ~= nil) then
		Chrid = "22"
	elseif (testchr23 ~= nil) then
		Chrid = "X"
	elseif (testchr24 ~= nil) then
		Chrid = "Y"
	elseif (testchr25 ~= nil) then
		Chrid = "MT"
		snp_prefix = "rCRS_diff"
		snp_suffix = SNPid
	elseif (testchrMT ~= nil) then
		Chrid = "MT"
		snp_prefix = "rCRS_diff"
		snp_suffix = SNPid
	elseif (testchrMt ~= nil) then
		Chrid = "MT"
		snp_prefix = "rCRS_diff"
		snp_suffix = SNPid
	elseif (testchrmt ~= nil) then
		Chrid = "MT"
		snp_prefix = "rCRS_diff"
		snp_suffix = SNPid
	elseif (testchrX ~= nil) then
		Chrid = "X"
	elseif (testchrY ~= nil) then
		Chrid = "Y"
	end

	if string.find(Allele1,"-") then
		Zygosity = "No Call"
	elseif string.find(Allele2, "-") then
		Zygosity = "No Call"
	elseif Allele1 == Allele2 then
		Zygosity = "Homozygous"
	elseif Allele1 ~= Allele2 then
		Zygosity = "Heterozygous"
	end

	local SNPs23andme = " "
	local SNPsAncestry = " "
	local SNPsFTDNA = " "
	local SNPsGeno2 = Allele1..Allele2
	local SNPsSeqDotCom = " "

--~ m_1 = "SNP_prefix,SNP_suffix,Chr,Pos,Allele1,Allele2,Zygosity,23andme,AncestryDNA,FTDNA,Geno2,SeqDotCom\n"
	print("found: "..snp_prefix..","..snp_suffix..","..Chrid..","..Position..","..Allele1..","..Allele2..","..Zygosity..","..SNPs23andme..","..SNPsAncestry..","..SNPsFTDNA..","..SNPsGeno2..","..SNPsSeqDotCom.."\n")
	m_2 = snp_prefix..","..snp_suffix..","..Chrid..","..Position..","..Allele1..","..Allele2..","..Zygosity..","..SNPs23andme..","..SNPsAncestry..","..SNPsFTDNA..","..SNPsGeno2..","..SNPsSeqDotCom.."\n"
	f_1:write(m_2)
end
end

-- input2 23andme format
for line in io.lines("genome_James_Pittman_v3_Full_20180913131635.txt")
	do
	testcomment = (string.find(line, "#"))
if testcomment == nil then
-- set test name
	local test_name = "23andme"

-- apply fromCSV function to each line
	table2 = fromCSV2(line)

-- populate variables from table
	local SNPid = string.upper(table2[1])
		if SNPid == nil then
		SNPid = " "
		end
	local Chr =  table2[2]
		if Chr == nil then
		Chr = " "
		end
	local Position =  table2[3]
		if Position == nil then
		Position = " "
		end
	local AlleleOne = string.char(string.byte(table2[4], 1))
		if AlleleOne == nil then
		AlleleOne = " "
		end
	local AlleleTwo = string.char(string.byte(table2[4], 2))
		if AlleleTwo == nil then
		AlleleTwo = " "
		end

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
--~ 	print("snp_prefix: "..snp_prefix..", snp_suffix: "..snp_suffix.."\n")

	if AlleleOne < AlleleTwo then
		Allele1 = AlleleOne
		Allele2 = AlleleTwo
	elseif AlleleTwo < AlleleOne then
		Allele1 = AlleleTwo
		Allele2 = AlleleOne
	else
		Allele1 = AlleleOne
		Allele2 = AlleleTwo
	end

	local testchr1 = (string.find(Chr, "1"))
	local testchr2 = (string.find(Chr, "2"))
	local testchr3 = (string.find(Chr, "3"))
	local testchr4 = (string.find(Chr, "4"))
	local testchr5 = (string.find(Chr, "5"))
	local testchr6 = (string.find(Chr, "6"))
	local testchr7 = (string.find(Chr, "7"))
	local testchr8 = (string.find(Chr, "8"))
	local testchr9 = (string.find(Chr, "9"))
	local testchr10 = (string.find(Chr, "10"))
	local testchr11 = (string.find(Chr, "11"))
	local testchr12 = (string.find(Chr, "12"))
	local testchr13 = (string.find(Chr, "13"))
	local testchr14 = (string.find(Chr, "14"))
	local testchr15 = (string.find(Chr, "15"))
	local testchr16 = (string.find(Chr, "16"))
	local testchr17 = (string.find(Chr, "17"))
	local testchr18 = (string.find(Chr, "18"))
	local testchr19 = (string.find(Chr, "19"))
	local testchr20 = (string.find(Chr, "20"))
	local testchr21 = (string.find(Chr, "21"))
	local testchr22 = (string.find(Chr, "22"))
	local testchr23 = (string.find(Chr, "23"))
	local testchr24 = (string.find(Chr, "24"))
	local testchr25 = (string.find(Chr, "25"))
	local testchrMT = (string.find(Chr, "MT"))
	local testchrMt = (string.find(Chr, "Mt"))
	local testchrmt = (string.find(Chr, "mt"))
	local testchrX = (string.find(Chr, "X"))
	local testchrY = (string.find(Chr, "Y"))

	if (testchr1 ~= nil) and (string.len(Chr) == string.len("1")) then
		Chrid = "1"
	elseif (testchr2 ~= nil) and (string.len(Chr) == string.len("2")) then
		Chrid = "2"
	elseif (testchr3 ~= nil) and (string.len(Chr) == string.len("3")) then
		Chrid = "3"
	elseif (testchr4 ~= nil) and (string.len(Chr) == string.len("4")) then
		Chrid = "4"
	elseif (testchr5 ~= nil) and (string.len(Chr) == string.len("5")) then
		Chrid = "5"
	elseif (testchr6 ~= nil) and (string.len(Chr) == string.len("6")) then
		Chrid = "6"
	elseif (testchr7 ~= nil) and (string.len(Chr) == string.len("7")) then
		Chrid = "7"
	elseif (testchr8 ~= nil) and (string.len(Chr) == string.len("8")) then
		Chrid = "8"
	elseif (testchr9 ~= nil) and (string.len(Chr) == string.len("9")) then
		Chrid = "9"
	elseif (testchr10 ~= nil) then
		Chrid = "10"
	elseif (testchr11 ~= nil) then
		Chrid = "11"
	elseif (testchr12 ~= nil) then
		Chrid = "12"
	elseif (testchr13 ~= nil) then
		Chrid = "13"
	elseif (testchr14 ~= nil) then
		Chrid = "14"
	elseif (testchr15 ~= nil) then
		Chrid = "15"
	elseif (testchr16 ~= nil) then
		Chrid = "16"
	elseif (testchr17 ~= nil) then
		Chrid = "17"
	elseif (testchr18 ~= nil) then
		Chrid = "18"
	elseif (testchr19 ~= nil) then
		Chrid = "19"
	elseif (testchr20 ~= nil) then
		Chrid = "20"
	elseif (testchr21 ~= nil) then
		Chrid = "21"
	elseif (testchr22 ~= nil) then
		Chrid = "22"
	elseif (testchr23 ~= nil) then
		Chrid = "X"
	elseif (testchr24 ~= nil) then
		Chrid = "Y"
	elseif (testchr25 ~= nil) then
		Chrid = "MT"
	elseif (testchrMT ~= nil) then
		Chrid = "MT"
	elseif (testchrMt ~= nil) then
		Chrid = "MT"
	elseif (testchrmt ~= nil) then
		Chrid = "MT"
	elseif (testchrX ~= nil) then
		Chrid = "X"
	elseif (testchrY ~= nil) then
		Chrid = "Y"
	end

	if string.find(Allele1,"-") then
		Zygosity = "No Call"
	elseif string.find(Allele2, "-") then
		Zygosity = "No Call"
	elseif Allele1 == Allele2 then
		Zygosity = "Homozygous"
	elseif Allele1 ~= Allele2 then
		Zygosity = "Heterozygous"
	end

	local SNPs23andme = Allele1..Allele2
	local SNPsAncestry = " "
	local SNPsFTDNA = " "
	local SNPsGeno2 = " "
	local SNPsSeqDotCom = " "

	print("found: "..snp_prefix..","..snp_suffix..","..Chrid..","..Position..","..Allele1..","..Allele2..","..Zygosity..","..SNPs23andme..","..SNPsAncestry..","..SNPsFTDNA..","..SNPsGeno2..","..SNPsSeqDotCom.."\n")
	m_3 = snp_prefix..","..snp_suffix..","..Chrid..","..Position..","..Allele1..","..Allele2..","..Zygosity..","..SNPs23andme..","..SNPsAncestry..","..SNPsFTDNA..","..SNPsGeno2..","..SNPsSeqDotCom.."\n"
	f_2:write(m_3)
end
end

-- input3 AncestryDNA format
for line in io.lines("AncestryDNA.txt")
	do
	testcomment1 = (string.find(line, "#"))
	testcomment2 = (string.find(line, "rsid"))
if testcomment1 == nil and testcomment2 == nil then
-- set test name
	local test_name = "AncestryDNA"

-- apply fromCSV function to each line
	table2 = fromCSV2(line)

-- populate variables from table
	local SNPid = string.upper(table2[1])
		if SNPid == nil then
		SNPid = " "
		end
	local Chr =  table2[2]
		if Chr == nil then
		Chr = " "
		end
	local Position =  table2[3]
		if Position == nil then
		Position = " "
		end
	local AlleleOne = table2[4]
		if AlleleOne == nil then
		AlleleOne = " "
		end
		if string.find(AlleleOne,"0") then
		AlleleOne = "-"
		end
	local AlleleTwo = table2[5]
		if AlleleTwo == nil then
		AlleleTwo = " "
		end
		if string.find(AlleleTwo,"0") then
		AlleleTwo = "-"
		end

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
--~ 	print("snp_prefix: "..snp_prefix..", snp_suffix: "..snp_suffix.."\n")

	if AlleleOne < AlleleTwo then
		Allele1 = AlleleOne
		Allele2 = AlleleTwo
	elseif AlleleTwo < AlleleOne then
		Allele1 = AlleleTwo
		Allele2 = AlleleOne
	else
		Allele1 = AlleleOne
		Allele2 = AlleleTwo
	end

	local testchr1 = (string.find(Chr, "1"))
	local testchr2 = (string.find(Chr, "2"))
	local testchr3 = (string.find(Chr, "3"))
	local testchr4 = (string.find(Chr, "4"))
	local testchr5 = (string.find(Chr, "5"))
	local testchr6 = (string.find(Chr, "6"))
	local testchr7 = (string.find(Chr, "7"))
	local testchr8 = (string.find(Chr, "8"))
	local testchr9 = (string.find(Chr, "9"))
	local testchr10 = (string.find(Chr, "10"))
	local testchr11 = (string.find(Chr, "11"))
	local testchr12 = (string.find(Chr, "12"))
	local testchr13 = (string.find(Chr, "13"))
	local testchr14 = (string.find(Chr, "14"))
	local testchr15 = (string.find(Chr, "15"))
	local testchr16 = (string.find(Chr, "16"))
	local testchr17 = (string.find(Chr, "17"))
	local testchr18 = (string.find(Chr, "18"))
	local testchr19 = (string.find(Chr, "19"))
	local testchr20 = (string.find(Chr, "20"))
	local testchr21 = (string.find(Chr, "21"))
	local testchr22 = (string.find(Chr, "22"))
	local testchr23 = (string.find(Chr, "23"))
	local testchr24 = (string.find(Chr, "24"))
	local testchr25 = (string.find(Chr, "25"))
	local testchrMT = (string.find(Chr, "MT"))
	local testchrMt = (string.find(Chr, "Mt"))
	local testchrmt = (string.find(Chr, "mt"))
	local testchrX = (string.find(Chr, "X"))
	local testchrY = (string.find(Chr, "Y"))

	if (testchr1 ~= nil) and (string.len(Chr) == string.len("1")) then
		Chrid = "1"
	elseif (testchr2 ~= nil) and (string.len(Chr) == string.len("2")) then
		Chrid = "2"
	elseif (testchr3 ~= nil) and (string.len(Chr) == string.len("3")) then
		Chrid = "3"
	elseif (testchr4 ~= nil) and (string.len(Chr) == string.len("4")) then
		Chrid = "4"
	elseif (testchr5 ~= nil) and (string.len(Chr) == string.len("5")) then
		Chrid = "5"
	elseif (testchr6 ~= nil) and (string.len(Chr) == string.len("6")) then
		Chrid = "6"
	elseif (testchr7 ~= nil) and (string.len(Chr) == string.len("7")) then
		Chrid = "7"
	elseif (testchr8 ~= nil) and (string.len(Chr) == string.len("8")) then
		Chrid = "8"
	elseif (testchr9 ~= nil) and (string.len(Chr) == string.len("9")) then
		Chrid = "9"
	elseif (testchr10 ~= nil) then
		Chrid = "10"
	elseif (testchr11 ~= nil) then
		Chrid = "11"
	elseif (testchr12 ~= nil) then
		Chrid = "12"
	elseif (testchr13 ~= nil) then
		Chrid = "13"
	elseif (testchr14 ~= nil) then
		Chrid = "14"
	elseif (testchr15 ~= nil) then
		Chrid = "15"
	elseif (testchr16 ~= nil) then
		Chrid = "16"
	elseif (testchr17 ~= nil) then
		Chrid = "17"
	elseif (testchr18 ~= nil) then
		Chrid = "18"
	elseif (testchr19 ~= nil) then
		Chrid = "19"
	elseif (testchr20 ~= nil) then
		Chrid = "20"
	elseif (testchr21 ~= nil) then
		Chrid = "21"
	elseif (testchr22 ~= nil) then
		Chrid = "22"
	elseif (testchr23 ~= nil) then
		Chrid = "X"
	elseif (testchr24 ~= nil) then
		Chrid = "Y"
	elseif (testchr25 ~= nil) then
		Chrid = "MT"
	elseif (testchrMT ~= nil) then
		Chrid = "MT"
	elseif (testchrMt ~= nil) then
		Chrid = "MT"
	elseif (testchrmt ~= nil) then
		Chrid = "MT"
	elseif (testchrX ~= nil) then
		Chrid = "X"
	elseif (testchrY ~= nil) then
		Chrid = "Y"
	end

	if string.find(Allele1,"-") then
		Zygosity = "No Call"
	elseif string.find(Allele2, "-") then
		Zygosity = "No Call"
	elseif Allele1 == Allele2 then
		Zygosity = "Homozygous"
	elseif Allele1 ~= Allele2 then
		Zygosity = "Heterozygous"
	end

	local SNPs23andme = " "
	local SNPsAncestry = Allele1..Allele2
	local SNPsFTDNA = " "
	local SNPsGeno2 = " "
	local SNPsSeqDotCom = " "

	print("found: "..snp_prefix..","..snp_suffix..","..Chrid..","..Position..","..Allele1..","..Allele2..","..Zygosity..","..SNPs23andme..","..SNPsAncestry..","..SNPsFTDNA..","..SNPsGeno2..","..SNPsSeqDotCom.."\n")
	m_4 = snp_prefix..","..snp_suffix..","..Chrid..","..Position..","..Allele1..","..Allele2..","..Zygosity..","..SNPs23andme..","..SNPsAncestry..","..SNPsFTDNA..","..SNPsGeno2..","..SNPsSeqDotCom.."\n"
	f_3:write(m_4)

end
end

-- input4 FTDNA format
for line in io.lines("B3600_Autosomal_o37_Results_20170808.csv")
	do
	testcomment = (string.find(line, "RSID"))
if testcomment == nil then
-- set test name
	local test_name = "FTDNA"

-- apply fromCSV function to each line
	table1 = fromCSV1(line)

-- populate variables from table
	local SNPid = string.upper(table1[1])
		if SNPid == nil then
		SNPid = " "
		end
	local Chr =  table1[2]
		if Chr == nil then
		Chr = " "
		end
	local Position =  table1[3]
		if Position == nil then
		Position = " "
		end
	local AlleleOne = string.char(string.byte(table1[4], 1))
		if AlleleOne == nil then
		AlleleOne = " "
		end
	local AlleleTwo = string.char(string.byte(table1[4], 2))
		if AlleleTwo == nil then
		AlleleTwo = " "
		end

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
--~ 	print("snp_prefix: "..snp_prefix..", snp_suffix: "..snp_suffix.."\n")

	if AlleleOne < AlleleTwo then
		Allele1 = AlleleOne
		Allele2 = AlleleTwo
	elseif AlleleTwo < AlleleOne then
		Allele1 = AlleleTwo
		Allele2 = AlleleOne
	else
		Allele1 = AlleleOne
		Allele2 = AlleleTwo
	end

	local testchr1 = (string.find(Chr, "1"))
	local testchr2 = (string.find(Chr, "2"))
	local testchr3 = (string.find(Chr, "3"))
	local testchr4 = (string.find(Chr, "4"))
	local testchr5 = (string.find(Chr, "5"))
	local testchr6 = (string.find(Chr, "6"))
	local testchr7 = (string.find(Chr, "7"))
	local testchr8 = (string.find(Chr, "8"))
	local testchr9 = (string.find(Chr, "9"))
	local testchr10 = (string.find(Chr, "10"))
	local testchr11 = (string.find(Chr, "11"))
	local testchr12 = (string.find(Chr, "12"))
	local testchr13 = (string.find(Chr, "13"))
	local testchr14 = (string.find(Chr, "14"))
	local testchr15 = (string.find(Chr, "15"))
	local testchr16 = (string.find(Chr, "16"))
	local testchr17 = (string.find(Chr, "17"))
	local testchr18 = (string.find(Chr, "18"))
	local testchr19 = (string.find(Chr, "19"))
	local testchr20 = (string.find(Chr, "20"))
	local testchr21 = (string.find(Chr, "21"))
	local testchr22 = (string.find(Chr, "22"))
	local testchr23 = (string.find(Chr, "23"))
	local testchr24 = (string.find(Chr, "24"))
	local testchr25 = (string.find(Chr, "25"))
	local testchrMT = (string.find(Chr, "MT"))
	local testchrMt = (string.find(Chr, "Mt"))
	local testchrmt = (string.find(Chr, "mt"))
	local testchrX = (string.find(Chr, "X"))
	local testchrY = (string.find(Chr, "Y"))

	if (testchr1 ~= nil) and (string.len(Chr) == string.len("1")) then
		Chrid = "1"
	elseif (testchr2 ~= nil) and (string.len(Chr) == string.len("2")) then
		Chrid = "2"
	elseif (testchr3 ~= nil) and (string.len(Chr) == string.len("3")) then
		Chrid = "3"
	elseif (testchr4 ~= nil) and (string.len(Chr) == string.len("4")) then
		Chrid = "4"
	elseif (testchr5 ~= nil) and (string.len(Chr) == string.len("5")) then
		Chrid = "5"
	elseif (testchr6 ~= nil) and (string.len(Chr) == string.len("6")) then
		Chrid = "6"
	elseif (testchr7 ~= nil) and (string.len(Chr) == string.len("7")) then
		Chrid = "7"
	elseif (testchr8 ~= nil) and (string.len(Chr) == string.len("8")) then
		Chrid = "8"
	elseif (testchr9 ~= nil) and (string.len(Chr) == string.len("9")) then
		Chrid = "9"
	elseif (testchr10 ~= nil) then
		Chrid = "10"
	elseif (testchr11 ~= nil) then
		Chrid = "11"
	elseif (testchr12 ~= nil) then
		Chrid = "12"
	elseif (testchr13 ~= nil) then
		Chrid = "13"
	elseif (testchr14 ~= nil) then
		Chrid = "14"
	elseif (testchr15 ~= nil) then
		Chrid = "15"
	elseif (testchr16 ~= nil) then
		Chrid = "16"
	elseif (testchr17 ~= nil) then
		Chrid = "17"
	elseif (testchr18 ~= nil) then
		Chrid = "18"
	elseif (testchr19 ~= nil) then
		Chrid = "19"
	elseif (testchr20 ~= nil) then
		Chrid = "20"
	elseif (testchr21 ~= nil) then
		Chrid = "21"
	elseif (testchr22 ~= nil) then
		Chrid = "22"
	elseif (testchr23 ~= nil) then
		Chrid = "X"
	elseif (testchr24 ~= nil) then
		Chrid = "Y"
	elseif (testchr25 ~= nil) then
		Chrid = "MT"
	elseif (testchrMT ~= nil) then
		Chrid = "MT"
	elseif (testchrMt ~= nil) then
		Chrid = "MT"
	elseif (testchrmt ~= nil) then
		Chrid = "MT"
	elseif (testchrX ~= nil) then
		Chrid = "X"
	elseif (testchrY ~= nil) then
		Chrid = "Y"
	end

	if string.find(Allele1,"-") then
		Zygosity = "No Call"
	elseif string.find(Allele2, "-") then
		Zygosity = "No Call"
	elseif Allele1 == Allele2 then
		Zygosity = "Homozygous"
	elseif Allele1 ~= Allele2 then
		Zygosity = "Heterozygous"
	end

	local SNPs23andme = " "
	local SNPsAncestry = " "
	local SNPsFTDNA = Allele1..Allele2
	local SNPsGeno2 = " "
	local SNPsSeqDotCom = " "

	print("found: "..snp_prefix..","..snp_suffix..","..Chrid..","..Position..","..Allele1..","..Allele2..","..Zygosity..","..SNPs23andme..","..SNPsAncestry..","..SNPsFTDNA..","..SNPsGeno2..","..SNPsSeqDotCom.."\n")
	m_5 = snp_prefix..","..snp_suffix..","..Chrid..","..Position..","..Allele1..","..Allele2..","..Zygosity..","..SNPs23andme..","..SNPsAncestry..","..SNPsFTDNA..","..SNPsGeno2..","..SNPsSeqDotCom.."\n"
	f_4:write(m_5)

end
end

-- input5 sequencing.com clinvar report format
for line in io.lines("55001608268385A-ClinVar-Report-SequencingCom.csv")
	do
	testcomment = (string.find(line, "#"))
if testcomment == nil then
-- set test name
	local test_name = "SeqDotComClinVar"

-- apply fromCSV function to each line
	table2 = fromCSV2(line)

-- populate variables from table
	local Chr =  table2[1]
		if Chr == nil then
		Chr = " "
		end
	local Position =  table2[2]
		if Position == nil then
		Position = " "
		end
	local SNPid = string.upper(table2[3])
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
--~ 	print("snp_prefix: "..snp_prefix..", snp_suffix: "..snp_suffix.."\n")

	local testchr1 = (string.find(Chr, "1"))
	local testchr2 = (string.find(Chr, "2"))
	local testchr3 = (string.find(Chr, "3"))
	local testchr4 = (string.find(Chr, "4"))
	local testchr5 = (string.find(Chr, "5"))
	local testchr6 = (string.find(Chr, "6"))
	local testchr7 = (string.find(Chr, "7"))
	local testchr8 = (string.find(Chr, "8"))
	local testchr9 = (string.find(Chr, "9"))
	local testchr10 = (string.find(Chr, "10"))
	local testchr11 = (string.find(Chr, "11"))
	local testchr12 = (string.find(Chr, "12"))
	local testchr13 = (string.find(Chr, "13"))
	local testchr14 = (string.find(Chr, "14"))
	local testchr15 = (string.find(Chr, "15"))
	local testchr16 = (string.find(Chr, "16"))
	local testchr17 = (string.find(Chr, "17"))
	local testchr18 = (string.find(Chr, "18"))
	local testchr19 = (string.find(Chr, "19"))
	local testchr20 = (string.find(Chr, "20"))
	local testchr21 = (string.find(Chr, "21"))
	local testchr22 = (string.find(Chr, "22"))
	local testchr23 = (string.find(Chr, "23"))
	local testchr24 = (string.find(Chr, "24"))
	local testchr25 = (string.find(Chr, "25"))
	local testchrMT = (string.find(Chr, "MT"))
	local testchrMt = (string.find(Chr, "Mt"))
	local testchrmt = (string.find(Chr, "mt"))
	local testchrX = (string.find(Chr, "X"))
	local testchrY = (string.find(Chr, "Y"))

	if (testchr1 ~= nil) and (string.len(Chr) == string.len("1")) then
		Chrid = "1"
	elseif (testchr2 ~= nil) and (string.len(Chr) == string.len("2")) then
		Chrid = "2"
	elseif (testchr3 ~= nil) and (string.len(Chr) == string.len("3")) then
		Chrid = "3"
	elseif (testchr4 ~= nil) and (string.len(Chr) == string.len("4")) then
		Chrid = "4"
	elseif (testchr5 ~= nil) and (string.len(Chr) == string.len("5")) then
		Chrid = "5"
	elseif (testchr6 ~= nil) and (string.len(Chr) == string.len("6")) then
		Chrid = "6"
	elseif (testchr7 ~= nil) and (string.len(Chr) == string.len("7")) then
		Chrid = "7"
	elseif (testchr8 ~= nil) and (string.len(Chr) == string.len("8")) then
		Chrid = "8"
	elseif (testchr9 ~= nil) and (string.len(Chr) == string.len("9")) then
		Chrid = "9"
	elseif (testchr10 ~= nil) then
		Chrid = "10"
	elseif (testchr11 ~= nil) then
		Chrid = "11"
	elseif (testchr12 ~= nil) then
		Chrid = "12"
	elseif (testchr13 ~= nil) then
		Chrid = "13"
	elseif (testchr14 ~= nil) then
		Chrid = "14"
	elseif (testchr15 ~= nil) then
		Chrid = "15"
	elseif (testchr16 ~= nil) then
		Chrid = "16"
	elseif (testchr17 ~= nil) then
		Chrid = "17"
	elseif (testchr18 ~= nil) then
		Chrid = "18"
	elseif (testchr19 ~= nil) then
		Chrid = "19"
	elseif (testchr20 ~= nil) then
		Chrid = "20"
	elseif (testchr21 ~= nil) then
		Chrid = "21"
	elseif (testchr22 ~= nil) then
		Chrid = "22"
	elseif (testchr23 ~= nil) then
		Chrid = "X"
	elseif (testchr24 ~= nil) then
		Chrid = "Y"
	elseif (testchr25 ~= nil) then
		Chrid = "MT"
	elseif (testchrMT ~= nil) then
		Chrid = "MT"
	elseif (testchrMt ~= nil) then
		Chrid = "MT"
	elseif (testchrmt ~= nil) then
		Chrid = "MT"
	elseif (testchrX ~= nil) then
		Chrid = "X"
	elseif (testchrY ~= nil) then
		Chrid = "Y"
	end

	if string.find(Zygos,"Het") then
		AlleleOne = RefAllele
		AlleleTwo = AltAllele
		Zygosity = "Heterozygous"
	elseif string.find(Zygos,"Hom") then
		AlleleOne = AltAllele
		AlleleTwo = AltAllele
		Zygosity = "Homozygous"
	end

	if AlleleOne < AlleleTwo then
		Allele1 = AlleleOne
		Allele2 = AlleleTwo
	elseif AlleleTwo < AlleleOne then
		Allele1 = AlleleTwo
		Allele2 = AlleleOne
	else
		Allele1 = AlleleOne
		Allele2 = AlleleTwo
	end

	local SNPs23andme = " "
	local SNPsAncestry = " "
	local SNPsFTDNA = " "
	local SNPsGeno2 = " "
	local SNPsSeqDotCom = Allele1..Allele2

	print("found: "..snp_prefix..","..snp_suffix..","..Chrid..","..Position..","..Allele1..","..Allele2..","..Zygosity..","..SNPs23andme..","..SNPsAncestry..","..SNPsFTDNA..","..SNPsGeno2..","..SNPsSeqDotCom.."\n")
	m_6 = snp_prefix..","..snp_suffix..","..Chrid..","..Position..","..Allele1..","..Allele2..","..Zygosity..","..SNPs23andme..","..SNPsAncestry..","..SNPsFTDNA..","..SNPsGeno2..","..SNPsSeqDotCom.."\n"
	f_5:write(m_6)

end
end

-- close file output
io.close(f_1)
io.close(f_2)
io.close(f_3)
io.close(f_4)
io.close(f_5)


