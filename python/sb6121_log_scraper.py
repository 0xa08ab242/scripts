import urllib2
import re
import sys
import time
# The purpose of this script is to scape the logs from my cable-modem
#	in my case this is a Motorola Arris SB6121
#	it may work with few modifications on other SB61XX models
#
# Inspiration (giving credit)
#	inspired by the example shown here:
#	https://askubuntu.com/questions/350142/downloading-contents-of-the-web-page
#
# Present State
# 	grabs data and saves page to a temp file once per loop
#	temp file (.log) is read and most of the whitespace is stripped
#	delimiters are changed to commas in a single line of output
#	this is appended to the useful output file (.csv)
#
iterator = 0
#
while (iterator < 2000):
	#print "Start page 1\n"
	page = urllib2.urlopen("http://192.168.100.1/indexData.htm")
	page = page.read()
	fileHandle = open('cable-modem.log', 'w')
	ops_table_divisions = re.findall(r">(\w.*?)<", page)
	sys.stdout = fileHandle
	print ('%s' % (ops_table_divisions))
	sys.stdout = sys.__stdout__
	fileHandle.close()
	#print "EOF Page 1\n"
	#
	#print "Start page 2\n"
	page = urllib2.urlopen("http://192.168.100.1/cmSignalData.htm")
	page = page.read()
	fileHandle = open('cable-modem.log', 'a')
	sig_table_divisions = re.findall(r">(\w.*?)<", page)
	sys.stdout = fileHandle
	print ('%s' % (sig_table_divisions))
	sys.stdout = sys.__stdout__
	fileHandle.close() 
	#print "EOF Page 2\n"
	#
	#print "Start page 3\n"
	page = urllib2.urlopen("http://192.168.100.1/cmLogsData.htm")
	page = page.read()
	fileHandle = open('cable-modem.log', 'a')
	log_table_divisions = re.findall(r">(\w.*?)<", page)
	sys.stdout = fileHandle
	print ('%s' % (log_table_divisions))
	sys.stdout = sys.__stdout__
	fileHandle.close() 
	# open file, clean it, and output to new file
	fileHandle = open('cable-modem.csv', 'a')
	filename = "cable-modem.log"
	txt = open(filename)
	sentence01 = txt.read()
	sentence02 = " ".join(sentence01.split())
	sentence03 = sentence02.replace("[", "")
	sentence04 = sentence03.replace("]", "")
	sentence05 = sentence04.replace("&nbsp;", "")
	sentence06 = sentence05.replace(";", ",")
	sentence07 = sentence06.replace(" - ", ",")
	sentence08 = sentence07.replace(", ", ",")
	sentence09 = sentence08.replace(" ,", ",")	
	sentence10 = sentence09.replace("'", "")
	sentence11 = sentence10.replace(",,", ",")	
	sys.stdout = fileHandle
	print ('%s' % (sentence11))
	sys.stdout = sys.__stdout__
	fileHandle.close() 
	#print "EOF Page 3\n"
	time.sleep(60)
	iterator = iterator + 1
#while loop ends here
