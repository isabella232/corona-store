local ResolutionUtil = {}

-- Device
ResolutionUtil.deviceWidth = display.pixelWidth * display.contentScaleX
ResolutionUtil.deviceHeight = display.pixelHeight * display.contentScaleY

-- Virtual
ResolutionUtil.virtualWidth = 320
ResolutionUtil.virtualHeight = 480

function ResolutionUtil:anchoredX(x)
	local anchoredX = 0
	if x < display.contentWidth * 0.5 then anchoredX = display.screenOriginX + x
	else anchoredX = display.screenOriginX + self.deviceWidth - self.virtualWidth + x end
	return anchoredX
end

function ResolutionUtil:anchoredY(y)
	local anchoredY = 0
	if y < display.contentHeight * 0.5 then anchoredY = display.screenOriginY + y
	else anchoredY = display.screenOriginY + self.deviceHeight - self.virtualHeight + y end
	return anchoredY
end

return ResolutionUtil