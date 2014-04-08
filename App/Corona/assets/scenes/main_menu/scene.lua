local storyboard = require "storyboard"
local widget = require "widget"
local soomla = require "plugin.soomla"
local MainMenu = require "assets.scenes.main_menu.menu"

local scene = storyboard.newScene()


-- Title
function scene:createTitle()
	self.title = display.newText({
		text = "Choose your destiny",
		x = display.contentCenterX, 
		y = ResolutionUtil:anchoredY(50),
		width = ResolutionUtil.deviceWidth, 
		height = 50,
		fontSize = 20,
		font = native.systemFontBold,
		align = "center"
	})
	self.title:setFillColor(0.5,0.5,0.5,1)
	self.view:insert(self.title)
end

-- Store events
local function billingNotSupportedListener(event)
  scene.menu.isLocked = false
  Notifier:show("Billing is not supported!")
  scene:stopListeningEvents()
end

local function itemPurchasedListener(event)
  scene.menu.isLocked = false
  Notifier:show("Thanks for buying!")
  scene:stopListeningEvents()
end

local function itemCancelledListener(event)
  scene.menu.isLocked = false
  scene:stopListeningEvents()
end

local function unexpectedErrorListener(event)
   scene.menu.isLocked = false
   Notifier:show(event.description)
   scene:stopListeningEvents()
end

function scene:startListeningEvents()
  Runtime:addEventListener("soomla_BillingNotSupported",billingNotSupportedListener)
  Runtime:addEventListener("soomla_AppStorePurchased",itemPurchasedListener)
  Runtime:addEventListener("soomla_AppStorePurchaseCancelled",itemCancelledListener)
  Runtime:addEventListener("soomla_UnexpectedErrorInStore",unexpectedErrorListener)
end

function scene:stopListeningEvents()
  Runtime:removeEventListener("soomla_BillingNotSupported",billingNotSupportedListener)
  Runtime:removeEventListener("soomla_AppStorePurchased",itemPurchasedListener)
  Runtime:removeEventListener("soomla_AppStorePurchaseCancelled",itemCancelledListener)
  Runtime:removeEventListener("soomla_UnexpectedErrorInStore",unexpectedErrorListener)
end
  

-- Menu
local function goTo(sceneName)
	storyboard.gotoScene(sceneName,Scenes.leftTransition)
end

local function optionListener(event)
  if event.id ~= "option_noads" then
    goTo(event.row.params.scene)
  else
    scene.menu.isLocked = true
    scene:startListeningEvents()
    soomla.buyItem(TheTavern.NONCONSUMABLE_NOADS_ID)
  end
end

function scene:createMenuTableView()
	local rows = {
		{ id = "option_currency", title = "Virtual Currency", scene = Scenes.currency },
    { id = "option_currencypack", title = "Virtual Currency Pack", scene = Scenes.currencyPack },
		{ id = "option_singleuse", title = "Single Use Virtual Goods", scene = Scenes.singleUse },
		{ id = "option_upgrades" , title = "Upgrades", scene = Scenes.upgrades },
		{ id = "option_lifetime", title = "Lifetime Virtual Goods", scene = Scenes.lifetime },
		{ id = "option_equip", title = "Equippable Virtual Goods", scene = Scenes.equipment },
		{ id = "option_noads", title = "Remove Ads", scene = "" },
	}
	self.menu = MainMenu:new("main_menu",rows)
	self.view:insert(self.menu)
end


-- Scene Events
function scene:createScene()
	self:createTitle()
	self:createMenuTableView()
end

function scene:willEnterScene()
	Runtime:addEventListener(MainMenu.event_OptionSelected,optionListener)	
end

function scene:enterScene()

end

function scene:exitScene()
	Runtime:removeEventListener(MainMenu.event_OptionSelected,optionListener)
end

scene:addEventListener("createScene",scene)
scene:addEventListener("willEnterScene",scene)
scene:addEventListener("enterScene",scene)
scene:addEventListener("exitScene",scene)

return scene