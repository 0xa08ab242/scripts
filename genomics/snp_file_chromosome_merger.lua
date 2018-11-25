-- set the input file
personname = "james"
filenamepart = "plus_inferred_from_parents"
filenamesuffix = "sorted"
outputfilename = personname.."_"..filenamepart.."_"..filenamesuffix..".csv"
inputfilenamepart = personname.."_"..filenamepart..".csv"
--~ input file Field Labels = "SNP_prefix,SNP_suffix,Chr,Pos,Allele1,Allele2,Zygosity,23andme,AncestryDNA,FTDNA,Geno2,SeqDotCom\n"
--~ input file Field Variable Labels = snp_prefix..","..snp_suffix..","..Chrid..","..Position..","..Allele1..","..Allele2..","..Zygosity..","..SNPs23andme..","..SNPsAncestry..","..SNPsFTDNA..","..SNPsGeno2..","..SNPsSeqDotCom.."\n"
-- set the output file names
inputfilename1 = "Chr1_extract_from_"..inputfilenamepart
inputfilename2 = "Chr2_extract_from_"..inputfilenamepart
inputfilename3 = "Chr3_extract_from_"..inputfilenamepart
inputfilename4 = "Chr4_extract_from_"..inputfilenamepart
inputfilename5 = "Chr5_extract_from_"..inputfilenamepart
inputfilename6 = "Chr6_extract_from_"..inputfilenamepart
inputfilename7 = "Chr7_extract_from_"..inputfilenamepart
inputfilename8 = "Chr8_extract_from_"..inputfilenamepart
inputfilename9 = "Chr9_extract_from_"..inputfilenamepart
inputfilename10 = "Chr10_extract_from_"..inputfilenamepart
inputfilename11 = "Chr11_extract_from_"..inputfilenamepart
inputfilename12 = "Chr12_extract_from_"..inputfilenamepart
inputfilename13 = "Chr13_extract_from_"..inputfilenamepart
inputfilename14 = "Chr14_extract_from_"..inputfilenamepart
inputfilename15 = "Chr15_extract_from_"..inputfilenamepart
inputfilename16 = "Chr16_extract_from_"..inputfilenamepart
inputfilename17 = "Chr17_extract_from_"..inputfilenamepart
inputfilename18 = "Chr18_extract_from_"..inputfilenamepart
inputfilename19 = "Chr19_extract_from_"..inputfilenamepart
inputfilename20 = "Chr20_extract_from_"..inputfilenamepart
inputfilename21 = "Chr21_extract_from_"..inputfilenamepart
inputfilename22 = "Chr22_extract_from_"..inputfilenamepart
inputfilenameM = "ChrM_extract_from_"..inputfilenamepart
inputfilenameX = "ChrX_extract_from_"..inputfilenamepart
inputfilenameY = "ChrY_extract_from_"..inputfilenamepart

-- open the output files
f_1 = io.open(outputfilename, "a")

-- read the input files
for line in io.lines(inputfilename1)
	do
	print("now reading: "..line.."\n")
	m_1 = line.."\n"
	f_1:write(m_1)
	end


for line in io.lines(inputfilename2)
	do
	print("now reading: "..line.."\n")
	m_1 = line.."\n"
	f_1:write(m_1)
	end


for line in io.lines(inputfilename3)
	do
	print("now reading: "..line.."\n")
	m_1 = line.."\n"
	f_1:write(m_1)
	end


for line in io.lines(inputfilename4)
	do
	print("now reading: "..line.."\n")
	m_1 = line.."\n"
	f_1:write(m_1)
	end


for line in io.lines(inputfilename5)
	do
	print("now reading: "..line.."\n")
	m_1 = line.."\n"
	f_1:write(m_1)
	end


for line in io.lines(inputfilename6)
	do
	print("now reading: "..line.."\n")
	m_1 = line.."\n"
	f_1:write(m_1)
	end


for line in io.lines(inputfilename7)
	do
	print("now reading: "..line.."\n")
	m_1 = line.."\n"
	f_1:write(m_1)
	end


for line in io.lines(inputfilename8)
	do
	print("now reading: "..line.."\n")
	m_1 = line.."\n"
	f_1:write(m_1)
	end


for line in io.lines(inputfilename9)
	do
	print("now reading: "..line.."\n")
	m_1 = line.."\n"
	f_1:write(m_1)
	end


for line in io.lines(inputfilename10)
	do
	print("now reading: "..line.."\n")
	m_1 = line.."\n"
	f_1:write(m_1)
	end


for line in io.lines(inputfilename11)
	do
	print("now reading: "..line.."\n")
	m_1 = line.."\n"
	f_1:write(m_1)
	end


for line in io.lines(inputfilename12)
	do
	print("now reading: "..line.."\n")
	m_1 = line.."\n"
	f_1:write(m_1)
	end


for line in io.lines(inputfilename13)
	do
	print("now reading: "..line.."\n")
	m_1 = line.."\n"
	f_1:write(m_1)
	end


for line in io.lines(inputfilename14)
	do
	print("now reading: "..line.."\n")
	m_1 = line.."\n"
	f_1:write(m_1)
	end


for line in io.lines(inputfilename15)
	do
	print("now reading: "..line.."\n")
	m_1 = line.."\n"
	f_1:write(m_1)
	end


for line in io.lines(inputfilename16)
	do
	print("now reading: "..line.."\n")
	m_1 = line.."\n"
	f_1:write(m_1)
	end


for line in io.lines(inputfilename17)
	do
	print("now reading: "..line.."\n")
	m_1 = line.."\n"
	f_1:write(m_1)
	end


for line in io.lines(inputfilename18)
	do
	print("now reading: "..line.."\n")
	m_1 = line.."\n"
	f_1:write(m_1)
	end


for line in io.lines(inputfilename19)
	do
	print("now reading: "..line.."\n")
	m_1 = line.."\n"
	f_1:write(m_1)
	end


for line in io.lines(inputfilename20)
	do
	print("now reading: "..line.."\n")
	m_1 = line.."\n"
	f_1:write(m_1)
	end


for line in io.lines(inputfilename21)
	do
	print("now reading: "..line.."\n")
	m_1 = line.."\n"
	f_1:write(m_1)
	end


for line in io.lines(inputfilename22)
	do
	print("now reading: "..line.."\n")
	m_1 = line.."\n"
	f_1:write(m_1)
	end


for line in io.lines(inputfilenameX)
	do
	print("now reading: "..line.."\n")
	m_1 = line.."\n"
	f_1:write(m_1)
	end


for line in io.lines(inputfilenameY)
	do
	print("now reading: "..line.."\n")
	m_1 = line.."\n"
	f_1:write(m_1)
	end


for line in io.lines(inputfilenameM)
	do
	print("now reading: "..line.."\n")
	m_1 = line.."\n"
	f_1:write(m_1)
	end

-- close file output
io.close(f_1)
