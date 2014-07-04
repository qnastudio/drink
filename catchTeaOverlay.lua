----------------------------------------------------------------------------------
--
-- catchTeaOverlay.lua
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

	--[[local image = display.newImageRect( "catchTeaOverlay.jpg", display.contentWidth, display.contentHeight)
	image.x = display.contentCenterX
	image.y = display.contentCenterY
	group:insert(image)
	
	local function onImageTouch( event )
		if event.phase == "began" then
	        toScene = true
	        storyboard.hideOverlay( "fade", storyboard.parameters.sceneChangeTime )
	        storyboard.purgeScene( "catchTeaOverlay" )

	    end
	    return true
	end
	--]]
	local bg =display.newRect( group,0,0,display.viewableContentWidth,display.viewableContentHeight )
	bg.anchorX,bg.anchorY=0,0
	bg:setFillColor( 1)
	group:insert(bg)

	local ice = widget.newSegmentedControl
	{
		left = 40,
   		top = 150,
   		segmentWidth = 60,
   		segments = { "去冰", "少冰", "正常", "多冰" },
    	defaultSegment = 3,
    	--onPress = onSegmentPress
	}
	group:insert(ice)

	local iceText = display.newText( "冰塊" ,40,120,"Arial",25 )  
	iceText:setFillColor(0)
	group:insert(iceText)

	local sugar = widget.newSegmentedControl
	{
		left = 30,
   		top = 250,
   		segmentWidth = 50,
   		segments = { "無糖", "三分糖", "半糖", "八分糖" ,"正常"},
    	defaultSegment = 5,
    	--onPress = onSegmentPress
	}
	group:insert(sugar)

	local sugarText = display.newText("甜度",40,220,"Arial",25)
	sugarText:setFillColor( 0 )
	group:insert(sugarText)


	local function okRelease(  )
		-- body
		toScene = true
	    storyboard.hideOverlay( "fade", storyboard.parameters.sceneChangeTime )
	    storyboard.purgeScene( "catchTeaOverlay" )
	end

	local ok = widget.newButton
	{
		defaultFile = "img/ok.png",
		left = 240,
		top=  335,
		width = 60,
		height = 60,
		--sound  onPress = onBtnPress,
		onRelease = okRelease
	}
	--finish.rotation=-10

	group:insert(ok)

	--image:addEventListener( "touch", onImageTouch )
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
	
	-----------------------------------------------------------------------------
		for i = group.numChildren, 1, -1 do
    	if group[i] ~= nil then
       	 	 group[i]:removeSelf()
        	 group[i] = nil
     	end
   	end
	
	-----------------------------------------------------------------------------
	
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