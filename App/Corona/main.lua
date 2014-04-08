display.setStatusBar(display.HiddenStatusBar)
display.setDefault("background",230,230,230)

-- Resolution
ResolutionUtil = require "assets.core.resolution_util"

-- Scenes
Scenes = {}
Scenes.mainMenu = "assets.scenes.main_menu.scene"
Scenes.currency = "assets.scenes.currency.scene"
Scenes.currencyPack = "assets.scenes.currency_pack.scene"
Scenes.singleUse = "assets.scenes.single_use.scene"
Scenes.upgrades = "assets.scenes.upgrades.scene"
Scenes.lifetime = "assets.scenes.lifetime.scene"
Scenes.equipment = "assets.scenes.equipment.scene"
Scenes.fadeTransition = { time = 300, effect = "fade" }
Scenes.leftTransition = { time = 300, effect = "slideLeft" }
Scenes.rightTransition = { time = 300, effect = "slideRight" }

-- Notifier
Notifier = require "assets.core.notifier"

-- Initialization
local function storeControllerListener(event)
  local storyboard = require "storyboard"
  storyboard.gotoScene(Scenes.mainMenu,Scenes.fadeTransition)  
  Runtime:removeEventListener("soomla_StoreControllerInitialized",storeControllerListener)
end

Runtime:addEventListener("soomla_StoreControllerInitialized",storeControllerListener)

-- Store
TheTavern = require "assets.store.tavern"

-- Ads
Ads = require "assets.core.ads"