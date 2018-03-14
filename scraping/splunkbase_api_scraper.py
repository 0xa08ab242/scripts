import json
import urllib2
import sys
###############################################################################
# The purpose of this script is to scape the apps from splunkbase
#	using the API located here
#
# Present State
#   third draft - iterate through apps by number from 1 - 3400 on splunkbase
#       the first draft worked well enough to iterate through apps 1 thru 9352
#       adjusted the upper bound of the iterator for subsequent runs
#       adjusted the header to print only once
#       explicitly added newline characters to data in
#       added secondary file to cleanup the output for viewing in excel
#       modified the script to handle the use of multiple file opens/closes
#       cleaned up output, removed a few fields and extra newlines
#
#   test results:
#        1 thru 3400 - approximately 25 minute runtime
#        10/19/2016
#        start time 9:57 am
#        stop time 10:23 am
#           the newest app UID was 3361 (3 more than the prior day)
#           at an assumed average rate of 3 apps per day,
#           and given the 39 slots until 3400,
#           the max limit will need to be increased in 13 days
#           this will increase the runtime as follows:
#           3400 apps and 25 minute is approximately 136 apps per minute
#           an increase to 3500 should take between 26 and 27 minutes
#
#   next steps - test for regular output
#
###############################################################################
# Variables for setting the range of app UIDs to search
min_val = 1
max_val = 3400
###############################################################################
# Constants
file_part1 = "splunkbase_search_"
file_part2 = "_thru_"
file_part3 = ".txt"
file_part4 = ".csv"
#
txtfilename = file_part1 + str(min_val) + file_part2 + str(max_val) + file_part3
csvfilename = file_part1 + str(min_val) + file_part2 + str(max_val) + file_part4
iterator = min_val
###############################################################################
##  Subroutine 1
#   Request app information via the API and write to a txt file
#   open the text file for writing
fileHandle1 = open(txtfilename,'w')
#   write the headers for the file columns where data about the app exists
print >> fileHandle1, "uid,appid,title,updated_time,type,access,cert_status,support,creator_username,download_count"
#   begin the request loop
while (iterator < max_val):
#   construct the request
    part_1 = "https://splunkbase.splunk.com/api/v1/app/"
    part_2 = str(iterator)
    part_3 = "/?include=releases,releases.splunk_compatibility,created_by,support"
    url_to_query = part_1 + part_2 + part_3
#   submit the request and write data when the app does exist
    try:
        req = urllib2.Request(url_to_query)
        response = urllib2.urlopen(req)
        data = json.load(urllib2.urlopen(url_to_query))
        print >> fileHandle1, data['uid'],",",data['appid'],",",data['title'],",",data['updated_time'],",",data['type'],",",data['access'],",",data['cert_status'],",",data['support'],",",data['created_by']['username'],",",data['download_count']
#   handle and write errors where the app does not exist
    except urllib2.HTTPError as e:
        error_message = e.read()
        err_data = json.loads(error_message)
        print >> fileHandle1, iterator,",",err_data['errors'][0]
    iterator = iterator + 1
#   close the file handle and write the txt file to disk
fileHandle1.close()
#   End Subroutine 1
###############################################################################
##  Subroutine 2
#   Remove extra spaces from the original pull and output as a csv
fileHandle2 = open(csvfilename, 'w')
txt = open(txtfilename)
sentence01 = txt.read()
sentence02 = sentence01.replace(" , ", ",")
sentence03 = sentence02.replace(" ,\n", "\n")
sys.stdout = fileHandle2
print ('%s' % (sentence03))
sys.stdout = sys.__stdout__
fileHandle2.close() 
#   End Subroutine 2
###############################################################################
# EOF