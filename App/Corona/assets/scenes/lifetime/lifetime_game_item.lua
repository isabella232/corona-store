local soomla = require "plugin.soomla"
local widget = require "widget"
local GameItem = require "assets.core.game_item"

local LifetimeGameItem = {}

function LifetimeGameItem:new(id)

	local gameItem = GameItem:new(id)
	local balance = soomla.getItemBalance(gameItem.id)

	if balance >= 1 then
		gameItem:setBuyEnabled(false)
	end

	local purchaseListener = function(event)
		if event.purchasableItem.itemId == gameItem.id then
			gameItem:setBuyEnabled(false)
		end
	end

	function gameItem:startListeningEvents()
		Runtime:addEventListener("soomla_ItemPurchased",purchaseListener)
	end

	function gameItem:stopListeningEvents()
		Runtime:removeEventListener("soomla_ItemPurchased",purchaseListener)
	end
	
	return gameItem
end

return LifetimeGameItem