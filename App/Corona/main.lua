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
	equipModel = "category",
	purchase = {
		type = "virtualItem",
		exchangeCurrency = {
			itemId = myStore.CURRENCY_MUFFINS,
			amount = 250
		}
	}
})
print("EQUIPPABLE VG: " .. myStore.EQUIPPABLEVG_JERRY)

-- Single Use Pack VG
myStore.SINGLEUSEPACKVG_20_CHOCOLATECAKES = soomla.createSingleUsePackVG({
	name = "20 Chocolate Cakes",
	description = "A pack of 20 Chocolate Cakes",
	itemId = "20_chocolate_cake",
	singleUseGood = myStore.SINGLEUSEVG_CHOCOLATECAKE,
	amount = 20,
	purchase = {
		type = "virtualItem",
		exchangeCurrency = {
			itemId = myStore.CURRENCY_MUFFINS,
			amount = 34
		}
	}
})
print("SINGLE USE PACK VG: " .. myStore.SINGLEUSEPACKVG_20_CHOCOLATECAKES)

-- Upgrade VG
myStore.UPGRADEVG_LEVEL1 = soomla.createUpgradeVG({
	name = "Level 1",
	description = "Muffin Cake Level 1",
	itemId = "muffin_level_1",
	linkedGood = myStore.SINGLEUSEVG_CHOCOLATECAKE,
	previousUpgrade = "",
	nextUpgrade = "muffin_level_2",
	purchase = {
		type = "virtualItem",
		exchangeCurrency = {
			itemId = myStore.CURRENCY_MUFFINS,
			amount = 50
		}
	}
})
print("UPGRADE VG: " .. myStore.UPGRADEVG_LEVEL1)

-- Non consumable item
myStore.NONCONSUMABLE_NOADS = soomla.createNonConsumableItem({
	name = "No Ads",
	description = "No more ads",
	itemId = "no_ads",
	purchase = {
		type = "market",
		product = {
			id = "com.mycompany.mygame.noads",
			consumable = "nonConsumable",
			price = 1.99
		}
	}
})
print("NON CONSUMABLE ITEM: " .. myStore.NONCONSUMABLE_NOADS)

-- Virtual Category
myStore.CATEGORY_CAKES = soomla.createVirtualCategory({
	name = "Cakes",
	items = {
		myStore.SINGLEUSEVG_CHOCOLATECAKE,
		myStore.SINGLEUSEPACKVG_20_CHOCOLATECAKES,
		myStore.UPGRADEVG_LEVEL1
	}
})
print("VIRTUAL CATEGORY: " .. myStore.CATEGORY_CAKES)