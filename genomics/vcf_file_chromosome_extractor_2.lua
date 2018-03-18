-- tested with
--	Dante Labs WGS 30x gVCF (conversion from BAM done by EVE app on sequencing.com [sam tools])
--	Family Tree DNA Biy-Y gVCF (conversion from BAM done by EVE app on sequencing.com [sam tools])
-- set the input file
inputfilename = "REPLACEME_WITH_FILENAME_TO_READ.vcf"
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
		-- ending tab
		source1 = source1 .. '\t'
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
				fieldstart = string.find(source1, '\t', i) + 1
			else
		-- unquoted; find next comma
				local nexti = string.find(source1, '\t', fieldstart)
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
	local CHROM = 	table1[1]
		if CHROM == nil then
		CHROM = " "
		end
	local POS = 	table1[2]
		if POS == nil then
		POS = " "
		end
	local ID = 		table1[3]
		if ID == nil then
		ID = " "
		end
	local REF =		table1[4]
		if REF == nil then
		REF = " "
		end
	local ALT = 	table1[5]
		if ALT == nil then
		ALT = " "
		end
	local QUAL =	table1[6]
		if QUAL == nil then
		QUAL = " "
		end
	local FILTER =	table1[7]
		if FILTER == nil then
		FILTER = " "
		end
	local INFO = 	table1[8]
		if INFO == nil then
		INFO = " "
		end
	local FORMAT =	table1[9]
		if FORMAT == nil then
		FORMAT = " "
		end
	local OTHER =	table1[10]
		if OTHER == nil then
		OTHER =  " "
		end
-- set local variables
local testcomment = (string.find(CHROM, "#"))
local testchr1 = (string.gmatch(CHROM, "chr1"))
local testchr2 = (string.gmatch(CHROM, "chr2"))
local testchr3 = (string.gmatch(CHROM, "chr3"))
local testchr4 = (string.gmatch(CHROM, "chr4"))
local testchr5 = (string.gmatch(CHROM, "chr5"))
local testchr6 = (string.gmatch(CHROM, "chr6"))
local testchr7 = (string.gmatch(CHROM, "chr7"))
local testchr8 = (string.gmatch(CHROM, "chr8"))
local testchr9 = (string.gmatch(CHROM, "chr9"))
local testchr10 = (string.gmatch(CHROM, "chr10"))
local testchr11 = (string.gmatch(CHROM, "chr11"))
local testchr12 = (string.gmatch(CHROM, "chr12"))
local testchr13 = (string.gmatch(CHROM, "chr13"))
local testchr14 = (string.gmatch(CHROM, "chr14"))
local testchr15 = (string.gmatch(CHROM, "chr15"))
local testchr16 = (string.gmatch(CHROM, "chr16"))
local testchr17 = (string.gmatch(CHROM, "chr17"))
local testchr18 = (string.gmatch(CHROM, "chr18"))
local testchr19 = (string.gmatch(CHROM, "chr19"))
local testchr20 = (string.gmatch(CHROM, "chr20"))
local testchr21 = (string.gmatch(CHROM, "chr21"))
local testchr22 = (string.gmatch(CHROM, "chr22"))
local testchrM = (string.gmatch(CHROM, "chrM"))
local testchrX = (string.gmatch(CHROM, "chrX"))
local testchrY = (string.gmatch(CHROM, "chrY"))
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
	print("now reading:"..CHROM.."\t"..POS.."\n")
