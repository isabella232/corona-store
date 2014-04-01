local storyboard = require "storyboard"
local GameItemList = require "assets.core.game_item_list"

local scene = storyboard.newScene()

-- Item Table
function scene:createItemTable() 
	local items = {
		{ itemId = TheTavern.SINGLEUSE_MUGOFBEER_ID, message = "+ 20 HP!", image = "assets/images/mug_beer.jpg" },
		{ itemId = TheTavern.SINGLEUSE_BOTTLEOFBEER_ID, message = "+ 50 HP!", image = "assets/images/bottle_beer.jpg" },
		{ itemId = TheTavern.SINGLEUSE_MAGICALPOTION_ID, message = "+ 100 HP!", image = "assets/images/magical_potion.png" },
		{ itemId = TheTavern.SINGLEUSE_MAGICALANTIDOTE_ID, message = "+ 100 HP / - Poison", image = "assets/images/magical_antidote.gif" },
		{ itemId = TheTavern.SINGLEUSE_GOBLINGRENADE_ID, message = "-> 10 Damage!", image = "assets/images/goblin_grenade.png" },
		{ itemId = TheTavern.SINGLEUSE_POISONEDARROW_ID, message = "-> 2 Damage + Poison!", image = "assets/images/poisoned_arrow.png" }
	}
	self.itemList = GameItemList:new("single_use_list",items)
	self.view:insert(self.itemList)
end


function scene:createScene()
	self:createItemTable()
end

function scene:willEnterScene()

end

function scene:enterScene()
	self.itemList:startListeningEvents()
end

function scene:willExitScene()
	self.itemList:stopListeningEvents()
end

scene:addEventListener("createScene",scene)
scene:addEventListener("willEnterScene",scene)
scene:addEventListener("enterScene",scene)
scene:addEventListener("willExitScene",scene)

return scene