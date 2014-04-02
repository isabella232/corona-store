local Notifier = display.newGroup()

Notifier.background = display.newRoundedRect(Notifier,display.contentCenterX,ResolutionUtil:anchoredY(-100),300,50,5)
Notifier.background:setFillColor(0.4,0.4,0.4,1)

Notifier.message = display.newText({
	parent = Notifier,
	text = "",
	x = Notifier.background.x,
	y = Notifier.background.y + 14,
	width = Notifier.background.width,
	height = Notifier.background.height,
	fontSize = 16,
	align = "center"
})

local function wait()
	Notifier.transition = transition.to(Notifier,{
		y = ResolutionUtil:anchoredY(-100),
		transition = easing.inBack,
		time = 1000,
		delay = 2000
	})
end

function Notifier:show(message)
	self:toFront()
	self.message.text = message
	if self.transition then transition.cancel(self.transition) end
	self.y = ResolutionUtil:anchoredY(-100)
	self.transition = transition.to(self,{
		y = 130,
		transition = easing.outBack,
		time = 1000,
		onComplete = wait
	})
end


return Notifier