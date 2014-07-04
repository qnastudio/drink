

local storyboard= require( "storyboard")
local scene = storyboard.newScene( )


function scene:createScene( event )
	-- body
	local group = self.view
	local image = display.newImageRect( group,"icesugarOverlay.jpg" , display.viewableContentWidth,display.viewableContentHeight )
	image.x= display.contentCenterX
	image.y = display.contentCenterY

	local function onTouch( event )
		-- body
		if (event.phase=="began") then
			storyboard.hideOverlay( "fade", storyboard.parameters.sceneChangeTime )
			storyboard.purgeScene( "icesugarOverlay" )
		end
		return true
	end

	image:addEventListener( "touch", onTouch )
end

function scene:enterScene( event )
	-- body
	local group = self.view
end

function scene:exitScene( event )
	-- body
end

function scene:destoryScene( event )
	-- body
	local group = self.view

   	for i = group.numChildren, 1, -1 do
    	if group[i] ~= nil then
       	 	 group[i]:removeSelf()
        	 group[i] = nil
     	end
   	end
end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener("destoryScene",scene)
return scene