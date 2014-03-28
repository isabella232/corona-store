local soomla = require "plugin.soomla"

local Ads = display.newGroup()

if not soomla.nonConsumableItemExists(TheTavern.NONCONSUMABLE_NOADS_ID) then

	Ads.background = display.newRoundedRect(Ads,display.contentCenterX,ResolutionUtil:anchoredY(450),300,50,5)
	Ads.background:setFillColor(0.4,0.4,0.4,1)

	Ads.text = display.newText({
		parent = Ads,
		text = "I'm here! Click! Buy!",
		x = Ads.background.x,
		y = Ads.background.y + 14,
		width = Ads.background.width,
		height = Ads.background.height,
		fontSize = 16,
		align = "center"
	})

	local function purchaseListener(event)
		if event.purchasableItem.itemId ~= TheTavern.NONCONSUMABLE_NOADS_ID then return end
		Runtime:removeEventListener("soomla_ItemPurchased",purchaseListener)
		Ads.isVisible = false
	end

	Runtime:addEventListener("soomla_ItemPurchased",purchaseListener)
end

return Ads