local ResolutionUtil = {}

-- Device
ResolutionUtil.deviceWidth = 320
ResolutionUtil.deviceHeight = 480

-- Virtual
ResolutionUtil.virtualWidth = 320
ResolutionUtil.virtualHeight = 480

function ResolutionUtil:anchoredX(x)
	local anchoredX = 0
	if x < display.contentWidth * 0.5 then anchoredX = diplay.screenOriginX + x
	else anchoredX = display.screenOriginX + self.deviceWidth - self.virtualWidth + x end
	return anchoredX
end

function ResolutionUtil:anchoredY(y)
	local anchoredY = 0
	if y < display.contentHeight * 0.5 then anchoredY = y
	else anchoredY = self.deviceHeight - self.virtualHeight + y end
	return anchoredY
end

return ResolutionUtil