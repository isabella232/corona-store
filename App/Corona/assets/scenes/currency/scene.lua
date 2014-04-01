local storyboard = require "storyboard"
local widget = require "widget"
local soomla = require "plugin.soomla"
local CoinMeter = require "assets.scenes.currency.coinmeter"

local scene = storyboard.newScene()

-- Coin Meters
function scene:createCoinMeters()
	local coins = display.newImageRect("assets/images/coins.png",288,288)
	coins.width = 80
	coins.height = 80
	self.goldCoinMeter = CoinMeter:new(TheTavern.CURRENCY_GOLD_ID,coins)
	self.goldCoinMeter.x = ResolutionUtil:anchoredX(40)
	self.goldCoinMeter.y = ResolutionUtil:anchoredY(60)
	self.view:insert(self.goldCoinMeter)

	local skillPoints = display.newImageRect("assets/images/skill_points.png",300,300)
	skillPoints.width = 80
	skillPoints.height = 80
	self.skillPointsMeter = CoinMeter:new(TheTavern.CURRENCY_SKILLPOINTS_ID,skillPoints)
	self.skillPointsMeter.x = ResolutionUtil:anchoredX(40)
	self.skillPointsMeter.y = ResolutionUtil:anchoredY(200)
	self.view:insert(self.skillPointsMeter)
end

-- Buttons
local function goBack(event)
	storyboard.gotoScene(Scenes.mainMenu,Scenes.rightTransition)
end

function scene:createButtons()
	self.backButton = widget.newButton({
		id = "go_back",
		label = "Back",
		x = display.contentCenterX,
		y = ResolutionUtil:anchoredY(380),
		onPress = goBack
	})
	self.view:insert(self.backButton)
end


local function giveListener(event)
	soomla.giveItem(event.currency,100)
end

local function takeListener(event)
	soomla.takeItem(event.currency,100)
end


function scene:createScene()
	self:createCoinMeters()
	self:createButtons()
end

function scene:willEnterScene()
	self.goldCoinMeter:setAmount(soomla.getItemBalance(self.goldCoinMeter.currencyId))
	self.skillPointsMeter:setAmount(soomla.getItemBalance(self.skillPointsMeter.currencyId))
end

function scene:enterScene()
	self.goldCoinMeter:startListeningEvents()
	self.skillPointsMeter:startListeningEvents()
	Runtime:addEventListener(CoinMeter.event_Give,giveListener)
	Runtime:addEventListener(CoinMeter.event_Take,takeListener)
end

function scene:willExitScene()
	self.goldCoinMeter:stopListeningEvents()
	self.skillPointsMeter:stopListeningEvents()
	Runtime:removeEventListener(CoinMeter.event_Give,giveListener)
	Runtime:removeEventListener(CoinMeter.event_Take,takeListener)
end

scene:addEventListener("createScene",scene)
scene:addEventListener("willEnterScene",scene)
scene:addEventListener("enterScene",scene)
scene:addEventListener("willExitScene",scene)

return scene