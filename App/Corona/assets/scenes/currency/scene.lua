local storyboard = require "storyboard"
local soomla = require "plugin.soomla"
local CoinMeter = require "assets.scenes.currency.coinmeter"

local scene = storyboard.newScene()

function scene:createCoinMeter()
	-- Gold Coins
	local coins = display.newImageRect("assets/images/coins.png",288,288)
	coins.width = 80
	coins.height = 80
	self.goldCoinMeter = CoinMeter:new(TheTavern.CURRENCY_GOLD_ID,coins)
	self.goldCoinMeter.x = ResolutionUtil:anchoredX(40)
	self.goldCoinMeter.y = ResolutionUtil:anchoredY(60)
	self.view:insert(self.goldCoinMeter)
end


local function giveListener(event)
	soomla.giveItem(event.currency,100)
end

local function takeListener(event)
	soomla.takeItem(event.currency,100)
end


function scene:createScene()
	self:createCoinMeter()
end

function scene:willEnterScene()
	self.goldCoinMeter:setAmount(soomla.getItemBalance(self.goldCoinMeter.currencyId))
end

function scene:enterScene()
	self.goldCoinMeter:startListeningEvents()
	Runtime:addEventListener(CoinMeter.event_Give,giveListener)
	Runtime:addEventListener(CoinMeter.event_Take,takeListener)
end

function scene:willExitScene()
	self.goldCoinMeter:stopListeningEvents()
	Runtime:removeEventListener(CoinMeter.event_Give,giveListener)
	Runtime:removeEventListener(CoinMeter.event_Take,takeListener)
end

scene:addEventListener("createScene",scene)
scene:addEventListener("willEnterScene",scene)
scene:addEventListener("enterScene",scene)
scene:addEventListener("willExitScene",scene)

return scene