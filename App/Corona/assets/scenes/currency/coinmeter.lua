local widget = require "widget"

local CoinMeter = {}
CoinMeter.event_Give = "CoinMeter_Give"
CoinMeter.event_Take = "CoinMeter_Take"

-- ADD CURRENCY NAMES
-- STOP LISTENING EVENTS WHEN THE SCENE IS NOT OPEN

function CoinMeter:new(id,displayObject)

	local coinMeter = display.newGroup()
	coinMeter.currencyId = id
	coinMeter:insert(displayObject)

	coinMeter.amount = display.newText({
		parent = coinMeter,
		text = "x 0",
		x = displayObject.x + displayObject.width * 0.5,
		align = "left",
		fontSize = 30
	})
	coinMeter.amount.anchorX = 0
	coinMeter.amount:setFillColor(0.5,0.5,0.5,1)

	function coinMeter:setAmount(amount)
		coinMeter.amount.text = "x " .. tostring(amount)
	end

	local function currencyBalanceListener(event)
		if event.currency.itemId == coinMeter.currencyId then
			coinMeter:setAmount(event.balance)
		end
	end

	function coinMeter:startListeningEvents()
		Runtime:addEventListener("soomla_ChangedCurrencyBalance",currencyBalanceListener)
	end

	function coinMeter:stopListeningEvents()
		Runtime:removeEventListener("soomla_ChangedCurrencyBalance",currencyBalanceListener)
	end

	local function buttonListener(event)
		if event.target.id == "give_button" then Runtime:dispatchEvent({name = CoinMeter.event_Give, currency = coinMeter.currencyId})
		else Runtime:dispatchEvent({name = CoinMeter.event_Take, currency = coinMeter.currencyId }) end
	end

	coinMeter.giveButton = widget.newButton({
		id = "give_button",
		label = "+ 100",
		x = ResolutionUtil:anchoredX(80),
		y = 70,
		width = 140, height = 50,
		onPress = buttonListener
	})
	coinMeter:insert(coinMeter.giveButton)

	coinMeter.takeButton = widget.newButton({
		id = "take_button",
		label = "- 100",
		x = ResolutionUtil:anchoredX(240),
		y = 70,
		width = 140, height = 50,
		onPress = buttonListener
	})
	coinMeter:insert(coinMeter.takeButton)

	
	return coinMeter
end

return CoinMeter