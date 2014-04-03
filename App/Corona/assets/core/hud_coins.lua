local soomla = require "plugin.soomla"

local CoinsHud = {}

function CoinsHud:new(currencies)

	local coinsHud = display.newGroup()
	coinsHud.huds = {}

	local initialPosition = -100
	local width = 100
	for index,value in ipairs(currencies) do
		local position = initialPosition + index * width
		coinsHud.huds[value.id] = CoinsHud:createSingleHud(coinsHud,position,value)
	end

	local function updateBalance(event)
		local currencyId = event.currency.itemId
		coinsHud.huds[currencyId]:updateBalance(event.balance)
	end

	function coinsHud:startListeningEvents()
		Runtime:addEventListener("soomla_ChangedCurrencyBalance",updateBalance)
	end

	function coinsHud:stopListeningEvents()
		Runtime:removeEventListener("soomla_ChangedCurrencyBalance",updateBalance)
	end

	return coinsHud
end

function CoinsHud:createSingleHud(parent,position,currency)

	local singleHud = display.newGroup()
	singleHud.currencyId = currency.id

	local texture = display.newImageRect(currency.texturepath,30,30)
	singleHud:insert(texture)

	singleHud.balance = display.newText({
		parent = singleHud,
		text = "x " .. tostring(soomla.getItemBalance(currency.id)),
		fontSize = 15,
		x = 20,
		align = "left"
	})
	singleHud.balance.anchorX = 0
	singleHud.balance:setFillColor({0.8,0.8,0.8,1})

	function singleHud:updateBalance(balance)
		self.balance.text = "x " .. tostring(balance)
	end

	singleHud.x = position
	parent:insert(singleHud)
	return singleHud
end

return CoinsHud