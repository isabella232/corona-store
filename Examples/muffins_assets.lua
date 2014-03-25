
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
	amount = 10,
	purchase = {
		purchaseType = "market",
		product = { 
			id = appId .. ".muffinspack_10", 
			consumption = "consumable",
			price = 0.99
		}
	}
})

myStore.CURRENCYPACK_MUFFINS_50_ID = soomla.createCurrencyPack({
	name = "50 Muffins",
	description = "A pack of 50 Muffins",
	itemId = "currencypack_muffins_50",
	currency = myStore.CURRENCY_MUFFINS_ID,
	amount = 50,
	purchase = {
		purchaseType = "market",
		product = { 
			id = appId .. ".muffinspack_50", 
			consumption = "consumable",
			price = 1.99
		}
	}
})

myStore.CURRENCYPACK_MUFFINS_400_ID = soomla.createCurrencyPack({
	name = "400 Muffins",
	description = "A pack of 400 Muffins",
	itemId = "currencypack_muffins_400",
	currency = myStore.CURRENCY_MUFFINS_ID,
	amount = 400,
	purchase = {
		purchaseType = "market",
		product = { 
			id = appId .. ".muffinspack_400", 
			consumption = "consumable",
			price = 2.99
		}
	}
})

myStore.CURRENCYPACK_MUFFINS_1000_ID = soomla.createCurrencyPack({
	name = "1000 Muffins",
	description = "A pack of 1000 Muffins",
	itemId = "currencypack_muffins_1000",
	currency = myStore.CURRENCY_MUFFINS_ID,
	amount = 1000,
	purchase = {
		purchaseType = "market",
		product = { 
			id = appId .. ".muffinspack_1000", 
			consumption = "consumable",
			price = 3.99
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
		purchaseType = "virtualItem",
		exchangeCurrency = {
			itemId = myStore.CURRENCY_MUFFINS_ID,
			amount = 250
		}
	}
})

myStore.SINGLEUSE_CREAMCUP_ID = soomla.createSingleUseVG({
	name = "Cream Cup",
	description = "Increase bakery reputation with this original pastry",
	itemId = "singleuse_creamcup",
	purchase = {
		purchaseType = "virtualItem",
		exchangeCurrency = {
			itemId = myStore.CURRENCY_MUFFINS_ID,
			amount = 50
		}
	}
})

myStore.SINGLEUSE_MUFFINCAKE_ID = soomla.createSingleUseVG({
	name = "Muffin Cake",
	description = "Customers buy a double portion on each purchase of this cake",
	itemId = "singleuse_muffincake",
	purchase = {
		purchaseType = "virtualItem",
		exchangeCurrency = {
			itemId = myStore.CURRENCY_MUFFINS_ID,
			amount = 225
		}
	}
})

myStore.SINGLEUSE_PAVLOVA_ID = soomla.createSingleUseVG({
	name = "Pavlova",
	description = "Gives customers a sugar rush and they call their friends",
	itemId = "singleuse_pavlova",
	purchase = {
		purchaseType = "virtualItem",
		exchangeCurrency = {
			itemId = myStore.CURRENCY_MUFFINS_ID,
			amount = 175
		}
	}
})


---- LIFETIME VIRTUAL GOOD
myStore.LIFETIME_MARRIAGE_ID = soomla.createLifetimeVG({
	name = "Marriage",
	description = "This is a Lifetime thing",
	itemId = "lifetime_marriage",
	purchase = {
		purchaseType = "market",
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
		purchaseType = "virtualItem",
		exchangeCurrency = {
			itemId = myStore.CURRENCY_MUFFINS_ID,
			amount = 250
		}
	}
})


myStore.EQUIP_GEORGE_ID = soomla.createEquippableVG({
	name = "George",
	description = "The best muffin eater in the north",
	itemId = "equip_george",
	equipModel = "category",
	purchase = {
		purchaseType = "virtualItem",
		exchangeCurrency = {
			itemId = myStore.CURRENCY_MUFFINS_ID,
			amount = 350
		}
	}
})

myStore.EQUIP_KRAMER_ID = soomla.createEquippableVG({
	name = "Kramer",
	description = "Knows how to get muffins",
	itemId = "equip_kramer",
	equipModel = "category",
	purchase = {
		purchaseType = "virtualItem",
		exchangeCurrency = {
			itemId = myStore.CURRENCY_MUFFINS_ID,
			amount = 400
		}
	}
})

myStore.EQUIP_ELAINE_ID = soomla.createEquippableVG({
	name = "Elain",
	description = "Kicks muffins like a boss",
	itemId = "equip_elaine",
	equipModel = "category",
	purchase = {
		purchaseType = "virtualItem",
		exchangeCurrency = {
			itemId = myStore.CURRENCY_MUFFINS_ID,
			amount = 450
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
		purchaseType = "virtualItem",
		exchangeCurrency = {
			itemId = myStore.CURRENCY_MUFFINS_ID,
			amount = 35
		}
	}
})

myStore.SINGLEUSEPACK_CHOCOLATECAKE_50_ID = soomla.createSingleUsePackVG({
	name = "50 Chocolate Cakes",
	description = "A pack of 50 Chocolate Cakes",
	itemId = "singleusepack_chocolatecake_50",
	singleUseGood = myStore.SINGLEUSE_CHOCOLATECAKE_ID ,
	amount = 50,
	purchase = {
		purchaseType = "virtualItem",
		exchangeCurrency = {
			itemId = myStore.CURRENCY_MUFFINS_ID,
			amount = 50
		}
	}
})

myStore.SINGLEUSEPACK_CHOCOLATECAKE_100_ID = soomla.createSingleUsePackVG({
	name = "100 Chocolate Cakes",
	description = "A pack of 100 Chocolate Cakes",
	itemId = "singleusepack_chocolatecake_100",
	singleUseGood = myStore.SINGLEUSE_CHOCOLATECAKE_ID ,
	amount = 100,
	purchase = {
		purchaseType = "virtualItem",
		exchangeCurrency = {
			itemId = myStore.CURRENCY_MUFFINS_ID,
			amount = 70
		}
	}
})


myStore.SINGLEUSEPACK_CHOCOLATECAKE_200_ID = soomla.createSingleUsePackVG({
	name = "200 Chocolate Cakes",
	description = "A pack of 200 Chocolate Cakes",
	itemId = "singleusepack_chocolatecake_200",
	singleUseGood = myStore.SINGLEUSE_CHOCOLATECAKE_ID ,
	amount = 200,
	purchase = {
		purchaseType = "virtualItem",
		exchangeCurrency = {
			itemId = myStore.CURRENCY_MUFFINS_ID,
			amount = 100
		}
	}
})

---- UPGRADE VIRTUAL GOODS
--[[ 
	You can create the virtual items / categories / currencies in two ways:
 		- Make the id variables receive the return of the creation function
 		- Create the id variables before, and then use them on the table

 	Since we should use the upgrades' itemId to define the nextUpgrade and previousUpgrade upgrades, we prefer to use the second approach to the upgrades
 ]]--
myStore.LEVEL_1_ID = "mc1"
myStore.LEVEL_2_ID = "mc2"
myStore.LEVEL_3_ID = "mc3"
myStore.LEVEL_4_ID = "mc4"
myStore.LEVEL_5_ID = "mc5"
myStore.LEVEL_6_ID = "mc6"

soomla.createUpgradeVG({
	name = "Level 1",
	description = "Muffin Cake Level 1",
	itemId = myStore.LEVEL_1_ID,
	linkedGood = myStore.SINGLEUSE_MUFFINCAKE_ID,
	previousUpgrade = "",
	nextUpgrade = myStore.LEVEL_2_ID,
	purchase = {
		purchaseType = "virtualItem",
		exchangeCurrency = {
			itemId = myStore.CURRENCY_MUFFINS_ID,
			amount = 50
		}
	}
})

soomla.createUpgradeVG({
	name = "Level 2",
	description = "Muffin Cake Level 2",
	itemId = myStore.LEVEL_2_ID,
	linkedGood = myStore.SINGLEUSE_MUFFINCAKE_ID,
	previousUpgrade = myStore.LEVEL_1_ID,
	nextUpgrade = myStore.LEVEL_3_ID,
	purchase = {
		purchaseType = "virtualItem",
		exchangeCurrency = {
			itemId = myStore.CURRENCY_MUFFINS_ID,
			amount = 100
		}
	}
})

soomla.createUpgradeVG({
	name = "Level 3",
	description = "Muffin Cake Level 1",
	itemId = myStore.LEVEL_3_ID,
	linkedGood = myStore.SINGLEUSE_MUFFINCAKE_ID,
	previousUpgrade = myStore.LEVEL_2_ID,
	nextUpgrade = myStore.LEVEL_4_ID,
	purchase = {
		purchaseType = "virtualItem",
		exchangeCurrency = {
			itemId = myStore.CURRENCY_MUFFINS_ID,
			amount = 150
		}
	}
})

soomla.createUpgradeVG({
	name = "Level 4",
	description = "Muffin Cake Level 1",
	itemId = myStore.LEVEL_4_ID,
	linkedGood = myStore.SINGLEUSE_MUFFINCAKE_ID,
	previousUpgrade = myStore.LEVEL_3_ID,
	nextUpgrade = myStore.LEVEL_5_ID,
	purchase = {
		purchaseType = "virtualItem",
		exchangeCurrency = {
			itemId = myStore.CURRENCY_MUFFINS_ID,
			amount = 200
		}
	}
})

soomla.createUpgradeVG({
	name = "Level 5",
	description = "Muffin Cake Level 5",
	itemId = myStore.LEVEL_5_ID,
	linkedGood = myStore.SINGLEUSE_MUFFINCAKE_ID,
	previousUpgrade = myStore.LEVEL_4_ID,
	nextUpgrade = myStore.LEVEL_6_ID,
	purchase = {
		purchaseType = "virtualItem",
		exchangeCurrency = {
			itemId = myStore.CURRENCY_MUFFINS_ID,
			amount = 250
		}
	}
})

soomla.createUpgradeVG({
	name = "Level 6",
	description = "Muffin Cake Level 6",
	itemId = myStore.LEVEL_6_ID,
	linkedGood = myStore.SINGLEUSE_MUFFINCAKE_ID,
	previousUpgrade = myStore.LEVEL_5_ID,
	nextUpgrade = "",
	purchase = {
		purchaseType = "virtualItem",
		exchangeCurrency = {
			itemId = myStore.CURRENCY_MUFFINS_ID,
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
		purchaseType = "market",
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
	items = { myStore.SINGLEUSE_MUFFINCAKE_ID, myStore.SINGLEUSE_CHOCOLATECAKE_ID , myStore.SINGLEUSE_PAVLOVA_ID }
})

myStore.CATEGORY_UPGRADES = soomla.createCategory({
	name = "Upgrades",
	items = { myStore.LEVEL_1_ID, myStore.LEVEL_2_ID, myStore.LEVEL_3_ID, myStore.LEVEL_4_ID, myStore.LEVEL_5_ID, myStore.LEVEL_6_ID }
})

myStore.CATEGORY_CHARACTERS = soomla.createCategory({
	name = "Characters",
	items = { myStore.EQUIP_JERRY_ID, myStore.EQUIP_GEORGE_ID, myStore.EQUIP_KRAMER_ID, myStore.EQUIP_ELAINE_ID }
})

myStore.CATEGORY_LIFETIME = soomla.createCategory({
	name = "Lifetime",
	items = { myStore.LIFETIME_MARRIAGE_ID }
})

myStore.CATEGORY_CHOCOLATEPACKS = soomla.createCategory({
	name = "Chocolate Cake Packs",
	items = { myStore.SINGLEUSEPACK_CHOCOLATECAKE_20_ID, myStore.SINGLEUSEPACK_CHOCOLATECAKE_50_ID, myStore.SINGLEUSEPACK_CHOCOLATECAKE_100_ID, myStore.SINGLEUSEPACK_CHOCOLATECAKE_200_ID, }
})

---- Initializing the store
myStore.virtualGoods = {
	myStore.SINGLEUSE_CHOCOLATECAKE_ID , myStore.SINGLEUSE_CREAMCUP_ID, myStore.SINGLEUSE_PAVLOVA_ID, myStore.SINGLEUSE_MUFFINCAKE_ID,
	myStore.SINGLEUSEPACK_CHOCOLATECAKE_20_ID, myStore.SINGLEUSEPACK_CHOCOLATECAKE_50_ID, myStore.SINGLEUSEPACK_CHOCOLATECAKE_100_ID, myStore.SINGLEUSEPACK_CHOCOLATECAKE_200_ID,
	myStore.EQUIP_JERRY_ID, myStore.EQUIP_KRAMER_ID, myStore.EQUIP_ELAINE_ID, myStore.EQUIP_GEORGE_ID,
	myStore.LIFETIME_MARRIAGE_ID,
	myStore.LEVEL_1_ID, myStore.LEVEL_2_ID, myStore.LEVEL_3_ID, myStore.LEVEL_4_ID, myStore.LEVEL_5_ID, myStore.LEVEL_6_ID
}

myStore.virtualCurrencies = {
	myStore.CURRENCY_MUFFINS_ID
}

myStore.virtualCurrencyPacks = {
	myStore.CURRENCYPACK_MUFFINS_10_ID, myStore.CURRENCYPACK_MUFFINS_50_ID, myStore.CURRENCYPACK_MUFFINS_10_ID0, myStore.CURRENCYPACK_MUFFINS_400_ID, myStore.CURRENCYPACK_MUFFINS_1000_ID
}

myStore.virtualCategories = {
	myStore.CATEGORY_CHOCOLATEPACKS, myStore.CATEGORY_MUFFINS, myStore.CATEGORY_CHARACTERS, myStore.CATEGORY_UPGRADES, myStore.CATEGORY_LIFETIME
}

myStore.nonConsumableItems = {
	myStore.NONCONSUMABLE_NOADS
}

soomla.initializeStore(myStore)

return myStore