Here are a few scripts that I initially wrote to extract specific chromosomes from much larger files using the VCF or gVCF format.

In their present version, they create one file per chromosome from the large VCF files
the header portion is copied to all files.

Except for the file from DNA Land, the other input files I have tested were created from the raw BAM files, instead of the prefiltered files provided by the respective vendors.

pending TODO list:
	consolidate the two Lua scripts into 1 that tests for both conditions
	convert the Lua script into other languages: (Perl, Python, etc.) - practice logic equivalence
	convert the script into other languages: (ASM, C/C++, Go, etc.) - practice speed optimization
