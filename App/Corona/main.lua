
local soomla = require "plugin.soomla"
local appId = "com.mycompany.mygame"

local myStore = {}

myStore.version = 1
myStore.SOOM_SEC = "MY SOOMLA SECURITY CODE"
myStore.CUSTOM_SECRET = "MY CUSTOM SECRET"

-- CURRENCIES
myStore.CURRENCY_MUFFINS_ID = soomla.createCurrency({
	name = "Muffins",
	description = "",
	itemId = "currency_muffins"
})

-- CURRENCY PACKS
myStore.CURRENCYPACK_MUFFINS_10_ID = soomla.createCurrencyPack({
	name = "10 Muffins",
	description = "A pack of 10 Muffins",
	itemId = "currencypack_muffins_10",
	currency = myStore.CURRENCY_MUFFINS_ID,
	currencyAmount = 10,
	purchase = {
		type = "market",
		product = { 
			id = appId .. ".muffinspack_10", 
			consumption = "consumable",
			price = 0.99
		}
	}
})

-- VIRTUAL GOODS
---- SINGLE USE VIRTUAL GOODS
myStore.SINGLEUSE_CHOCOLATECAKE_ID  = soomla.createSingleUseVG({
	name = "Chocolate Cake",
	description = "A classic cake to maximize customer satisfaction",
	itemId = "singleuse_chocolatecake",
	purchase = {
		type = "virtualItem",
		exchangeCurrency = {
			itemId = myStore.CURRENCY_MUFFINS_ID,
			amount = 250
		}
	}
})

---- LIFETIME VIRTUAL GOOD
myStore.LIFETIME_MARRIAGE_ID = soomla.createLifetimeVG({
	name = "Marriage",
	description = "This is a Lifetime thing",
	itemId = "lifetime_marriage",
	purchase = {
		type = "market",
		product = {
			id = appId .. ".lifetime_marriage",
			consumption = "nonConsumable",
			price = 9.99
		}
	}
})


---- EQUIPPABLE VIRTUAL GOOD
myStore.EQUIP_JERRY_ID = soomla.createEquippableVG({
	name = "Jerry",
	description = "Your friend Jerry",
	itemId = "equip_jerry",
	equipModel = "category",
	purchase = {
		type = "virtualItem",
		exchangeCurrency = {
			itemId = myStore.CURRENCY_MUFFINS_ID,
			amount = 250
		}
	}
})

---- SINGLE USE PACK VIRTUAL GOODS
myStore.SINGLEUSEPACK_CHOCOLATECAKE_20_ID = soomla.createSingleUsePackVG({
	name = "20 Chocolate Cakes",
	description = "A pack of 20 Chocolate Cakes",
	itemId = "singleusepack_chocolatecake_20",
	singleUseGood = myStore.SINGLEUSE_CHOCOLATECAKE_ID ,
	amount = 20,
	purchase = {
		type = "virtualItem",
		exchangeCurrency = {
			itemId = myStore.CURRENCY_MUFFINS_ID,
			amount = 35
		}
	}
})

---- UPGRADE VIRTUAL GOODS
myStore.LEVEL_1_ID = "mc1"

soomla.createUpgradeVG({
	name = "Level 1",
	description = "Muffin Cake Level 1",
	itemId = myStore.LEVEL_1_ID,
	linkedGood = myStore.SINGLEUSE_CHOCOLATECAKE_ID,
	previous = "",
	next = "",
	purchase = {
		type = "virtualItem",
		exchangeCurrency = {
			itemId = myStore.CURRENCY_MUFFINS_ID,
			amount = 50
		}
	}
})

---- NON CONSUMABLE ITENS
myStore.NONCONSUMABLE_NOADS = soomla.createNonConsumableItem({
	name = "No ads",
	description = "ADS no more!",
	itemId = "nonconsumable_noads",
	purchase = {
		type = "market",
		product = {
			id = appId .. ".noads",
			consumption = "nonConsumable",
			price = 1.99
		}
	}
})

---- VIRTUAL CATEGORIES
myStore.CATEGORY_MUFFINS = soomla.createCategory({
	name = "Muffins",
	items = { myStore.SINGLEUSE_CHOCOLATECAKE_ID }
})

myStore.CATEGORY_UPGRADES = soomla.createCategory({
	name = "Upgrades",
	items = { myStore.LEVEL_1_ID }
})

myStore.CATEGORY_CHARACTERS = soomla.createCategory({
	name = "Characters",
	items = { myStore.EQUIP_JERRY_ID }
})

myStore.CATEGORY_LIFETIME = soomla.createCategory({
	name = "Lifetime",
	items = { myStore.LIFETIME_MARRIAGE_ID }
})

myStore.CATEGORY_CHOCOLATEPACKS = soomla.createCategory({
	name = "Chocolate Cake Packs",
	items = { myStore.SINGLEUSEPACK_CHOCOLATECAKE_20_ID }
})

---- Initializing the store
myStore.virtualGoods = {
	myStore.SINGLEUSE_CHOCOLATECAKE_ID,
	myStore.SINGLEUSEPACK_CHOCOLATECAKE_20_ID,
	myStore.EQUIP_JERRY_ID,
	myStore.LIFETIME_MARRIAGE_ID,
	myStore.LEVEL_1_ID,
}

myStore.virtualCurrencies = {
	myStore.CURRENCY_MUFFINS_ID
}

myStore.virtualCurrencyPacks = {
	myStore.CURRENCYPACK_MUFFINS_10_ID
}

myStore.virtualCategories = {
	myStore.CATEGORY_CHOCOLATEPACKS, myStore.CATEGORY_MUFFINS, myStore.CATEGORY_CHARACTERS, myStore.CATEGORY_UPGRADES, myStore.CATEGORY_LIFETIME
}

myStore.nonConsumableItems = {
	myStore.NONCONSUMABLE_NOADS
}

soomla.initializeStore(myStore)