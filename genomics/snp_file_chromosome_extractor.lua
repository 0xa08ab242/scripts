-- set the input file
inputfilename = "james_plus_inferred_from_parents.csv"
--~ input file Field Labels = "SNP_prefix,SNP_suffix,Chr,Pos,Allele1,Allele2,Zygosity,23andme,AncestryDNA,FTDNA,Geno2,SeqDotCom\n"
--~ input file Field Variable Labels = snp_prefix..","..snp_suffix..","..Chrid..","..Position..","..Allele1..","..Allele2..","..Zygosity..","..SNPs23andme..","..SNPsAncestry..","..SNPsFTDNA..","..SNPsGeno2..","..SNPsSeqDotCom.."\n"
-- set the output file names
outputfilename1 = "Chr1_extract_from_"..inputfilename
outputfilename2 = "Chr2_extract_from_"..inputfilename
outputfilename3 = "Chr3_extract_from_"..inputfilename
outputfilename4 = "Chr4_extract_from_"..inputfilename
outputfilename5 = "Chr5_extract_from_"..inputfilename
outputfilename6 = "Chr6_extract_from_"..inputfilename
outputfilename7 = "Chr7_extract_from_"..inputfilename
outputfilename8 = "Chr8_extract_from_"..inputfilename
outputfilename9 = "Chr9_extract_from_"..inputfilename
outputfilename10 = "Chr10_extract_from_"..inputfilename
outputfilename11 = "Chr11_extract_from_"..inputfilename
outputfilename12 = "Chr12_extract_from_"..inputfilename
outputfilename13 = "Chr13_extract_from_"..inputfilename
outputfilename14 = "Chr14_extract_from_"..inputfilename
outputfilename15 = "Chr15_extract_from_"..inputfilename
outputfilename16 = "Chr16_extract_from_"..inputfilename
outputfilename17 = "Chr17_extract_from_"..inputfilename
outputfilename18 = "Chr18_extract_from_"..inputfilename
outputfilename19 = "Chr19_extract_from_"..inputfilename
outputfilename20 = "Chr20_extract_from_"..inputfilename
outputfilename21 = "Chr21_extract_from_"..inputfilename
outputfilename22 = "Chr22_extract_from_"..inputfilename
outputfilenameM = "ChrM_extract_from_"..inputfilename
outputfilenameX = "ChrX_extract_from_"..inputfilename
outputfilenameY = "ChrY_extract_from_"..inputfilename
outputfilenameZ = "UNMATCHED_extract_from_"..inputfilename
-- open the output files
f_1 = io.open(outputfilename1, "a")
f_2 = io.open(outputfilename2, "a")
f_3 = io.open(outputfilename3, "a")
f_4 = io.open(outputfilename4, "a")
f_5 = io.open(outputfilename5, "a")
f_6 = io.open(outputfilename6, "a")
f_7 = io.open(outputfilename7, "a")
f_8 = io.open(outputfilename8, "a")
f_9 = io.open(outputfilename9, "a")
f_10 = io.open(outputfilename10, "a")
f_11 = io.open(outputfilename11, "a")
f_12 = io.open(outputfilename12, "a")
f_13 = io.open(outputfilename13, "a")
f_14 = io.open(outputfilename14, "a")
f_15 = io.open(outputfilename15, "a")
f_16 = io.open(outputfilename16, "a")
f_17 = io.open(outputfilename17, "a")
f_18 = io.open(outputfilename18, "a")
f_19 = io.open(outputfilename19, "a")
f_20 = io.open(outputfilename20, "a")
f_21 = io.open(outputfilename21, "a")
f_22 = io.open(outputfilename22, "a")
f_M = io.open(outputfilenameM, "a")
f_X = io.open(outputfilenameX, "a")
f_Y = io.open(outputfilenameY, "a")
f_Z = io.open(outputfilenameZ, "a")
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


for line in io.lines(inputfilename)
	do
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
	local Chr = 	table1[3]
		if Chr == nil then
		Chr = " "
		end
	local Pos = 	table1[4]
		if Pos == nil then
		Pos = " "
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

