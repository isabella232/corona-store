local widget = require "widget"
local GameItem = require "assets.core.game_item"

local GameItemList = {}

local function rowRenderListener(event)
	local row = event.row
	row.gameItem = GameItem:new(row.params.itemId,row.params.message)
	row.gameItem.x = 10
	row.gameItem:startListeningEvents()
	row:insert(row.gameItem)
end

function GameItemList:new(id,rows)

	local menu = widget.newTableView({
		id = id,
		top = ResolutionUtil:anchoredY(10),
		left = ResolutionUtil:anchoredX(10),
		width = ResolutionUtil.deviceWidth - 20,
		height = ResolutionUtil.deviceHeight - 150,
		noLines = true,
		onRowRender = rowRenderListener
	})

	for index,row in ipairs(rows) do
		menu:insertRow(self:newRow(row.itemId,row.message))
	end

	function menu:startListeningEvents()
		--[[local numRows = self:getNumRows()
		for i = 1, numRows, 1 do
			local row = self:getRowAtIndex(i)
			if row then 
				print(row.gameItem.id)
				row.gameItem:startListeningEvents() 
			end
		end]]--
	end

	function menu:stopListeningEvents()
		local numRows = self:getNumRows()
		for i = 1, numRows, 1 do
			local row = self:getRowAtIndex(i)
			if row then row.gameItem:stopListeningEvents() end
		end
	end

	return menu
end

function GameItemList:newRow(id,message)
	local row = {
		id = id,
		rowHeight = 100,
		rowColor = { default = {0.8,0.8,0.8,1}, over = {0,0,1,0.2} },
		params = {
			itemId = id,
			message = message
		}
	}
	return row;
end


return GameItemList