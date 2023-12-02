local M = {}

---@param str string
---@return number?, number?
M.getFirstAndLastDigit = function(str)
	---@type number?
	local firstDigit = nil
	---@type number?
	local lastDigit = nil

	for char in str:gmatch("%d") do
		if not firstDigit then
			firstDigit = tonumber(char)
		end
		lastDigit = tonumber(char)
	end

	return firstDigit, lastDigit
end

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
M.normalizeDigits = function(str)
	local result = str
	for digit, wordedDigit in pairs(wordedDigits) do
		result = M.stringReplaceAll(result, wordedDigit, tostring(digit))
	end
	return result
end

---@param str string
---@param searchFor string
---@param replaceWith string
M.stringReplaceAll = function(str, searchFor, replaceWith)
	local result = str
	local from, to = result:find(searchFor)
	while from and to do
		result = result:sub(0, from - 1) .. replaceWith .. result:sub(to + 1, #result)
		from, to = result:find(searchFor)
	end
	return result
end

return M
