corona-store
============

[Work in Progress]  - F2P game economy library. Part of The SOOMLA Project - framework for virtual economies in mobile games.

IStoreAssets
============
Creating a IStoreAssets implementation
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

soomla.initializeStore(myStore)

return myStore

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