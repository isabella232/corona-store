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

-- Single Use VG
myStore.SINGLEUSEVG_CHOCOLATECAKE = soomla.createSingleUseVG({
	name = "Chocolate Cake",
	description = "A classic cake to maximize customer satisfaction",
	itemId = "chocolate_cake",
	purchase = {
		type = "virtualItem",
		exchangeCurrency = {
			itemId = myStore.CURRENCY_MUFFINS,
			amount = 250
		}
	}
})
print("SINGLE USE VG: " .. myStore.SINGLEUSEVG_CHOCOLATECAKE)


-- Lifetime VG
myStore.LIFETIMEVG_MARRIAGE = soomla.createLifetimeVG({
	name = "Marriage",
	description = "This is a lifetime thing",
	itemId = "marriage",
	purchase = {
		type = "market",
		product = {
			id = "com.mycompany.mygame.marriage",
			consumable = "consumable",
			price = 9.99
		}
	}

})
print("LIFETIME VG: " .. myStore.LIFETIMEVG_MARRIAGE)

-- Equippable VG
myStore.EQUIPPABLEVG_JERRY = soomla.createEquippableVG({
	name = "Jerry",
	description = "Your friend Jerry",
	itemId = "jerry",
	equipeModel = "category",
	purchase = {
		type = "virtualItem",
		exchangeCurrency = {
			id = "com.mycompany.mygame.jerry",
			amount = 250
		}
	}
})
print("EQUIPPABLE VG: " .. myStore.EQUIPPABLEVG_JERRY)

