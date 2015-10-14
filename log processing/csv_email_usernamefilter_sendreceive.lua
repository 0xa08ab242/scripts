-- search username
nametofind = "jpittman"
nametofind = string.gsub (nametofind, "%f[%a]%u+%f[%A]", string.lower)

-- file output
outputfilename = "parsed_email_search_results-"..nametofind..".log"
f_1 = io.open(outputfilename, "a")
m_1 = "TimeValue,MessageID,SenderID,RecipientID,SubjectLine\n"
f_1:write(m_1)
-- TODO: improve search as a function
-- TODO: add search examples
-- TODO: add search input to external files or command line

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

-- semicolon ';' delimited field splitter
    function fromCSV2 (source2)
		-- ending semicolon
		source2 = source2 .. ';'
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
				fieldstart = string.find(source2, ';', i) + 1
			else
		-- unquoted; find next semicolon
				local nexti = string.find(source2, ';', fieldstart)
				table.insert(table2, string.sub(source2, fieldstart, nexti-1))
				fieldstart = nexti + 1
			end
		until fieldstart > string.len(source2)
		return table2
    end

-- amphora '@' delimited field splitter recipient
    function fromCSV3 (source3)
		-- ending amphora
		source3 = source3 .. '@'
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
				fieldstart = string.find(source3, '@', i) + 1
			else
		-- unquoted; find next amphora
				local nexti = string.find(source3, '@', fieldstart)
				table.insert(table3, string.sub(source3, fieldstart, nexti-1))
				fieldstart = nexti + 1
			end
		until fieldstart > string.len(source3)
		return table3
    end

