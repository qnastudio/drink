----------------------------------------------------------------------------------
--
-- chooseCupOverlay.lua
--
----------------------------------------------------------------------------------

local storyboard = require( "storyboard" )
local widget = require( "widget" )
local scene = storyboard.newScene()

----------------------------------------------------------------------------------
-- 
--	NOTE:
--	
--	Code outside of listener functions (below) will only be executed once,
--	unless storyboard.removeScene() is called.
-- 
---------------------------------------------------------------------------------

---------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

-- Called when the scene's view does not exist:
function scene:createScene( event )
	local group = self.view

	local bg =display.newRect( group,0,0,display.viewableContentWidth,display.viewableContentHeight )
	bg.x,bg.y = 160,240
	bg:setFillColor( 1 )

	
	--[[local backImg = display.newImageRect( group,"special.jpg",display.viewableContentWidth,display.viewableContentHeight)
	backImg.x,backImg.y = display.contentCenterX,display.contentCenterY
	--]]

	--local backImg = display.newImageRect( group,"star.png", display.contentWidth/5*4, display.contentHeight/5*4+100)
	--backImg.x,backImg.y = display.contentCenterX,display.contentCenterY+40

	--local text = display.newText( group,"Drink of The Day !" ,160,50,system.nativeFont,30)
	--text.rotation = -5
	--text:setFillColor(0)

	local mark = display.newImageRect( group,"logo2.png",100,50 )
	mark.x,mark.y = 260,35

	local image = nil
	

	if (temp == 1) then
		image = display.newImageRect(group, "d1.png", display.contentWidth/5*4, display.contentHeight/5*4)
	elseif(temp == 2)then
		image = display.newImageRect(group, "d2.png", display.contentWidth/5*4, display.contentHeight/5*4)
	elseif(temp == 0)then
		image = display.newImageRect(group, "d3.png", display.contentWidth/5*4, display.contentHeight/5*4)
	end
	
	image.x = display.contentCenterX
	image.y = display.contentCenterY+50
	

	local function onImageTouch( event )
		if event.phase == "began" then
	        storyboard.hideOverlay( "fade", storyboard.parameters.sceneChangeTime )
	        storyboard.gotoScene( "chooseTea"  )
	    end
	    return true
	end

	image:addEventListener( "touch", onImageTouch )
	-----------------------------------------------------------------------------
		
	--	CREATE display objects and add them to 'group' here.
	--	Example use-case: Restore 'group' from previously saved state.
	
	-----------------------------------------------------------------------------
	
end


-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	local group = self.view
	
	-----------------------------------------------------------------------------
		
	--	INSERT code here (e.g. start timers, load audio, start listeners, etc.)
	
	-----------------------------------------------------------------------------
	
end


-- Called when scene is about to move offscreen:
function scene:exitScene( event )
	local group = self.view
	
	-----------------------------------------------------------------------------
	
	--	INSERT code here (e.g. stop timers, remove listeners, unload sounds, etc.)
	
	-----------------------------------------------------------------------------
	
end


-- Called prior to the removal of scene's "view" (display group)
function scene:destroyScene( event )
	local group = self.view

   	for i = group.numChildren, 1, -1 do
    	if group[i] ~= nil then
       	 	 group[i]:removeSelf()
        	 group[i] = nil
     	end
   	end
	
end

---------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

-- "createScene" event is dispatched if scene's view does not exist
scene:addEventListener( "createScene", scene )

-- "enterScene" event is dispatched whenever scene transition has finished
scene:addEventListener( "enterScene", scene )

-- "exitScene" event is dispatched before next scene's transition begins
scene:addEventListener( "exitScene", scene )

-- "destroyScene" event is dispatched before view is unloaded, which can be
-- automatically unloaded in low memory situations, or explicitly via a call to
-- storyboard.purgeScene() or storyboard.removeScene().
scene:addEventListener( "destroyScene", scene )

---------------------------------------------------------------------------------

return scene