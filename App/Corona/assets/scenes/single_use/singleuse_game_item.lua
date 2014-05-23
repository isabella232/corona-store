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
  
  local function drawLevelOrbs(amount)
    local position = 280
    for i = 1, amount, 1 do
      local orb = display.newCircle(position,12,5)
      orb:setFillColor(0.5,0.5,1)
      gameItem:insert(orb)
      position = position - 11
    end
    local upgrades = display.newText({
      parent = gameItem,
      width = 70,
      x = position, y = 12,
      fontSize = 10,
      text = "Upgrades",
      align = "right"
    })
    upgrades.anchorX = 70
    upgrades:setFillColor(0.2,0.2,0.2)
  end

  if soomla.itemHasUpgrades(gameItem.id) then
      local currentLevel = soomla.itemUpgradeLevel(gameItem.id)
      if currentLevel > 0 then
        drawLevelOrbs(currentLevel)      
        local currentUpgradeId = soomla.itemCurrentUpgrade(gameItem.id)
        local currentUpgrade = soomla.getUpgradeVG(currentUpgradeId)
        -- gameItem.name.text = currentUpgrade.name
        gameItem.description.text = currentUpgrade.description
      end
  end

	gameItem.balance = display.newText({
		parent = gameItem,
		text = "x " .. tostring(soomla.getItemBalance(gameItem.id)),
		x = 280, y = 29,
    	width = 200,
		fontSize = 15,
		align = "right"
	})
	gameItem.balance.anchorX = 200
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