
local storyboard = require( "storyboard" )
local widget = require( "widget" )
local scene = storyboard.newScene()
local score = 100
system.deactivate( "multitouch" )
-- Called when the scene's view does not exist:
function scene:createScene( event )
	local group = self.view

	
	local final = display.newImageRect( group,"teaFinal.png" , system.DocumentsDirectory ,300,330)
	final.x,final.y=220,200

	local lemonBody = display.newImageRect( group,"img/finalMark.png" ,275,300)
	lemonBody.x,lemonBody.y=display.contentCenterX-20,display.contentCenterY-15
	lemonBody.rotation = -10

	score = score + (teaCatch+iceCatch+sugarCatch - teaN -iceN - sugarN ) * 5 

	local text = display.newText( "Score: "..score ,160,30,"Arial",40 )
	text.rotation=-5
	text:setFillColor( 0 )

	group:insert( text)

	local function back(  )
		-- body
		storyboard.gotoScene( "start3", {timer=1,effect = "fade"})

	end
	
	local goBack = widget.newButton
	{	
         left = 240,
         top = 300,	
		 width = 70,
		 height = 70,    
         defaultFile ="img/back.png" ,
         --overfile
         onEvent = back

	}
	group:insert(goBack)
	--fb and friend
	local fb = display.newImageRect(group,"img/fb.png",50,50)
	fb.x,fb.y=270,380
	local friend= display.newImageRect( group,"img/friend.jpg",50,50)
	friend.x,friend.y= 270,440
	local button1 = widget.newButton
	{
		width = 200,
		height = 50,
		x=130,
		y=380,
		defaultFile = "img/buttonBlue.png",
		--overFile = "buttonBlueSmallOver.png",
		label = "Feed your pet!",
		labelColor = {default = {1,1,1},over = {0,0,0,0.5}},
		fontSize = 20,
		emboss = true,
		--onEvent = buttonHandler,
	}
	group:insert( button1 )

	local button2 = widget.newButton
	{
		width = 200,
		height = 50,
		x=130,
		y=440,
		defaultFile = "img/buttonBlue.png",
		--overFile = "buttonBlueSmallOver.png",
		label = "Feed your friend!",
		labelColor = {default = {1,1,1},over = {0,0,0,0.5}},
		fontSize = 20,
		emboss = true,
		--onEvent = buttonHandler,
	}
	group:insert( button2 )
	
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