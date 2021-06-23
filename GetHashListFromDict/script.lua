function LoadFileData(file)
  local filehandle = assert(io.open(file, "r"),"io.open: Cannot open file to load: "..file)
  local data = assert(filehandle:read("a"),"read: cannot read file: "..file)
  filehandle:close()
  return data
end

HASH_DB = {}
dofile("MGS1-HASH-DICTIONARY.lua")
--dofile("MGS1-GCX-HASH-DATABASE.lua")


for i=1,#DICTIONARY,1 do
	print(i .. ": " .. DICTIONARY[i])
	os.execute([[MGS1-HASH-TOOL.exe ]] .. DICTIONARY[i] .. [[ > temp.txt]])
	HASH_DB[string.lower(LoadFileData("temp.txt"))]=DICTIONARY[i]
end




HASH_DB_STRING = "HASH_DB = {\n"
for i,v in pairs(HASH_DB) do
	local index = i
	if string.len(index) < 4 then
		index = string.rep("0",4-string.len(index)) .. index
	end
	HASH_DB_STRING = HASH_DB_STRING .. '\t["' .. index .. '"]=' .. '"' .. v .. '",\n'
end
HASH_DB_STRING = HASH_DB_STRING .. "}"

function WriteToFile(output, file)
  local filehandle = assert(io.open(file, "w"),"io.open: Cannot open file to write: "..file)
  if filehandle ~= nil then
    filehandle:write(output)
    filehandle:flush()
    filehandle:close()
  end
end

WriteToFile(HASH_DB_STRING, "MGS1-GCX-HASH-DATABASE.lua")