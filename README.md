corona-store
============

[Work in Progress]  - F2P game economy library. Part of The SOOMLA Project - framework for virtual economies in mobile games.

IStoreAssets
============
Creating an IStoreAssets implementation
```lua

local soomla = require "plugin.soomla"

local myStore = {}
myStore.version = 1

-- Currency
myStore.CURRENCY_MUFFINS = soomla.createCurrency({
	name = "Muffins",
	description = "",
	itemId = "currency_muffin"
})

-- Currency Pack
myStore.CURRENCYPACK_10 = soomla.createCurrencyPack({
	name = "10 Muffins",
	description = "",
	itemId = "muffins_10",
	currencyAmount = 10,
	currency = myStore.CURRENCY_MUFFINS,
	purchase = {
		type = "market",
		product = {
			id = "com.mycompany.mygame.muffins_pack_ten",
			consumable = "consumable",
			price = 0.99
		}
	}
})

myStore.CURRENCYPACK_50 = soomla.createCurrencyPack({
	name = "50 Muffins",
	description = "",
	itemId = "muffins_50",
	currencyAmount = 50,
	currency = myStore.CURRENCY_MUFFINS,
	purchase = {
		type = "market",
		product = {
			id = "com.mycompany.mygame.muffins_pack_fifty",
			consumable = "consumable",
			price = 1.99
		}
	}
})

myStore.currencies = { 
	myStore.CURRENCY_MUFFINS
}

myStore.currencyPacks = {
	myStore.CURRENCYPACK_10,
	myStore.CURRENCYPACK_50
}

soomla.initializeStore(myStore)

return myStore

```

Purchase Types
============
Table to create a Purchase Type

Purchase With Market
------------
```lua
-- lua table to create a Purchase With Market Object
{
	type = "market",
	product = {
		id = "com.mycompany.mygame.myitem",
		consumable = "consumable",
		price = 1.99
	}
}

```

Purchase With Virtual Item
-------------
```lua
-- lua table to create a Purchase With Virtual Item
{
	type = "virtualItem",
	exchangeCurrency = {
		-- You are able to use whatever Virtual Item do you want! You can use Currencies or SingleUseVGs or LifetimeVGs!
		id = MyStore.MY_VIRTUAL_ITEM,
		amount = 10
	}
}
```

Models
============

VirtualCurrency
------------
```lua

local currency_muffins = soomla.createCurrency({
	name = "Muffins",
	description = "",
	itemId = "currency_muffin"
})

```

VirtualCurrencyPack
------------
```lua

local currencyPack_Muffins10 = soomla.createCurrencyPack({
	name = "10 Muffins",
	description = "",
	itemId = "muffins_10",
	currencyAmount = 10,
	currency = "currency_muffin",
	purchase = {
		type = "market",
		product = {
			id = "com.mycompany.mygame.muffins_pack_ten",
			consumable = "consumable",
			price = 0.99
		}
	}
})

```

SingleUseVG
-------------
```lua

local singleUseVG_ChocolateCake = soomla.createSingleUseVG({
	name = "Chocolate Cake",
	description = "A classic cake to maximize customer satisfaction",
	itemId = "chocolate_cake",
	purchase = {
		type = "virtualItem",
		exchangeCurrency = {
			itemId = "currency_muffin",
			amount = 250
		}
	}
})

```

LifetimeVG
--------------
```lua

local lifetimeVG_Marriage = soomla.createLifetimeVG({
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

```

EquippableVG
---------------
```lua

local equippableVG_Jerry = soomla.createEquippableVG({
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

```

SingleUsePackVG
----------------
```lua

local singleUsePackVG_20_ChocolateCake = soomla.createSingleUsePackVG({
	name = "20 Chocolate Cakes",
	description = "A pack of 20 Chocolate Cakes",
	itemId = "20_chocolate_cake",
	singleUseGood = "chocolate_cake",
	amount = 20,
	purchase = {
		type = "virtualItem",
		exchangeCurrency = {
			itemId = "currency_muffins",
			amount = 34
		}
	}
})

```

UpgradeVG
----------------
```lua

local upgradeVG_Level1 = soomla.createUpgradeVG({
	name = "Level 1",
	description = "Muffin Cake Level 1",
	itemId = "muffin_level_1",
	linkedGood = "chocolate_cake",
	previousUpgrade = "",
	nextUpgrade = "muffin_level_2",
	purchase = {
		type = "virtualItem",
		exchangeCurrency = {
			itemId = "currency_muffins",
			amount = 50
		}
	}
})

```

NonConsumableItem
-----------------
```lua

local nonConsumableItem_NoAds = soomla.createNonConsumableItem({
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


```

Virtual Categories
==================
```lua

local category_cakes = soomla.createVirtualCategory({
	name = "Cakes",
	items = {
		"chocolate_cake",
		"20_chocolate_cake",
		"muffin_level_1"
	}
})

```