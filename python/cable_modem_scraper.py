import urllib2
import re
import sys
import time
#
# Inspiration (giving credit)
#	inspired by the example shown here:
#	https://askubuntu.com/questions/350142/downloading-contents-of-the-web-page
#
# Unaddressed brainstorming notes (possible TODO list)
#	content headers will remain constant and can serve as additional re targets
#	rewrite the content into a more useful format - perhaps json
#	possible visualizations include signal quality timeline chart
#	possible analytics include signal quality correlated to error messages
#	periodicity of sampling is a black box - not sure how often the data updates
#	how to append logs to a single location but not duplicate the content
#	possibly search on the date-time stamp, except for the reset logs...
#
# Present State
# 	grabs data
#	each page is a separate file
#	need to recrate the table structure from the csv
#	need to remove the leading and trailing braces
#
# TODO
#	remove trailing newline in operations.log
#	remove trailing &nbsp; on numerical values
#	split output into table row format
#	join signal log tables into a single table, removing duplicate items
#	format output for analysis
#
iterator = 0
#
while (iterator < 2000):
	#print "Start page 1\n"
	page = urllib2.urlopen("http://192.168.100.1/indexData.htm")
	page = page.read()
	fileHandle = open('operations.log', 'a')
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
	fileHandle = open('signal.log', 'a')
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
	fileHandle = open('errorlog.log', 'a')
	log_table_divisions = re.findall(r">(\w.*?)<", page)
	sys.stdout = fileHandle
	print ('%s' % (log_table_divisions))
	sys.stdout = sys.__stdout__
	fileHandle.close() 
	#print "EOF Page 3\n"
	time.sleep(60)
	iterator = iterator + 1
#while loop ends here