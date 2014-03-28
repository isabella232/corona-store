local widget = require "widget"

local MainMenu = {}
MainMenu.event_OptionSelected = "MainMenu_OptionSelected"

local function rowRenderListener(event)
	local row = event.row
	local title = display.newText({
		parent = row,
		text = row.params.title,
		x = 10, y = row.contentHeight * 0.5,
		fontSize = 20,
		align = "left"
	})
	title.anchorX = 0
	title:setFillColor(0.5,0.5,0.5,1)
end

local function rowTouchListener(event)
	if event.phase ~= "tap" then return end
	Runtime:dispatchEvent({name = MainMenu.event_OptionSelected, row = event.target })
end

function MainMenu:new(id,rows)

	local menu = widget.newTableView({
		id = id,
		x = display.contentCenterX, 
		y = ResolutionUtil:anchoredY(display.contentHeight * 0.5),
		width = ResolutionUtil.deviceWidth - 20, 
		height = ResolutionUtil.deviceHeight - 120,
		noLines = true,
		onRowRender = rowRenderListener,
		onRowTouch = rowTouchListener
	})

	for index,row in ipairs(rows) do
		menu:insertRow(self:newRow(row.id,row.title))
	end

	return menu
end

function MainMenu:newRow(id,title)
	local row = {
		id = id,
		rowHeight = 50,
		rowColor = { default = {1,1,1,1}, over = {0,0,1,0.2} },
		params = {
			title = title
		}
	}
	return row;
end

return MainMenu