import urllib2
import re
import sys
import time
import csv
import HTMLParser
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
#	use this one to grab the version range 
#		http://docs.splunk.com/Documentation/ES/latest/RN/Enhancements

#	use this one for the pattern of version specific entries
#		http://docs.splunk.com/Documentation/ES/2.0/RN/Enhancements

min_version = "3.3.1"
max_version = "4.5.0"

url_part1 = "http://docs.splunk.com/Documentation/ES/"
url_part2 = "latest/RN/Enhancements"
url_part3b = "latest"
url_part4a = "/RN/Enhancements"
url_part4b = "/RN/FixedIssues"
url_part4c = "/RN/KnownIssues"
#
url1 = url_part1 + url_part2
#	url2 = enhancements_url
#	url3 = fixedissues_url
#	url4 = knownissues_url

page = urllib2.urlopen(url1)
page = page.read()

# Grab the version numbers
fileHandle = open('version.list', 'w')
#ops_table_divisions = re.findall(r"option value=\"(\w.*?)\"", page)
#ops_table_divisions = re.findall(r">(\w.*?)<", page)
ops_table_divisions = re.findall(">(\d+\.\d+\.?\w*)<", page)
sys.stdout = fileHandle
print ('%s' % (ops_table_divisions))
sys.stdout = sys.__stdout__
fileHandle.close()
# Clean up the version number list
fileHandle = open('version_list.csv', 'w')
filename = "version.list"
txt = open(filename)
sentence01 = txt.read()
sentence02 = " ".join(sentence01.split())
sentence03 = sentence02.replace("[", "")
sentence04 = sentence03.replace("]", "")
sentence05 = sentence04.replace(", ", ",")
sentence06 = sentence05.replace("'", "")
sentence07 = sentence06.replace(",", "\n")
sys.stdout = fileHandle
print ('%s' % (sentence07))
sys.stdout = sys.__stdout__
# Open the version number list and use to grab the release notes
fileHandle.close()
#
#view-source:http://docs.splunk.com/Documentation/ES/4.5.1/RN/FixedIssues
#
with open('version_list.csv', 'rb') as versionlist:
	for line in versionlist:
		url_part3a = line.rstrip('\r\n')
		if (url_part3a >= min_version) & (url_part3a <= max_version):
			url_parta = url_part1 + url_part3a
			url_partb = url_part4a
			fileHandleX = open("Enhancements_" + url_part3a + ".html", 'w')
			enhancements_url = url_parta + url_partb
			page = urllib2.urlopen(enhancements_url)
			page = page.read()
			fileHandleX.write(page)
			fileHandleX.close()
			
#			url_part3a = line.rstrip('\r\n')
#			url_parta = url_part1 + url_part3a
			url_partb = url_part4b
			fileHandleY = open("FixedIssues_" + url_part3a + ".html", 'w')
			enhancements_url = url_parta + url_partb
			page = urllib2.urlopen(enhancements_url)
			page = page.read()
			fileHandleY.write(page)
			fileHandleY.close()
			
#			url_part3a = line.rstrip('\r\n')
#			url_parta = url_part1 + url_part3a
			url_partb = url_part4c
			fileHandleZ = open("KnownIssues_" + url_part3a + ".html", 'w')
			enhancements_url = url_parta + url_partb
			page = urllib2.urlopen(enhancements_url)
			page = page.read()
			fileHandleZ.write(page)
			fileHandleZ.close()
		else:
			url_parta = url_part1 + url_part3b
			url_partb = url_part4a
			fileHandleX = open("Enhancements_" + url_part3b + ".html", 'w')
			enhancements_url = url_parta + url_partb
			page = urllib2.urlopen(enhancements_url)
			page = page.read()
			fileHandleX.write(page)
			fileHandleX.close()
			
#			url_part3b = line.rstrip('\r\n')
#			url_parta = url_part1 + url_part3b
			url_partb = url_part4b
			fileHandleY = open("FixedIssues_" + url_part3b + ".html", 'w')
			enhancements_url = url_parta + url_partb
			page = urllib2.urlopen(enhancements_url)
			page = page.read()
			fileHandleY.write(page)
			fileHandleY.close()
			
#			url_part3b = line.rstrip('\r\n')
#			url_parta = url_part1 + url_part3b
			url_partb = url_part4c
			fileHandleZ = open("KnownIssues_" + url_part3b + ".html", 'w')
			enhancements_url = url_parta + url_partb
			page = urllib2.urlopen(enhancements_url)
			page = page.read()
			fileHandleZ.write(page)
			fileHandleZ.close()
fileHandle.close()
