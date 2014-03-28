local CoinMeter = {}

function CoinMeter:new()

	local coinMeter = display.newGroup()

	coinMeter.coins = display.newImageRect("assets/images/coins.png",288,288)
	coinMeter.coins.width = 80
	coinMeter.coins.height = 80
	coinMeter:insert(coinMeter.coins)

	coinMeter.amount = display.newText({
		parent = coinMeter,
		text = "x 0",
		x = coinMeter.coins.x + coinMeter.coins.width * 0.5,
		align = "left",
		fontSize = 30
	})
	coinMeter.amount.anchorX = 0
	coinMeter.amount:setFillColor(0.5,0.5,0.5,1)

	function coinMeter:setAmount(amount)
		coinMeter.amount.text = "x " .. tostring(amount)
	end

	local function currencyBalanceListener(event)
		if event.currency.itemId == TheTavern.CURRENCY_GOLD_ID then
			coinMeter:setAmount(event.amount)
		end
	end

	function coinMeter:startListeningEvents()
		Runtime:addEventListener("soomla_CurrencyBalanceChanged",currencyBalanceListener)
	end

	function coinMeter:stopListeningEvents()
		Runtime:removeEventListener("soomla_CurrencyBalanceChanged",currencyBalanceListener)
	end
	
	return coinMeter
end

return CoinMeter