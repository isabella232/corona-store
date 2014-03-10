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
	aew = "uhuuul",
	yeahyeah = {
		"nem que a vaca tussa"
	}
})

print(myStore.CURRENCY_MUFFINS)