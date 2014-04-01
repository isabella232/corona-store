local widget = require "widget"
local soomla = require "plugin.soomla"

local GameItem = {}

function GameItem:new(id,message)
	
	local gameItem = display.newGroup()

	local singleUseVG = soomla.getSingleUseVG(id)
	gameItem.id = singleUseVG.itemId
	gameItem.message = message
	gameItem.name = display.newText({
		parent = gameItem,
		text = singleUseVG.name,
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
		text = singleUseVG.description,
		x = 0, y = 50,
		fontSize = 13,
		align = "left",
	})
	gameItem.description.anchorX = 0
	gameItem.description:setFillColor({0.5,0.5,0.5,1})

	gameItem.balance = display.newText({
		parent = gameItem,
		text = "x " .. tostring(soomla.getItemBalance(gameItem.id)),
		x = 190, y = 27,
		fontSize = 15,
		align = "right"
	})
	gameItem.balance.anchorX = 0
	gameItem.balance:setFillColor({0.7,0.7,0.7,1})

	local function use(event)
		local balance = soomla.getItemBalance(gameItem.id)
		if balance < 1 then print("Can't use it!")
		else 
			print(gameItem.message)
			soomla.takeItem(gameItem.id)
		end
	end

	gameItem.useButton = widget.newButton({
		id = "use_" .. gameItem.id,
		x = 30, y = 80,
		width = 50, height = 50,
		label = "Use",
		onPress = use
	})
	gameItem:insert(gameItem.useButton)

	local function buy(event)
		soomla.buyItem(gameItem.id)
	end

	gameItem.buyButton = widget.newButton({
		id = "buy_" .. gameItem.id,
		x = 100, y = 80,
		width = 50, height = 50,
		label = "Buy",
		onPress = buy
	})
	gameItem:insert(gameItem.buyButton)

	local function updateBalance(event)
		if event.virtualGood.itemId == gameItem.id then
			gameItem.balance.text = "x " .. tostring(event.balance)
		end
	end

	function gameItem:startListeningEvents()
		Runtime:addEventListener("soomla_ChangedGoodBalance",updateBalance)
	end

	function gameItem:stopListeningEvents()
		Runtime:removeEventListener("soomla_ChangedGoodBalance",updateBalance)
	end

	return gameItem
end

return GameItem