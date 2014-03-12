local soomla = require "plugin.soomla"

local myStore = {}
myStore.version = 1

-- Virtual Currencies
myStore.CURRENCY_MUFFINS = soomla.createCurrency({
	name = "Muffins",
	description = "",
	itemId = "currency_muffins"
})
print("CURRENCY: " .. myStore.CURRENCY_MUFFINS)

-- Virtual Pack
myStore.CURRENCYPACK_MUFFINS10 = soomla.createCurrencyPack({
	name = "Muffins_10_Pack",
	description = "",
	itemId = "currencypack_muffins_10",
	currencyAmount = 10,
	currency = myStore.CURRENCY_MUFFINS,
	purchase = {
		type = "market",
		product = {
			id = "com.mycompany.mygame.muffins_10_pack",
			consumable = "consumable",
			price = 0.99
		}
	}
})
print("CURRENCY PACK: " .. myStore.CURRENCYPACK_MUFFINS10)