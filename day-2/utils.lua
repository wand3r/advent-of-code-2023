local M = {}

---@param str string
---@param splitByPattern string
---@return string[]
M.splitBy = function(str, splitByPattern)
	---@type string[]
	local chunks = {}

	local previousPatternEnd = nil
	repeat
		local currentPatternStart, currentPatternEnd =
			str:find(splitByPattern, previousPatternEnd and previousPatternEnd + 1 or 0)
		local chunkStart = previousPatternEnd and previousPatternEnd + 1 or 1
		local chunkEnd = currentPatternStart and (currentPatternStart - 1) or #str
		local chunk = str:sub(chunkStart, chunkEnd)
		table.insert(chunks, chunk)
		previousPatternEnd = currentPatternEnd
	until not currentPatternStart
	return chunks
end

return M
