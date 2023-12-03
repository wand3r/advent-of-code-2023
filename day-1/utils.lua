local M = {}

---@param a number?
---@param b number?
---@return number
M.mergeDigits = function(a, b)
	return tonumber((a or "") .. (b or "")) or 0
end

local wordedDigits = {
	"one",
	"two",
	"three",
	"four",
	"five",
	"six",
	"seven",
	"eight",
	"nine",
}

---@param str string
---@return number
M.findFirstDigit = function(str)
	---@type number?
	local result = nil

	local resultStart = str:find("%d")
	if resultStart then
		result = tonumber(str:sub(resultStart, resultStart))
	end

	for key, value in pairs(wordedDigits) do
		local wordedDigitStart = str:find(value)
		if not resultStart and wordedDigitStart then
			resultStart = wordedDigitStart
			result = key
		elseif wordedDigitStart and wordedDigitStart < resultStart then
			resultStart = wordedDigitStart
			result = key
		end
	end

	if not result then
		error("Digit not found in string: " .. str)
	end
	return result
end

---@param str string
---@return number
M.findLastDigit = function(str)
	str = str:reverse()
	---@type number?
	local result = nil

	local resultStart = str:find("%d")
	if resultStart then
		result = tonumber(str:sub(resultStart, resultStart))
	end

	for key, value in pairs(wordedDigits) do
		value = value:reverse()
		local wordedDigitStart = str:find(value)
		if not resultStart and wordedDigitStart then
			resultStart = wordedDigitStart
			result = key
		elseif wordedDigitStart and wordedDigitStart < resultStart then
			resultStart = wordedDigitStart
			result = key
		end
	end

	if not result then
		error("Digit not found in string: " .. str)
	end
	return result
end

return M
