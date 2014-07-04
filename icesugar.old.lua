
local storyboard= require( "storyboard")
local widget = require( "widget")
local scene = storyboard.newScene( )


function scene:createScene( event )
	-- body
	display.setDefault( "fillColor", 0 )

	local group=self.view
	local cup = display.newImageRect(group,"ccup.jpg",cupW,cupH )
	cup.x,cup.y=cupX,cupY


	local ice = widget.newSlider
	{
		left = 70,
		top = 305,
		width = 200

	}
	group:insert( ice )
	local sugar = widget.newSlider
	{
		left = 70,
		top = 345,
		width = 200

	}
	
	group:insert(sugar)
	
	local iceText = display.newText( "冰塊" ,42,328,"Arial",10)

	group:insert(iceText)

	local sugarText = display.newText( "甜度",42,368,"Arial",10 )


	group:insert(sugarText)


		
	

end

function scene:enterScene( event )
	-- body
	local group = self.view

	storyboard.showOverlay( "icesugarOverlay" ,{ time = storyboard.parameters.sceneChangTime, effect = "fade" } )
end

function scene:exitScene( event )
	-- body
end

function scene:destoryScene( event )
	-- body
end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )

return scene