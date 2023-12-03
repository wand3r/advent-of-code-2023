local utils = require("./utils")

local inputFilePath = "./input.txt"
local inputFile = io.open(inputFilePath, "r")

if not inputFile then
	error('"' .. inputFilePath .. '" file not found')
end

local total = 0

---@type string
local line = inputFile:read("l")

while line do
	local firstDigit = utils.findFirstDigit(line)
	local lastDigit = utils.findLastDigit(line)
	local number = utils.mergeDigits(firstDigit, lastDigit)
	print(firstDigit, lastDigit, number)
	total = total + number
	line = inputFile:read("l")
end

print("Total value is: " .. total)

inputFile:close()