-- amphora '@' delimited field splitter sender
    function fromCSV4 (source4)
		-- ending amphora
		source4 = source4 .. '@'
		-- table to collect fields
		local table4 = {}
		local fieldstart = 1
		repeat
		-- next field is quoted? (start with `"'?)
			if string.find(source4, '^"', fieldstart) then
				local a, c
				local i  = fieldstart
				repeat
		-- find closing quote
					a, i, c = string.find(source4, '"("?)', i+1)
		-- quote not followed by quote?
				until c ~= '"'
					if not i then
						error('unmatched "')
					end
					local f = string.sub(source4, fieldstart+1, i-1)
					table.insert(table4, (string.gsub(f, '""', '"')))
					fieldstart = string.find(source4, '@', i) + 1
			else
		-- unquoted; find next amphora
				local nexti = string.find(source4, '@', fieldstart)
				table.insert(table4, string.sub(source4, fieldstart, nexti-1))
				fieldstart = nexti + 1
			end
		until fieldstart > string.len(source4)
		return table4
    end

-- pattern searching text fields, recipient, sender, subject, etc.
	function fromField1 (source5, testvalue)
	--valid email test
		local table5 = {}
		if testvalue == nil then
			print("testvalue = nil")
			testvalue = " "
		end
		if source5 == nil then
			print("source5 = nil")
			source5 = " "
		end
		source5 = string.gsub (source5, "%f[%a]%u+%f[%A]", string.lower)
		local email=source5
--~ 		if (email:match("[A-Za-z0-9%.%%%+%-]+@[A-Za-z0-9%.%%%+%-]+%.%w%w%w?%w?")) then
--~ 			print(email .. " is a valid email address")
--~ 		else
--~ 			print(email .. " is not valid email address")
--~		string test returns numerical count of successful finds OR nil
--~ 		testsender = (string.find(SenderDomainName, "idahopower"))
--~ 		testrecipient1 = (string.find(RecipientDomainName, "idahopower"))
--~ 		testsubject = (string.find(SubjectLine, "Playboy"))
--~ 		end
			local output = (string.find(source5, testvalue))
		return output
	end

-- pattern searching text phonenumber from outbound text messages
	function fromField2 (source6)
	--valid email test
		local table6 = {}
		if source6 == nil then
			print("source6 = nil")
			source6 = " "
		end
--~ 		print(source6)
--~ 		print(string.len(source6))
--~ 		if string.len(source6) == 10 then
--~ 			i, j = string.find(source6, "%d%d%d%d%d%d%d%d%d%d")
--~ 			if i == 1 and j == 10 then
--~ 				local output = "("..string.sub(source6, 1, 3)..")"..string.sub(source6, 4, 6).."-"..string.sub(source6, 7, 10)
--~ 				table.insert(table6, "("..string.sub(source6, 1, 3)..")"..string.sub(source6, 4, 6).."-"..string.sub(source6, 7, 10))
--~ 				print(output)
--		source6 = string.gsub (source6, "%f[%a]%u+%f[%A]", string.lower)
--		local email=source6
--~ 		if (email:match("[A-Za-z0-9%.%%%+%-]+@[A-Za-z0-9%.%%%+%-]+%.%w%w%w?%w?")) then
--~ 			print(email .. " is a valid email address")
--~ 		else
--~ 			print(email .. " is not valid email address")
--~		string test returns numerical count of successful finds OR nil
--~ 		testsender = (string.find(SenderDomainName, "idahopower"))
--~ 		testrecipient1 = (string.find(RecipientDomainName, "idahopower"))
--~ 		testsubject = (string.find(SubjectLine, "Playboy"))
--~ 		end
--~ 			end
--~ 		end
		return table6
	end

-- file input
--	auto closes when complete
--	need to modify for command line input option

for line in io.lines("messages.log")
	do

-- apply fromCSV function to each line
	table1 = fromCSV1(line)

-- populate variables from table
	local TimeValue = 		table1[1]
--		print("Timevalue = "..TimeValue)
	local Client_IP = 		table1[2]
		if Client_IP == nil then
		Client_IP = " "
		end
	local Client_Name = 	table1[3]
		if Client_Name == nil then
		Client_Name = " "
		end
	local Server_IP =		table1[4]
		if Server_IP == nil then
		Server_IP = " "
		end
	local Server_Name = 	table1[5]
		if Server_Name == nil then
		Server_Name = " "
		end
	local SourceContext =	table1[6]
		if SourceContext == nil then
		SourceContext = " "
		end
	local ConnectorID =		table1[7]
		if ConnectorID == nil then
		ConnectorID = " "
		end
	local Source = 			table1[8]
		if Source == nil then
		Source = " "
		end
	local EventID =			table1[9]
		if EventID == nil then
		EventID = " "
		end
	local IntMessageID =	table1[10]
		if IntMessageID == nil then
		IntMessageID =  " "
		end
	local MessageID = 		table1[11]
		if MessageID == nil then
		MessageID = " "
		end
	local RecipientID = 	table1[12]
		if RecipientID == nil then
		RecipientID = " "
		end
	local RecipStatus =		table1[13]
		if RecipStatus == nil then
		RecipStatus = " "
		end
	local TotalBytes	= 	table1[14]
	if Total_Bytes == nil then
		Total_Bytes = 0
	end
	local RecipCount = 		table1[15]
	if RecipCount == nil then
			RecipCount = 0
	end
	local RelRecipAddr =	table1[16]
	if RelRecipAddr == nil then
		RelRecipAddr = " "
	end
	local Reference = 		table1[17]
	if Reference == nil then
		Reference = " "
	end
	local SubjectLine = 	table1[18]
	if SubjectLine == nil then
		SubjectLine = " "
	end
	local SenderID = 		table1[19]
	if SenderID == nil then
		SenderID = " "
	end
	local Return_Path =		table1[20]
	if Return_Path == nil then
		Return_Path = " "
	end
	local Message_Info =	table1[21]
	if Message_Info == nil then
		Message_Info = " "
	end

-- omit commented lines
	testcomment = (string.find(TimeValue, "#"))
if testcomment == nil then

-- modify search type by the EventID types
	counter = tonumber(RecipCount)
	if counter == nil then
		counter = 0
	elseif counter == 1 then
		table2 = fromCSV2(RecipientID)
		table3 = fromCSV3(RecipientID)
		local RecipientUserName =	table3[1]
		local RecipientDomainName =	table3[2]
		table4 = fromCSV4(SenderID)
		local SenderUserName =		table4[1]
		if SenderUserName == nil then
			SenderUserName = " "
		end
		local SenderDomainName =	table4[2]
		if SenderDomainName == nil then
			SenderDomainName = " "
		end
--		search for match
		local recipientsearch = string.gsub (RecipientUserName, "%f[%a]%u+%f[%A]", string.lower)
		local sendersearch = string.gsub (SenderID, "%f[%a]%u+%f[%A]", string.lower)
		local testrecipient = (string.find(recipientsearch, nametofind))
		local testsender = (string.find(sendersearch, nametofind))
		if (testrecipient ~= nil) or (testsender ~= nil) then
			m_8 = TimeValue..","..MessageID..","..SenderID..","..RecipientID..","..SubjectLine.."\n"
			f_1:write(m_8)
--~ print("found: "..SenderID..","..RecipientID.."\n")
		end
	elseif counter > 1 then
		while counter >= 1
			do
			table2 = fromCSV2(RecipientID)
			local RecipientID_alt = table2[counter]
			if RecipientID_alt == nil then
				RecipientID_alt = " "
			end
			table3 = fromCSV3(RecipientID_alt)
			local RecipientUserName =	table3[1]
			if RecipientUserName == nil then
				RecipientUserName = " "
			end
			local RecipientDomainName =	table3[2]
			if RecipientDomainName == nil then
				RecipientDomainName = " "
			end
			table4 = fromCSV4(SenderID)
			local SenderUserName =		table4[1]
			if SenderUserName == nil then
				SenderUserName = " "
			end
			local SenderDomainName =	table4[2]
			if SenderDomainName == nil then
				SenderDomainName = " "
			end
--		search for match
			local recipientsearch = string.gsub (RecipientUserName, "%f[%a]%u+%f[%A]", string.lower)
			local sendersearch = string.gsub (SenderUserName, "%f[%a]%u+%f[%A]", string.lower)
			local testrecipient = (string.find(recipientsearch, nametofind))
			local testsender = (string.find(sendersearch, nametofind))
			if (testrecipient ~= nil) or (testsender ~= nil) then
				m_12 = TimeValue..","..MessageID..","..SenderID..","..RecipientID_alt..","..SubjectLine.."\n"
				f_1:write(m_12)
--~ print("found: "..SenderID..","..RecipientID_alt.."\n")
			end
			counter = counter - 1
		end
	end
end
end

-- close file output
io.close(f_1)

