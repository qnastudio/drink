
local storyboard = require( "storyboard" )
local widget = require( "widget" )
local scene = storyboard.newScene()
-- Called when the scene's view does not exist:
function scene:createScene( event )
	local group = self.view

	local back = display.newImageRect( group,"untitled.png" ,320,480)
	back.x,back.y=display.contentCenterX,display.contentCenterY
	group:insert(back)


	local img = display.newImageRect(group,"shakeitup.png",230,210)
	img.x,img.y=90,75
	group:insert( img)

	local function goRelease(  )
		-- body
		storyboard.gotoScene( "slot" ,{time = storyboard.parameters.sceneChangTime,effect="fade"} )
	end

	local go = widget.newButton{
	defaultFile = "go.png",
	left = 200,
	top= 350,
	width = 100,
	height= 100,
	onRelease = goRelease

}
	go.rotation = -10

	group:insert(go)

end

function scene:enterScene( event )
	local group = self.view
	
end


-- Called when scene is about to move offscreen:
function scene:exitScene( event )
	local group = self.view
	
	-----------------------------------------------------------------------------
	
	--	INSERT code here (e.g. stop timers, remove listeners, unload sounds, etc.)
	
	-----------------------------------------------------------------------------
	
end

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

scene:addEventListener( "destroyScene", scene )

---------------------------------------------------------------------------------

return scene