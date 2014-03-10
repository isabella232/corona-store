local soomla = require "plugin.soomla"

local myStore = {}
myStore.version = 1

-- Virtual Currencies
myStore.CURRENCY_MUFFINS = soomla.createCurrency({
	name = "Muffins",
	description = "",
	itemId = "currency_muffins"
})

myStore.TEST = soomla.createCurrency({
	"testando",
	"dois dois",
	"3 tres",
	"4 x 4"
})

print(myStore.CURRENCY_MUFFINS)