local widget = require "widget"

local GameItemList = {}
GameItemList._gameItem_class = require "assets.core.game_item"

local function rowRenderListener(event)
	local row = event.row
	row.gameItem = row.params.owner._gameItem_class:new(row.params.itemId)
	row.gameItem.x = 10
	row.gameItem:startListeningEvents()
	row:insert(row.gameItem)
end

function GameItemList:new(id,rows,gameItemClass)
  
	local menu = widget.newTableView({
		id = id,
		top = ResolutionUtil:anchoredY(10),
		left = ResolutionUtil:anchoredX(10),
		width = ResolutionUtil.deviceWidth - 20,
		height = ResolutionUtil.deviceHeight - 170,
		noLines = true,
		onRowRender = rowRenderListener
	})
  menu.dataSource = rows
  if gameItemClass then menu._gameItem_class = require(gameItemClass) 
	else menu._gameItem_class = require "assets.core.game_item"  end

  function menu:loadRows()
    for index,itemId in ipairs(menu.dataSource) do
      menu:insertRow(GameItemList:newRow(itemId,menu))
    end
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

function GameItemList:newRow(id,tableView)
	local row = {
		id = id,
		rowHeight = 100,
		rowColor = { default = {0.8,0.8,0.8,1}, over = {0,0,1,0.2} },
		params = {
			itemId = id,
      owner = tableView
		}
	}
	return row;
end


return GameItemList