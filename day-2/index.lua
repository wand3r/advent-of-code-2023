local gameUtils = require("./game")

local inputFilePath = "./input.txt"
local inputFile = io.open(inputFilePath, "r")

if not inputFile then
	error("Input file not found: " .. inputFilePath)
end

local sumOfValidGames = 0
local sumOfPowerOfMinimumSets = 0

local line = inputFile:read("l")

while line do
	local game = gameUtils.parseWholeGame(line)
	if gameUtils.areSubsetsValid(game.subsets) then
		sumOfValidGames = sumOfValidGames + game.id
	end

	local minimumSet = gameUtils.findMinimumSet(game.subsets)
	local powerOfMinimumSet = nil
	for _, value in pairs(minimumSet) do
		if value then
			powerOfMinimumSet = (powerOfMinimumSet or 1) * value
		else
			print("set without color " .. _)
		end
	end

	if not powerOfMinimumSet then
		print("set with no power!")
	end
	sumOfPowerOfMinimumSets = sumOfPowerOfMinimumSets + (powerOfMinimumSet or 0)
	line = inputFile:read("l")
end

print("Sum of all valid games is " .. sumOfValidGames)
print("Som of all powers of minimum sets is " .. sumOfPowerOfMinimumSets)
