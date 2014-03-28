local storyboard = require "storyboard"
local soomla = require "plugin.soomla"

local scene = storyboard.newScene()

function scene:createCoinMeter()
	local CoinMeter = require "assets.scenes.currency.coinmeter"
	self.coinMeter = CoinMeter:new()
	self.coinMeter.x = ResolutionUtil:anchoredX(60)
	self.view:insert(self.coinMeter)
end


function scene:createScene()
	self:createCoinMeter()
end

function scene:willEnterScene()
	self.coinMeter:setAmount(soomla.getItemBalance(TheTavern.CURRENCY_GOLD_ID))
end

function scene:enterScene()
	self.coinMeter:startListeningEvents()
end

function scene:willExitScene()
	self.coinMeter:stopListeningEvents()
end

scene:addEventListener("createScene",scene)
scene:addEventListener("willEnterScene",scene)
scene:addEventListener("enterScene",scene)
scene:addEventListener("willExitScene",scene)

return scene