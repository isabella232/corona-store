
local soomla = require "plugin.soomla"
local appId = "com.mycompany.mygame"

local myStore = {}

myStore.version = 1
myStore.SOOM_SEC = "MY SOOMLA SECURITY CODE"
myStore.CUSTOM_SECRET = "MY CUSTOM SECRET"

-- CURRENCIES
myStore.CURRENCY_MUFFINS = soomla.createCurrency({
	name = "Muffins",
	description = "",
	itemId = "currency_muffins"
})

-- CURRENCY PACKS
myStore.CURRENCYPACK_MUFFINS_10 = soomla.createCurrencyPack({
	name = "10 Muffins",
	description = "A pack of 10 Muffins",
	itemId = "currencypack_muffins_10",
	currency = myStore.CURRENCY_MUFFINS,
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

myStore.CURRENCYPACK_MUFFINS_50 = soomla.createCurrencyPack({
	name = "50 Muffins",
	description = "A pack of 50 Muffins",
	itemId = "currencypack_muffins_50",
	currency = myStore.CURRENCY_MUFFINS,
	currencyAmount = 50,
	purchase = {
		type = "market",
		product = { 
			id = appId .. ".muffinspack_50", 
			consumption = "consumable",
			price = 1.99
		}
	}
})

myStore.CURRENCYPACK_MUFFINS_400 = soomla.createCurrencyPack({
	name = "400 Muffins",
	description = "A pack of 400 Muffins",
	itemId = "currencypack_muffins_400",
	currency = myStore.CURRENCY_MUFFINS,
	amount = 400,
	purchase = {
		type = "market",
		product = { 
			id = appId .. ".muffinspack_400", 
			consumption = "consumable",
			price = 2.99
		}
	}
})

myStore.CURRENCYPACK_MUFFINS_1000 = soomla.createCurrencyPack({
	name = "1000 Muffins",
	description = "A pack of 1000 Muffins",
	itemId = "currencypack_muffins_1000",
	currency = myStore.CURRENCY_MUFFINS,
	currencyAmount = 1000,
	purchase = {
		type = "market",
		product = { 
			id = appId .. ".muffinspack_1000", 
			consumption = "consumable",
			price = 3.99
		}
	}
})

-- VIRTUAL GOODS
---- SINGLE USE VIRTUAL GOODS
myStore.SINGLEUSE_CHOCOLATECAKE = soomla.createSingleUseVG({
	name = "Chocolate Cake",
	description = "A classic cake to maximize customer satisfaction",
	itemId = "singleuse_chocolatecake",
	purchase = {
		type = "virtualItem",
		exchangeCurrency = {
			itemId = myStore.CURRENCY_MUFFINS,
			amount = 250
		}
	}
})

myStore.SINGLEUSE_CREAMCUP = soomla.createSingleUseVG({
	name = "Cream Cup",
	description = "Increase bakery reputation with this original pastry",
	itemId = "singleuse_creamcup",
	purchase = {
		type = "virtualItem",
		exchangeCurrency = {
			itemId = myStore.CURRENCY_MUFFINS,
			amount = 50
		}
	}
})

myStore.SINGLEUSE_MUFFINCAKE = soomla.createSingleUseVG({
	name = "Muffin Cake",
	description = "Customers buy a double portion on each purchase of this cake",
	itemId = "singleuse_muffincake",
	purchase = {
		type = "virtualItem",
		exchangeCurrency = {
			itemId = myStore.CURRENCY_MUFFINS,
			amount = 225
		}
	}
})

myStore.SINGLEUSE_PAVLOVA = soomla.createSingleUseVG({
	name = "Pavlova",
	description = "Gives customers a sugar rush and they call their friends",
	itemId = "singleuse_pavlova",
	purchase = {
		type = "virtualItem",
		exchangeCurrency = {
			itemId = myStore.CURRENCY_MUFFINS,
			amount = 175
		}
	}
})


---- LIFETIME VIRTUAL GOOD
myStore.LIFETIME_MARRIAGE = soomla.createLifetimeVG({
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
myStore.EQUIP_JERRY = soomla.createEquippableVG({
	name = "Jerry",
	description = "Your friend Jerry",
	itemId = "equip_jerry",
	equipModel = "category",
	purchase = {
		type = "virtualItem",
		exchangeCurrency = {
			itemId = myStore.CURRENCY_MUFFINS,
			amount = 250
		}
	}
})


myStore.EQUIP_GEORGE = soomla.createEquippableVG({
	name = "George",
	description = "The best muffin eater in the north",
	itemId = "equip_george",
	equipModel = "category",
	purchase = {
		type = "virtualItem",
		exchangeCurrency = {
			itemId = myStore.CURRENCY_MUFFINS,
			amount = 350
		}
	}
})

myStore.EQUIP_KRAMER = soomla.createEquippableVG({
	name = "Kramer",
	description = "Knows how to get muffins",
	itemId = "equip_kramer",
	equipModel = "category",
	purchase = {
		type = "virtualItem",
		exchangeCurrency = {
			itemId = myStore.CURRENCY_MUFFINS,
			amount = 400
		}
	}
})

myStore.EQUIP_ELAINE = soomla.createEquippableVG({
	name = "Elain",
	description = "Kicks muffins like a boss",
	itemId = "equip_elaine",
	equipModel = "category",
	purchase = {
		type = "virtualItem",
		exchangeCurrency = {
			itemId = myStore.CURRENCY_MUFFINS,
			amount = 450
		}
	}
})

---- SINGLE USE PACK VIRTUAL GOODS
myStore.SINGLEUSEPACK_CHOCOLATECAKE_20 = soomla.createSingleUsePackVG({
	name = "20 Chocolate Cakes",
	description = "A pack of 20 Chocolate Cakes",
	itemId = "singleusepack_chocolatecake_20",
	singleUseGood = myStore.SINGLEUSE_CHOCOLATECAKE,
	amount = 20,
	purchase = {
		type = "virtualItem",
		exchangeCurrency = {
			itemId = myStore.CURRENCY_MUFFINS,
			amount = 35
		}
	}
})

myStore.SINGLEUSEPACK_CHOCOLATECAKE_50 = soomla.createSingleUsePackVG({
	name = "50 Chocolate Cakes",
	description = "A pack of 50 Chocolate Cakes",
	itemId = "singleusepack_chocolatecake_50",
	singleUseGood = myStore.SINGLEUSE_CHOCOLATECAKE,
	amount = 50,
	purchase = {
		type = "virtualItem",
		exchangeCurrency = {
			itemId = myStore.CURRENCY_MUFFINS,
			amount = 50
		}
	}
})

myStore.SINGLEUSEPACK_CHOCOLATECAKE_100 = soomla.createSingleUsePackVG({
	name = "100 Chocolate Cakes",
	description = "A pack of 100 Chocolate Cakes",
	itemId = "singleusepack_chocolatecake_100",
	singleUseGood = myStore.SINGLEUSE_CHOCOLATECAKE,
	amount = 100,
	purchase = {
		type = "virtualItem",
		exchangeCurrency = {
			itemId = myStore.CURRENCY_MUFFINS,
			amount = 70
		}
	}
})


myStore.SINGLEUSEPACK_CHOCOLATECAKE_200 = soomla.createSingleUsePackVG({
	name = "200 Chocolate Cakes",
	description = "A pack of 200 Chocolate Cakes",
	itemId = "singleusepack_chocolatecake_200",
	singleUseGood = myStore.SINGLEUSE_CHOCOLATECAKE,
	amount = 200,
	purchase = {
		type = "virtualItem",
		exchangeCurrency = {
			itemId = myStore.CURRENCY_MUFFINS,
			amount = 100
		}
	}
})

---- UPGRADE VIRTUAL GOODS
--[[ 
	You can create the virtual items / categories / currencies in two ways:
 		- Make the id variables receive the return of the creation function
 		- Create the id variables before, and then use them on the table

 	Since we should use the upgrades' itemId to define the next and previous upgrades, we prefer to use the second approach to the upgrades
 ]]--
myStore.LEVEL_1 = "mc1"
myStore.LEVEL_2 = "mc2"
myStore.LEVEL_3 = "mc3"
myStore.LEVEL_4 = "mc4"
myStore.LEVEL_5 = "mc5"
myStore.LEVEL_6 = "mc6"

soomla.createUpgradeVG({
	name = "Level 1",
	description = "Muffin Cake Level 1",
	itemId = myStore.LEVEL_1,
	linkedGood = myStore.SINGLEUSE_MUFFINCAKE,
	previous = "",
	next = myStore.LEVEL_2,
	purchase = {
		type = "virtualItem",
		exchangeCurrency = {
			itemId = myStore.CURRENCY_MUFFINS,
			amount = 50
		}
	}
})

soomla.createUpgradeVG({
	name = "Level 2",
	description = "Muffin Cake Level 2",
	itemId = myStore.LEVEL_2,
	linkedGood = myStore.SINGLEUSE_MUFFINCAKE,
	previous = myStore.LEVEL_1,
	next = myStore.LEVEL_3,
	purchase = {
		type = "virtualItem",
		exchangeCurrency = {
			itemId = myStore.CURRENCY_MUFFINS,
			amount = 100
		}
	}
})

soomla.createUpgradeVG({
	name = "Level 3",
	description = "Muffin Cake Level 1",
	itemId = myStore.LEVEL_3,
	linkedGood = myStore.SINGLEUSE_MUFFINCAKE,
	previous = myStore.LEVEL_2,
	next = myStore.LEVEL_4,
	purchase = {
		type = "virtualItem",
		exchangeCurrency = {
			itemId = myStore.CURRENCY_MUFFINS,
			amount = 150
		}
	}
})

soomla.createUpgradeVG({
	name = "Level 4",
	description = "Muffin Cake Level 1",
	itemId = myStore.LEVEL_4,
	linkedGood = myStore.SINGLEUSE_MUFFINCAKE,
	previous = myStore.LEVEL_3,
	next = myStore.LEVEL_5,
	purchase = {
		type = "virtualItem",
		exchangeCurrency = {
			itemId = myStore.CURRENCY_MUFFINS,
			amount = 200
		}
	}
})

soomla.createUpgradeVG({
	name = "Level 5",
	description = "Muffin Cake Level 5",
	itemId = myStore.LEVEL_5,
	linkedGood = myStore.SINGLEUSE_MUFFINCAKE,
	previous = myStore.LEVEL_4,
	next = myStore.LEVEL_6,
	purchase = {
		type = "virtualItem",
		exchangeCurrency = {
			itemId = myStore.CURRENCY_MUFFINS,
			amount = 250
		}
	}
})

soomla.createUpgradeVG({
	name = "Level 6",
	description = "Muffin Cake Level 6",
	itemId = myStore.LEVEL_6,
	linkedGood = myStore.SINGLEUSE_MUFFINCAKE,
	previous = myStore.LEVEL_5,
	next = "",
	purchase = {
		type = "virtualItem",
		exchangeCurrency = {
			itemId = myStore.CURRENCY_MUFFINS,
			amount = 300
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
	items = { myStore.SINGLEUSE_MUFFINCAKE, myStore.SINGLEUSE_CHOCOLATECAKE, myStore.SINGLEUSE_PAVLOVA }
})

myStore.CATEGORY_UPGRADES = soomla.createCategory({
	name = "Upgrades",
	items = { myStore.LEVEL_1, myStore.LEVEL_2, myStore.LEVEL_3, myStore.LEVEL_4, myStore.LEVEL_5, myStore.LEVEL_6 }
})

myStore.CATEGORY_CHARACTERS = soomla.createCategory({
	name = "Characters",
	items = { myStore.EQUIP_JERRY, myStore.EQUIP_GEORGE, myStore.EQUIP_KRAMER, myStore.EQUIP_ELAINE }
})

myStore.CATEGORY_LIFETIME = soomla.createCategory({
	name = "Lifetime",
	items = { myStore.LIFETIME_MARRIAGE }
})

myStore.CATEGORY_CHOCOLATEPACKS = soomla.createCategory({
	name = "Chocolate Cake Packs",
	items = { myStore.SINGLEUSEPACK_CHOCOLATECAKE_20, myStore.SINGLEUSEPACK_CHOCOLATECAKE_50, myStore.SINGLEUSEPACK_CHOCOLATECAKE_100, myStore.SINGLEUSEPACK_CHOCOLATECAKE_200, }
})

---- Initializing the store
myStore.virtualGoods = {
	myStore.SINGLEUSE_CHOCOLATECAKE, myStore.SINGLEUSE_CREAMCUP, myStore.SINGLEUSE_PAVLOVA, myStore.SINGLEUSE_MUFFINCAKE,
	myStore.SINGLEUSEPACK_CHOCOLATECAKE_20, myStore.SINGLEUSEPACK_CHOCOLATECAKE_50, myStore.SINGLEUSEPACK_CHOCOLATECAKE_100, myStore.SINGLEUSEPACK_CHOCOLATECAKE_200,
	myStore.EQUIP_JERRY, myStore.EQUIP_KRAMER, myStore.EQUIP_ELAINE, myStore.EQUIP_GEORGE,
	myStore.LIFETIME_MARRIAGE,
	myStore.LEVEL_1, myStore.LEVEL_2, myStore.LEVEL_3, myStore.LEVEL_4, myStore.LEVEL_5, myStore.LEVEL_6
}

myStore.virtualCurrencies = {
	myStore.CURRENCY_MUFFINS
}

myStore.virtualCurrencyPacks = {
	myStore.CURRENCYPACK_MUFFINS_10, myStore.CURRENCYPACK_MUFFINS_50, myStore.CURRENCYPACK_MUFFINS_100, myStore.CURRENCYPACK_MUFFINS_400, myStore.CURRENCYPACK_MUFFINS_1000
}

myStore.virtualCategories = {
	myStore.CATEGORY_CHOCOLATEPACKS, myStore.CATEGORY_MUFFINS, myStore.CATEGORY_CHARACTERS, myStore.CATEGORY_UPGRADES, myStore.CATEGORY_LIFETIME
}

myStore.nonConsumableItems = {
	myStore.NONCONSUMABLE_NOADS
}

soomla.initializeStore(myStore)

return myStore