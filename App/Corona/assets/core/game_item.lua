local widget = require "widget"
local soomla = require "plugin.soomla"

local GameItem = {}
GameItem.currencies = {}
GameItem.currencies[TheTavern.CURRENCY_GOLD_ID] = "assets/images/coins.png"
GameItem.currencies[TheTavern.CURRENCY_SKILLPOINTS_ID] = "assets/images/skill_points.png"

function GameItem:new(id)
	
	local gameItem = display.newGroup()

	local virtualItem = soomla.getVirtualItem(id)
	gameItem.id = virtualItem.itemId
	gameItem.name = display.newText({
		parent = gameItem,
		text = virtualItem.name,
		x = 0, y = 40,
		width = 180, height = 50,
		font = native.systemFontBold,
		fontSize = 20,
		align = "left"
	})
	gameItem.name.anchorX = 0
	gameItem.name:setFillColor({0.5,0.5,0.5,1})

	gameItem.description = display.newText({
		parent = gameItem,
		text = virtualItem.description,
		x = 0, y = 50,
		fontSize = 13,
		align = "left",
	})
	gameItem.description.anchorX = 0
	gameItem.description:setFillColor({0.5,0.5,0.5,1})

	local function buy(event)
		gameItem:buy()
	end

	function gameItem:buy()
		if soomla.canBuyItem(self.id) then soomla.buyItem(self.id)
		else Notifier:show("Insufficient funds!") end
	end

	gameItem.buyButton = widget.newButton({
		id = "buy_" .. gameItem.id,
		x = 30, y = 80,
		width = 50, height = 50,
		label = "Buy",
		onPress = buy
	})
	gameItem:insert(gameItem.buyButton)

	function gameItem:setBuyEnabled(enabled)
		self.buyButton.isVisible = enabled
	end

	function gameItem:startListeningEvents()
		-- nothing to do :)
	end

	function gameItem:stopListeningEvents()
		-- nothing to do :)
	end

	function gameItem:setCost(purchase)
		if self.cost then
			self.cost:removeSelf()
			self.cost = nil
		end

		if purchase.purchaseType == "market" then
			self.cost = display.newText({
				parent = self,
				text = "cost: $" .. tostring(purchase.product.price),
				x = 160, y = 80,
				fontSize = 13,
				font = native.systemFontBold,
				align = "right",
			})
			self.cost.anchorX = 0
			self.cost:setFillColor({0.5,0.5,0.5,1})
		else
			self.cost = display.newGroup()
			local currencyId = virtualItem.purchase.exchangeCurrency.itemId
			local texture = display.newImageRect(GameItem.currencies[currencyId],30,30)
			self.cost:insert(texture)

			local balance = display.newText({
				parent = self.cost,
				text = "x " .. tostring(purchase.exchangeCurrency.amount),
				fontSize = 15,
				x = 20,
				align = "left"
			})
			balance.anchorX = 0
			balance:setFillColor({0.8,0.8,0.8,1})
			self.cost.x = 220
			self.cost.y = 80
			gameItem:insert(self.cost)
		end
	end

	gameItem.virtualItem = virtualItem
	gameItem:setCost(gameItem.virtualItem.purchase)
	
	return gameItem
end

return GameItem