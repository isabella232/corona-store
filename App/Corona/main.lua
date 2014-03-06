local soomla = require "plugin.soomla"

local result = soomla.sum(1,2)
print("1 + 2 = " .. result)

local function chronometerListener(event)
	print(event.name)
end
Runtime:addEventListener("soomla_chronometer",chronometerListener)

soomla.start()