-- set local variables
local SNP_ID = SNP_prefix..SNP_suffix
local testcomment = (string.find(SNP_ID, "SNP_prefix"))
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
local testchrMT = (string.find(Chr, "MT"))
local testchrX = (string.find(Chr, "X"))
local testchrY = (string.find(Chr, "Y"))
-- prepend all files with commented lines
if testcomment ~= nil then
	print("found: "..line.."\n")
	m_c = line.."\n"
	f_1:write(m_c)
	f_2:write(m_c)
	f_3:write(m_c)
	f_4:write(m_c)
	f_5:write(m_c)
	f_6:write(m_c)
	f_7:write(m_c)
	f_8:write(m_c)
	f_9:write(m_c)
	f_10:write(m_c)
	f_11:write(m_c)
	f_12:write(m_c)
	f_13:write(m_c)
	f_14:write(m_c)
	f_15:write(m_c)
	f_16:write(m_c)
	f_17:write(m_c)
	f_18:write(m_c)
	f_19:write(m_c)
	f_20:write(m_c)
	f_21:write(m_c)
	f_22:write(m_c)
	f_M:write(m_c)
	f_X:write(m_c)
	f_Y:write(m_c)
	print("now reading:"..Chr.."\t"..SNP_ID.."\t"..Pos.."\t"..Allele1..Allele2.."\t"..Zygosity.."\t"..SNPs23andme.."\t"..SNPsAncestry.."\t"..SNPsFTDNA.."\t"..SNPsGeno2.."\t"..SNPsSeqDotCom.."\n")
