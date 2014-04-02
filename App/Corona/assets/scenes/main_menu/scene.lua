local storyboard = require "storyboard"
local widget = require "widget"
local MainMenu = require "assets.scenes.main_menu.menu"

local scene = storyboard.newScene()


-- Title
function scene:createTitle()
	self.title = display.newText({
		text = "Choose your destiny",
		x = display.contentCenterX, 
		y = ResolutionUtil:anchoredY(50),
		width = ResolutionUtil.deviceWidth, 
		height = 50,
		fontSize = 20,
		font = native.systemFontBold,
		align = "center"
	})
	self.title:setFillColor(0.5,0.5,0.5,1)
	self.view:insert(self.title)
end

-- Menu
local function goTo(sceneName)
	storyboard.gotoScene(sceneName,Scenes.leftTransition)
end

local function optionListener(event)
	goTo(event.row.params.scene)
end

function scene:createMenuTableView()
	local rows = {
		{ id = "option_currency", title = "Virtual Currency", scene = Scenes.currency },
		{ id = "option_singleuse", title = "Single Use Virtual Goods", scene = Scenes.singleUse },
		{ id = "option_lifetime", title = "Lifetime Virtual Goods", scene = Scenes.lifetime },
		{ id = "option_equip", title = "Equippable Virtual Goods", scene = Scenes.currency },
		{ id = "option_noads", title = "Remove Ads", scene = Scenes.currency },
	}
	self.menu = MainMenu:new("main_menu",rows)
	self.view:insert(self.menu)
end


-- Scene Events
function scene:createScene()
	self:createTitle()
	self:createMenuTableView()
end

function scene:willEnterScene()
	
end

function scene:enterScene()
	Runtime:addEventListener(MainMenu.event_OptionSelected,optionListener)
end

function scene:willExitScene()
	Runtime:removeEventListener(MainMenu.event_OptionSelected,optionListener)
end

scene:addEventListener("createScene",scene)
scene:addEventListener("willEnterScene",scene)
scene:addEventListener("enterScene",scene)
scene:addEventListener("willExitScene",scene)

return scene