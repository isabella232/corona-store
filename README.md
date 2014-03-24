corona-store
============

[Work in Progress]  *- F2P game economy library. Part of The SOOMLA Project - framework for virtual economies in mobile games.*

Haven't you ever wanted an in-app purchase one liner that looks like this?!
```lua
    soomla.buyItem("itemId")
```

Getting Started
============

1. The first step is to add the plugin into your project. To do this, you should add some lines to the **building.settings** file:
```lua
    settings = {
        plugins = {
            ["plugin.soomla"] = { publisherId = "com.soomla" }
        }
    }
```
2. Create your own implementation of *IStoreAssets* in order to describe your specific game's assets.

> Follow the [example](https://github.com/soomla/corona-store/blob/master/Examples/muffins_assets.lua) to create and initialize your Store.

> You should initialize your store **ONLY_ONCE** 

3. And that's it! You have Storage and in-app purchasing capabilities... ALL-IN-ONE. Soomla knows how to contact the AppStore for you and redirect the user to their purchasing system to complete the transaction. Don't forget to subscribe to events of successful or failed purchases (see *See [EventHandling](\*)*).

What's next? In App Purchasing
=============
When we implemented modelV3, we were thinking about ways people buy things inside apps. We figured many ways you can let your users purchase stuff in your game and we designed the new modelV3 to support 2 of them: Purchase With Market; and Purchase With Virtual Item.

- **Purchase With Market**: is a *Purchase Type* that allows users to purchase a *Virtual Item* from the AppStore.

- **Purchase With Virtual Item**: is a *Purchase Type* that lets your users purchase a *Virtual Item* with a different *Virtual Item*. For example: *"Buying 1 Sword with 100 Gems"*.

Let's say you have a *Virtual Currency Pack* named **TEN_COINS_PACK** and a *Virtual Currency* with itemId **currency_coins**:

```lua

local tenCoinsPack = soomla.createCurrencyPack({
    name = "10 Coins",
    description = "",
    itemId = "10_coins",
    currencyAmount = 10,
    currency = "currency_coins",
    purchase = {
        type = "market",
        product = {
            id = "com.mycompany.mygame.coinspack_10",
            price = 1.99
        }
    }
})

```

Now you can use `soomla.buyItem` to buy this new currency pack

```lua
soomla.buyItem(tenCoinsPack)
```
