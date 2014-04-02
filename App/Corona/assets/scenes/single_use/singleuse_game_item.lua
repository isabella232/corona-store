local soomla = require "plugin.soomla"
local widget = require "widget"
local GameItem = require "assets.core.game_item"

local SingleUseGameItem = {}

function SingleUseGameItem:new(id)

	local gameItem = GameItem:new(id)

	if gameItem.virtualItem.class == "SingleUsePackVG" then
		-- There's nothing to be done here o/
		return gameItem
	end

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
		if balance < 1 then Notifier:show("You don't have any to use!")
		else soomla.takeItem(gameItem.id,1) end
	end

	gameItem.useButton = widget.newButton({
		id = "use_" .. gameItem.id,
		x = 100, y = 80,
		width = 50, height = 50,
		label = "Use",
		onPress = use
	})
	gameItem:insert(gameItem.useButton)

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

return SingleUseGameItem