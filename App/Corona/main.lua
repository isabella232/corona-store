display.setStatusBar(display.HiddenStatusBar)
display.setDefault("background",230,230,230)

-- Resolution
ResolutionUtil = require "assets.core.resolution_util"

-- Store
TheTavern = require "assets.store.tavern"

-- Scenes
Scenes = {}
Scenes.mainMenu = "assets.scenes.main_menu.scene"
Scenes.currency = "assets.scenes.currency.scene"
Scenes.fadeTransition = { time = 300, effect = "fade" }
Scenes.leftTransition = { time = 300, effect = "slideLeft" }
Scenes.rightTransition = { time = 300, effect = "slideRight" }

-- Ads
Ads = require "assets.core.ads"

-- Initialization
local storyboard = require "storyboard"
storyboard.gotoScene(Scenes.mainMenu,Scenes.fadeTransition)