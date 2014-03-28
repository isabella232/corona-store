local storyboard = require "storyboard"
local widget = require "widget"
local MainMenu = require "assets.scenes.main_menu.menu"

local scene = storyboard.newScene()


-- Title
function scene:createTitle()
	self.title = display.newText({
		text = "Choose your destiny",
		x = display.contentCenterX, 
		y = ResolutionUtil:anchoredY(35),
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
local function optionListener(event)
	print("Selected Option: " .. event.row.params.title)
end

function scene:createMenuTableView()
	local rows = {
		{ id = "option_currency", title = "Virtual Currency" },
		{ id = "option_singleuse", title = "Single Use Virtual Goods" },
		{ id = "option_lifetime", title = "Lifetime Virtual Goods" },
		{ id = "option_equip", title = "Equippable Virtual Goods" },
		{ id = "option_noads", title = "Remove Ads" },
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