-- extract CHROM specific values to the respective files and write out results
	elseif (testchr1 ~= nil) and (string.len(CHROM) == string.len("chr1")) then
		print("now reading:"..CHROM.."\t"..POS.."\n")
		m_1 = line.."\n"
		f_1:write(m_1)

	elseif (testchr2 ~= nil) and (string.len(CHROM) == string.len("chr2")) then
		print("now reading:"..CHROM.."\t"..POS.."\n")
		m_2 = line.."\n"
		f_2:write(m_2)

	elseif (testchr3 ~= nil) then
		print("now reading:"..CHROM.."\t"..POS.."\n")
		m_3 = line.."\n"
		f_3:write(m_3)

	elseif (testchr4 ~= nil) then
		print("now reading:"..CHROM.."\t"..POS.."\n")
		m_4 = line.."\n"
		f_4:write(m_4)

	elseif (testchr5 ~= nil) then
		print("now reading:"..CHROM.."\t"..POS.."\n")
		m_5 = line.."\n"
		f_5:write(m_5)

	elseif (testchr6 ~= nil) then
		print("now reading:"..CHROM.."\t"..POS.."\n")
		m_6 = line.."\n"
		f_6:write(m_6)

	elseif (testchr7 ~= nil) then
		print("now reading:"..CHROM.."\t"..POS.."\n")
		m_7 = line.."\n"
		f_7:write(m_7)

	elseif (testchr8 ~= nil) then
		print("now reading:"..CHROM.."\t"..POS.."\n")
		m_8 = line.."\n"
		f_8:write(m_8)

	elseif (testchr9 ~= nil) then
		print("now reading:"..CHROM.."\t"..POS.."\n")
		m_9 = line.."\n"
		f_9:write(m_9)

	elseif (testchr10 ~= nil) then
		print("now reading:"..CHROM.."\t"..POS.."\n")
		m_10 = line.."\n"
		f_10:write(m_10)

	elseif (testchr11 ~= nil) then
		print("now reading:"..CHROM.."\t"..POS.."\n")
		m_11 = line.."\n"
		f_11:write(m_11)

	elseif (testchr12 ~= nil) then
		print("now reading:"..CHROM.."\t"..POS.."\n")
		m_12 = line.."\n"
		f_12:write(m_12)

	elseif (testchr13 ~= nil) then
		print("now reading:"..CHROM.."\t"..POS.."\n")
		m_13 = line.."\n"
		f_13:write(m_13)

	elseif (testchr14 ~= nil) then
		print("now reading:"..CHROM.."\t"..POS.."\n")
		m_14 = line.."\n"
		f_14:write(m_14)

	elseif (testchr15 ~= nil) then
		print("now reading:"..CHROM.."\t"..POS.."\n")
		m_15 = line.."\n"
		f_15:write(m_15)

	elseif (testchr16 ~= nil) then
		print("now reading:"..CHROM.."\t"..POS.."\n")
		m_16 = line.."\n"
		f_16:write(m_16)

	elseif (testchr17 ~= nil) then
		print("now reading:"..CHROM.."\t"..POS.."\n")
		m_17 = line.."\n"
		f_17:write(m_17)

	elseif (testchr18 ~= nil) then
		print("now reading:"..CHROM.."\t"..POS.."\n")
		m_18 = line.."\n"
		f_18:write(m_18)

	elseif (testchr19 ~= nil) then
		print("now reading:"..CHROM.."\t"..POS.."\n")
		m_19 = line.."\n"
		f_19:write(m_19)

	elseif (testchr20 ~= nil) then
		print("now reading:"..CHROM.."\t"..POS.."\n")
		m_20 = line.."\n"
		f_20:write(m_20)

	elseif (testchr21 ~= nil) then
		print("now reading:"..CHROM.."\t"..POS.."\n")
		m_21 = line.."\n"
		f_21:write(m_21)

	elseif (testchr22 ~= nil) then
		print("now reading:"..CHROM.."\t"..POS.."\n")
		m_22 = line.."\n"
		f_22:write(m_22)

	elseif (testchrM ~= nil) then
		print("now reading:"..CHROM.."\t"..POS.."\n")
		m_M = line.."\n"
		f_M:write(m_M)

	elseif (testchrX ~= nil) then
		print("now reading:"..CHROM.."\t"..POS.."\n")
		m_X = line.."\n"
		f_X:write(m_X)

	elseif (testchrY ~= nil) then
		print("now reading:"..CHROM.."\t"..POS.."\n")
		m_Y = line.."\n"
		f_Y:write(m_Y)
	else
		print("now reading:"..CHROM.."\t"..POS.."\n")
		m_Z = line.."\n"
		f_Z:write(m_Z)

	end
end
-- close file output
io.close(f_1)
