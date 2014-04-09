local soomla = require "plugin.soomla"
local widget = require "widget"
local GameItem = require "assets.core.game_item"

local UpgradeGameItem = {}

-- ADD MORE UPGRADES

function UpgradeGameItem:new(id)

	local gameItem = GameItem:new(id)
	gameItem.buyButton.x = 250
	gameItem.buyButton.y = 20
	gameItem.description.y = gameItem.description.y + 20
	gameItem.buyButton:setLabel("Upgrade")
  
  gameItem.fullyUpgraded = display.newText({
    parent = gameItem,
    x = 230, y = 20,
    text = "Fully Upgraded",
    fontSize = 12
  })
  gameItem.fullyUpgraded:setFillColor(0.2,0.2,0.2)
  gameItem.fullyUpgraded.isVisible = false
	
	local function upgradeListener(event)
		local currentUpgradeLevel = soomla.itemUpgradeLevel(gameItem.id)
		local upgrades = soomla.upgradesForItem(gameItem.id)
		if currentUpgradeLevel >= #upgrades then
      local currentUpgrade = upgrades[currentUpgradeLevel]
      gameItem.name.text = currentUpgrade.name
      gameItem.description.text = currentUpgrade.description
      gameItem.fullyUpgraded.isVisible = true
			gameItem:setBuyEnabled(false)
		else
			local nextUpgrade = upgrades[currentUpgradeLevel + 1]
      gameItem.name.text = nextUpgrade.name
			gameItem.description.text = nextUpgrade.description
			gameItem:setCost(nextUpgrade.purchase)
		end
	end

	upgradeListener(0)

	function gameItem:buy()
		local currentUpgrade = soomla.itemUpgradeLevel(self.id)
		local upgrades = soomla.upgradesForItem(self.id)
		local nextUpgrade = upgrades[currentUpgrade + 1]
		if soomla.canBuyItem(nextUpgrade.itemId) then soomla.upgradeItem(self.id)
		else Notifier:show("Insufficient funds!") end
	end

	function gameItem:startListeningEvents()
		Runtime:addEventListener("soomla_VirtualGoodUpgrade",upgradeListener)
	end

	function gameItem:stopListeningEvents()
		Runtime:removeEventListener("soomla_VirtualGoodUpgrade",upgradeListener)
	end

	return gameItem
end

return UpgradeGameItem