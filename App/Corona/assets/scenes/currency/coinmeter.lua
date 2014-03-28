local CoinMeter = {}

function CoinMeter:new()

	local coinMeter = display.newGroup()

	coinMeter.coins = display.newImageRect("assets/images/coins.png",288,288)
	coinMeter.coins.width = 80
	coinMeter.coins.height = 80
	coinMeter.anchorX = coinMeter.coins.width
	coinMeter:insert(coinMeter.coins)

	coinMeter.amount = display.newText({
		parent = coinMeter,
		text = "x 0",
		x = coinMeter.coins.x + 20,
		align = "left"
	})
	coinMeter.amount.anchorX = 0
	coinMeter.amount:setFillColor(0.8,0.8,0.8,1)

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