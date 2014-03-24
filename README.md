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