-- extract Chr specific values to the respective files and write out results
	elseif (testchr1 ~= nil) and (string.len(Chr) == string.len("1")) then
		print("now reading:"..Chr.."\t"..SNP_ID.."\t"..Pos.."\t"..Allele1..Allele2.."\t"..Zygosity.."\t"..SNPs23andme.."\t"..SNPsAncestry.."\t"..SNPsFTDNA.."\t"..SNPsGeno2.."\t"..SNPsSeqDotCom.."\n")
		m_1 = line.."\n"
		f_1:write(m_1)

	elseif (testchr2 ~= nil) and (string.len(Chr) == string.len("2")) then
		print("now reading:"..Chr.."\t"..SNP_ID.."\t"..Pos.."\t"..Allele1..Allele2.."\t"..Zygosity.."\t"..SNPs23andme.."\t"..SNPsAncestry.."\t"..SNPsFTDNA.."\t"..SNPsGeno2.."\t"..SNPsSeqDotCom.."\n")
		m_2 = line.."\n"
		f_2:write(m_2)

	elseif (testchr3 ~= nil) and (string.len(Chr) == string.len("3")) then
		print("now reading:"..Chr.."\t"..SNP_ID.."\t"..Pos.."\t"..Allele1..Allele2.."\t"..Zygosity.."\t"..SNPs23andme.."\t"..SNPsAncestry.."\t"..SNPsFTDNA.."\t"..SNPsGeno2.."\t"..SNPsSeqDotCom.."\n")
		m_3 = line.."\n"
		f_3:write(m_3)

	elseif (testchr4 ~= nil) and (string.len(Chr) == string.len("4")) then
		print("now reading:"..Chr.."\t"..SNP_ID.."\t"..Pos.."\t"..Allele1..Allele2.."\t"..Zygosity.."\t"..SNPs23andme.."\t"..SNPsAncestry.."\t"..SNPsFTDNA.."\t"..SNPsGeno2.."\t"..SNPsSeqDotCom.."\n")
		m_4 = line.."\n"
		f_4:write(m_4)

	elseif (testchr5 ~= nil) and (string.len(Chr) == string.len("5")) then
		print("now reading:"..Chr.."\t"..SNP_ID.."\t"..Pos.."\t"..Allele1..Allele2.."\t"..Zygosity.."\t"..SNPs23andme.."\t"..SNPsAncestry.."\t"..SNPsFTDNA.."\t"..SNPsGeno2.."\t"..SNPsSeqDotCom.."\n")
		m_5 = line.."\n"
		f_5:write(m_5)

	elseif (testchr6 ~= nil) and (string.len(Chr) == string.len("6")) then
		print("now reading:"..Chr.."\t"..SNP_ID.."\t"..Pos.."\t"..Allele1..Allele2.."\t"..Zygosity.."\t"..SNPs23andme.."\t"..SNPsAncestry.."\t"..SNPsFTDNA.."\t"..SNPsGeno2.."\t"..SNPsSeqDotCom.."\n")
		m_6 = line.."\n"
		f_6:write(m_6)

	elseif (testchr7 ~= nil) and (string.len(Chr) == string.len("7")) then
		print("now reading:"..Chr.."\t"..SNP_ID.."\t"..Pos.."\t"..Allele1..Allele2.."\t"..Zygosity.."\t"..SNPs23andme.."\t"..SNPsAncestry.."\t"..SNPsFTDNA.."\t"..SNPsGeno2.."\t"..SNPsSeqDotCom.."\n")
		m_7 = line.."\n"
		f_7:write(m_7)

	elseif (testchr8 ~= nil) and (string.len(Chr) == string.len("8")) then
		print("now reading:"..Chr.."\t"..SNP_ID.."\t"..Pos.."\t"..Allele1..Allele2.."\t"..Zygosity.."\t"..SNPs23andme.."\t"..SNPsAncestry.."\t"..SNPsFTDNA.."\t"..SNPsGeno2.."\t"..SNPsSeqDotCom.."\n")
		m_8 = line.."\n"
		f_8:write(m_8)

	elseif (testchr9 ~= nil) and (string.len(Chr) == string.len("9")) then
		print("now reading:"..Chr.."\t"..SNP_ID.."\t"..Pos.."\t"..Allele1..Allele2.."\t"..Zygosity.."\t"..SNPs23andme.."\t"..SNPsAncestry.."\t"..SNPsFTDNA.."\t"..SNPsGeno2.."\t"..SNPsSeqDotCom.."\n")
		m_9 = line.."\n"
		f_9:write(m_9)

	elseif (testchr10 ~= nil) then
		print("now reading:"..Chr.."\t"..SNP_ID.."\t"..Pos.."\t"..Allele1..Allele2.."\t"..Zygosity.."\t"..SNPs23andme.."\t"..SNPsAncestry.."\t"..SNPsFTDNA.."\t"..SNPsGeno2.."\t"..SNPsSeqDotCom.."\n")
		m_10 = line.."\n"
		f_10:write(m_10)

	elseif (testchr11 ~= nil) then
		print("now reading:"..Chr.."\t"..SNP_ID.."\t"..Pos.."\t"..Allele1..Allele2.."\t"..Zygosity.."\t"..SNPs23andme.."\t"..SNPsAncestry.."\t"..SNPsFTDNA.."\t"..SNPsGeno2.."\t"..SNPsSeqDotCom.."\n")
		m_11 = line.."\n"
		f_11:write(m_11)

	elseif (testchr12 ~= nil) then
		print("now reading:"..Chr.."\t"..SNP_ID.."\t"..Pos.."\t"..Allele1..Allele2.."\t"..Zygosity.."\t"..SNPs23andme.."\t"..SNPsAncestry.."\t"..SNPsFTDNA.."\t"..SNPsGeno2.."\t"..SNPsSeqDotCom.."\n")
		m_12 = line.."\n"
		f_12:write(m_12)

	elseif (testchr13 ~= nil) then
		print("now reading:"..Chr.."\t"..SNP_ID.."\t"..Pos.."\t"..Allele1..Allele2.."\t"..Zygosity.."\t"..SNPs23andme.."\t"..SNPsAncestry.."\t"..SNPsFTDNA.."\t"..SNPsGeno2.."\t"..SNPsSeqDotCom.."\n")
		m_13 = line.."\n"
		f_13:write(m_13)

	elseif (testchr14 ~= nil) then
		print("now reading:"..Chr.."\t"..SNP_ID.."\t"..Pos.."\t"..Allele1..Allele2.."\t"..Zygosity.."\t"..SNPs23andme.."\t"..SNPsAncestry.."\t"..SNPsFTDNA.."\t"..SNPsGeno2.."\t"..SNPsSeqDotCom.."\n")
		m_14 = line.."\n"
		f_14:write(m_14)

	elseif (testchr15 ~= nil) then
		print("now reading:"..Chr.."\t"..SNP_ID.."\t"..Pos.."\t"..Allele1..Allele2.."\t"..Zygosity.."\t"..SNPs23andme.."\t"..SNPsAncestry.."\t"..SNPsFTDNA.."\t"..SNPsGeno2.."\t"..SNPsSeqDotCom.."\n")
		m_15 = line.."\n"
		f_15:write(m_15)

	elseif (testchr16 ~= nil) then
		print("now reading:"..Chr.."\t"..SNP_ID.."\t"..Pos.."\t"..Allele1..Allele2.."\t"..Zygosity.."\t"..SNPs23andme.."\t"..SNPsAncestry.."\t"..SNPsFTDNA.."\t"..SNPsGeno2.."\t"..SNPsSeqDotCom.."\n")
		m_16 = line.."\n"
		f_16:write(m_16)

	elseif (testchr17 ~= nil) then
		print("now reading:"..Chr.."\t"..SNP_ID.."\t"..Pos.."\t"..Allele1..Allele2.."\t"..Zygosity.."\t"..SNPs23andme.."\t"..SNPsAncestry.."\t"..SNPsFTDNA.."\t"..SNPsGeno2.."\t"..SNPsSeqDotCom.."\n")
		m_17 = line.."\n"
		f_17:write(m_17)

	elseif (testchr18 ~= nil) then
		print("now reading:"..Chr.."\t"..SNP_ID.."\t"..Pos.."\t"..Allele1..Allele2.."\t"..Zygosity.."\t"..SNPs23andme.."\t"..SNPsAncestry.."\t"..SNPsFTDNA.."\t"..SNPsGeno2.."\t"..SNPsSeqDotCom.."\n")
		m_18 = line.."\n"
		f_18:write(m_18)

	elseif (testchr19 ~= nil) then
		print("now reading:"..Chr.."\t"..SNP_ID.."\t"..Pos.."\t"..Allele1..Allele2.."\t"..Zygosity.."\t"..SNPs23andme.."\t"..SNPsAncestry.."\t"..SNPsFTDNA.."\t"..SNPsGeno2.."\t"..SNPsSeqDotCom.."\n")
		m_19 = line.."\n"
		f_19:write(m_19)

	elseif (testchr20 ~= nil) then
		print("now reading:"..Chr.."\t"..SNP_ID.."\t"..Pos.."\t"..Allele1..Allele2.."\t"..Zygosity.."\t"..SNPs23andme.."\t"..SNPsAncestry.."\t"..SNPsFTDNA.."\t"..SNPsGeno2.."\t"..SNPsSeqDotCom.."\n")
		m_20 = line.."\n"
		f_20:write(m_20)

	elseif (testchr21 ~= nil) then
		print("now reading:"..Chr.."\t"..SNP_ID.."\t"..Pos.."\t"..Allele1..Allele2.."\t"..Zygosity.."\t"..SNPs23andme.."\t"..SNPsAncestry.."\t"..SNPsFTDNA.."\t"..SNPsGeno2.."\t"..SNPsSeqDotCom.."\n")
		m_21 = line.."\n"
		f_21:write(m_21)

	elseif (testchr22 ~= nil) then
		print("now reading:"..Chr.."\t"..SNP_ID.."\t"..Pos.."\t"..Allele1..Allele2.."\t"..Zygosity.."\t"..SNPs23andme.."\t"..SNPsAncestry.."\t"..SNPsFTDNA.."\t"..SNPsGeno2.."\t"..SNPsSeqDotCom.."\n")
		m_22 = line.."\n"
		f_22:write(m_22)

	elseif (testchrMT ~= nil) then
		print("now reading:"..Chr.."\t"..SNP_ID.."\t"..Pos.."\t"..Allele1..Allele2.."\t"..Zygosity.."\t"..SNPs23andme.."\t"..SNPsAncestry.."\t"..SNPsFTDNA.."\t"..SNPsGeno2.."\t"..SNPsSeqDotCom.."\n")
		m_MT = line.."\n"
		f_M:write(m_MT)

	elseif (testchrX ~= nil) then
		print("now reading:"..Chr.."\t"..SNP_ID.."\t"..Pos.."\t"..Allele1..Allele2.."\t"..Zygosity.."\t"..SNPs23andme.."\t"..SNPsAncestry.."\t"..SNPsFTDNA.."\t"..SNPsGeno2.."\t"..SNPsSeqDotCom.."\n")
		m_X = line.."\n"
		f_X:write(m_X)

	elseif (testchrY ~= nil) then
		print("now reading:"..Chr.."\t"..SNP_ID.."\t"..Pos.."\t"..Allele1..Allele2.."\t"..Zygosity.."\t"..SNPs23andme.."\t"..SNPsAncestry.."\t"..SNPsFTDNA.."\t"..SNPsGeno2.."\t"..SNPsSeqDotCom.."\n")
		m_Y = line.."\n"
		f_Y:write(m_Y)
	else
		print("now reading:"..Chr.."\t"..SNP_ID.."\t"..Pos.."\t"..Allele1..Allele2.."\t"..Zygosity.."\t"..SNPs23andme.."\t"..SNPsAncestry.."\t"..SNPsFTDNA.."\t"..SNPsGeno2.."\t"..SNPsSeqDotCom.."\n")
		m_Z = line.."\n"
		f_Z:write(m_Z)

	end
end
-- close file output
io.close(f_1)
