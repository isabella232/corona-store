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
	name = "",
	description = "",
	itemId = "",
	currencyAmount = 10,
	currency = myStore.CURRENCY_MUFFINS,
	purchaseType = {
		type = "market",
		product= {
			id = "com.mycompany.mygame.muffins_pack_ten",
			consumable = "consumable",
			price = 0.99
		}
	}
})

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