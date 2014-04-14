local soomla = require "plugin.soomla"
local widget = require "widget"
local GameItem = require "assets.core.game_item"

local EquipmentGameItem = {}

function EquipmentGameItem:new(id)

	local gameItem = GameItem:new(id)

	gameItem.category = display.newText({
		parent = gameItem,
		text = soomla.categoryForItem(gameItem.id).name,
		x = 190, y = 27,
		fontSize = 15,
		align = "right"
	})
	gameItem.category.anchorX = 0
	gameItem.category:setFillColor({0.7,0.7,0.7,1})

	if soomla.getItemBalance(gameItem.id) >= 1 then
		self.cost.isVisible = false
		if soomla.isItemEquipped(gameItem.id) then gameItem.buyButton:setLabel("Unequip")
		else gameItem.buyButton:setLabel("Equip") end
	end

	function gameItem:buy()
		local balance = soomla.getItemBalance(gameItem.id)
		if balance < 1 then
			if soomla.canBuyItem(self.id) then soomla.buyItem(self.id)
			else Notifier:show("Insufficient funds!") end
		else
			if not soomla.isItemEquipped(self.id) then soomla.equipItem(self.id)
			else soomla.unequipItem(self.id) end
		end
	end

	local function purchaseListener(event)
		if event.purchasableItem.itemId == gameItem.id then
			gameItem.buyButton:setLabel("Equip")
			gameItem.cost.isVisible = false
			print("After Purchase: " .. tostring(soomla.isItemEquipped(gameItem.id)))
		end
	end

	local function equipListener(event)
		if event.equippableVG.itemId ~= gameItem.id then return end
		if event.name == "soomla_VirtualGoodEquipped" then
			gameItem.buyButton:setLabel("Unequip")
		elseif event.name == "soomla_VirtualGoodUNEQUIPPED" then
			gameItem.buyButton:setLabel("Equip")
		end
	end

	function gameItem:startListeningEvents()
		Runtime:addEventListener("soomla_ItemPurchased",purchaseListener)
		Runtime:addEventListener("soomla_VirtualGoodEquipped",equipListener)
		Runtime:addEventListener("soomla_VirtualGoodUNEQUIPPED",equipListener)
	end

	function gameItem:stopListeningEvents()
		Runtime:removeEventListener("soomla_ItemPurchased",purchaseListener)
		Runtime:removeEventListener("soomla_VirtualGoodEquipped",equipListener)
		Runtime:removeEventListener("soomla_VirtualGoodUNEQUIPPED",equipListener)
	end
	
	return gameItem
end

return EquipmentGameItem