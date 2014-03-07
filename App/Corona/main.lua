local soomla = require "plugin.soomla"

local result = soomla.sum(1,2)
print("1 + 2 = " .. result)

soomla.createCurrency({
	name = "Muffins",
	description = "",
	itemId = "currency_muffins",
	purchaseType = {
		name = "opa",
		description = "hey"
	},
	listener = function() end,
	id = 1
})