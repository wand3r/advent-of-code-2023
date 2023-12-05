local utils = require("./utils")
local M = {}

---@alias Game { id: number, subsets: Subset[] }
---@alias Subset { red: number?, green: number?, blue: number? }

---@param gameStr string in form of "Game 12: 1 green, 1 blue, 1 red; 1 green, 8 red, 7 blue; 6 blue, 10 red; 4 red, 9 blue, 2 green; 1 green, 3 blue; 4 red, 1 green, 10 blue"
---@return Game
M.parseWholeGame = function(gameStr)
	local gameSplit = utils.splitBy(gameStr, ":")
	---@type Game
	local game = {
		id = M.parseGameId(gameSplit[1]),
		subsets = M.parseGameSubsets(gameSplit[2]),
	}
	return game
end

---@param gameIdStr string
---@return number
M.parseGameId = function(gameIdStr)
	local _, _, idStr = gameIdStr:find("Game (%d+)")
	local id = tonumber(idStr)
	if not id then
		error("Invalid game id in string: " .. gameIdStr)
	end
	return id
end

---
---@param gameStr string in form of "1 green, 1 blue, 1 red; 1 green, 8 red, 7 blue; 6 blue, 10 red; 4 red, 9 blue, 2 green; 1 green, 3 blue; 4 red, 1 green, 10 blue"
---@return Subset[]
M.parseGameSubsets = function(gameStr)
	---@type Game
	local game = {}
	local subsetsSplit = utils.splitBy(gameStr, ";")
	for _, subsetStr in ipairs(subsetsSplit) do
		local subset = M.parseSubset(subsetStr)
		table.insert(game, subset)
	end
	return game
end

---@param subsets Subset[]
---@return boolean
M.areSubsetsValid = function(subsets)
	for _, subset in ipairs(subsets) do
		if not M.isSubsetValid(subset) then
			return false
		end
	end
	return true
end

---@param subsets Subset[]
M.findMinimumSet = function(subsets)
	---@type Subset
	local minimumSet = {
		red = nil,
		blue = nil,
		green = nil,
	}

	for _, subset in ipairs(subsets) do
		for color, value in pairs(subset) do
			if (minimumSet[color] or 0) < value then
				minimumSet[color] = value
			end
		end
	end

	return minimumSet
end

---@param cubesStr string in form of "1 green, 8 red, 7 blue"
---@return Subset
M.parseSubset = function(cubesStr)
	---@type Subset
	local subset = {}
	local cubesSplit = utils.splitBy(cubesStr, ",")
	for _, cubeStr in ipairs(cubesSplit) do
		local color, amount = M.parseCube(cubeStr)
		subset[color] = tonumber(amount)
	end
	return subset
end

local totalPerColor = {
	red = 12,
	green = 13,
	blue = 14,
}

---@param subset Subset
M.isSubsetValid = function(subset)
	for color, maxValue in pairs(totalPerColor) do
		if subset[color] and subset[color] > maxValue then
			return false
		end
	end
	return true
end

---@param cubeStr string in form of "10 blue"
---@return string, number
M.parseCube = function(cubeStr)
	local _, _, amountStr, color = cubeStr:find("(%d+) (%a+)")
	local amount = tonumber(amountStr) or 0
	return color, amount
end

return M
