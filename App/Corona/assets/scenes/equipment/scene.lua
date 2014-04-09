local storyboard = require "storyboard"
local widget = require "widget"
local GameItemList = require "assets.core.game_item_list"
local CoinsHud = require "assets.core.hud_coins"

local scene = storyboard.newScene()

-- Item Table
function scene:createItemTable() 
	local items = {
		TheTavern.EQUIPPABLE_IRONSWORD_ID,
		TheTavern.EQUIPPABLE_BRONZESPEAR_ID,
		TheTavern.EQUIPPABLE_IRONHELMET_ID,
		TheTavern.EQUIPPABLE_IRONCHEST_ID,
		TheTavern.EQUIPPABLE_BRONZECHEST_ID,
		TheTavern.EQUIPPABLE_NECKLACE_ID,
		TheTavern.EQUIPPABLE_IRONSET_ID,
	}
	self.itemList = GameItemList:new("equipment_use_list",items,"assets.scenes.equipment.equipment_game_item")
	self.view:insert(self.itemList)
end

-- Coins
function scene:createCoins()
	local currencies = {
		{ id = TheTavern.CURRENCY_GOLD_ID, texturepath = "assets/images/coins.png" },
		{ id = TheTavern.CURRENCY_SKILLPOINTS_ID, texturepath = "assets/images/skill_points.png" }
	}
	self.coinsHud = CoinsHud:new(currencies)
	self.coinsHud.x = ResolutionUtil:anchoredX(20)
	self.coinsHud.y = ResolutionUtil:anchoredY(350)
	self.view:insert(self.coinsHud)
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

function scene:createScene()
	self:createItemTable()
	self:createCoins()
	self:createButtons()
end

function scene:willEnterScene()
  self.itemList:loadRows()
	self.itemList:startListeningEvents()
	self.coinsHud:startListeningEvents()
end

function scene:enterScene()

end

function scene:exitScene()
	self.itemList:stopListeningEvents()
  self.itemList:deleteAllRows()
	self.coinsHud:stopListeningEvents()
end

scene:addEventListener("createScene",scene)
scene:addEventListener("willEnterScene",scene)
scene:addEventListener("enterScene",scene)
scene:addEventListener("exitScene",scene)

return scene