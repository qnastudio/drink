----------------------------------------------------------------------------------
--
-- chooseCup.lua
--
----------------------------------------------------------------------------------

local storyboard = require( "storyboard" )
local widget = require( "widget" )
local physics = require("physics")
local scene = storyboard.newScene()
local pearlGroup={}
local strawberryGroup = {}
local lemonGroup={}
local pearlBtn,strawberryBtn
local pictureGroup = nil
local n1=1 --last time reset cancel number
local n2 =1
local n3 = 1
local n = 0    --energy
local control=false   --whether shaking arrive enough ammount
local to0 = 1 ---n back to zero
local last1 = 0  --number to addbody
local last2 = 0
physics.start( )
system.activate( "multitouch" )
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

	--local myText = display.newText( "Choose Cup", 0, 0, native.systemFont, 30 )
	--myText:setReferencePoint(display.TopCenterReferencePoint)
	--myText.x, myText.y = display.contentCenterX, 100
	--group:insert(myText)
	-- myText:setFillColor( 1, 1, 1 )

	


	
	

	local image = display.newImageRect(group, "img/addIngredientcup.jpg", 350, 350)
	image.x = display.contentCenterX+20
	image.y = display.contentCenterY-30
	print( display.contentCenterX+20,display.contentCenterY-30 )

	local imageFront = display.newImageRect(group, "img/addIngredientcup2.png", 350, 350)
	imageFront.x = display.contentCenterX+20
	imageFront.y = display.contentCenterY-30
	imageFront.alpha = 0.5
	
	--local imageOutline = display.newLine( group, 135, 97,165,280,190,280,216,97 )
	--imageOutline:setStrokeColor( 0 )


	--five botton cancel

	--[[local function pearlPress(event )
		-- body
		
		if (event.target.isOn) then
			pearl.alpha = 1
		end

		if (false==event.target.isOn ) then
			pearl.alpha=0
			pearl.x,pearl.y=pearlBtn.x+25,pearlBtn.y
		end


	end

	pearlBtn = widget.newSwitch
	{
	    left = 25,
	    top = 75,
	    style = "checkbox",
	    onPress= pearlPress
	}
	group:insert( pearlBtn )
	
	local function strawPress(event )
		-- body
		if (event.target.isOn) then
			strawberry.alpha=1
		end
		if(false==event.target.isOn)then	
			strawberry.alpha=0
			strawberry.x,strawberry.y=strawBtn.x+35,strawBtn.y 
		end
	end

	strawBtn = widget.newSwitch
	{
	    left = 25,
	    top = 125,
	    style = "checkbox",
	    onPress=strawPress
	    
	}
	group:insert( strawBtn )

	local checkboxButton = widget.newSwitch
	{
	    left = 25,
	    top = 175,
	    style = "checkbox",
	    
	    
	}
	group:insert( checkboxButton )

	local checkboxButton = widget.newSwitch
	{
	    left = 25,
	    top = 225,
	    style = "checkbox",
	    
	    
	}
	group:insert( checkboxButton )

	local checkboxButton = widget.newSwitch
	{
	    left = 25,
	    top = 275,
	    style = "checkbox",
	    
	    
	}
	group:insert( checkboxButton )

	strawberry = display.newImageRect( group,"straw.png",50,50 )
		strawberry.x,strawberry.y=strawBtn.x+35,strawBtn.y
		strawberry.rotation=-20
		strawberry.alpha=0
		
	
	pearl = display.newImageRect(group,"pearl.png",15,15 )
		pearl.x,pearl.y=pearlBtn.x+25,pearlBtn.y
		pearl.alpha=0	
	--]]

	local function dragAdd( event )
		-- body
		local t = event.target

		-- Print info about the event. For actual production code, you should
		-- not call this function because it wastes CPU resources.
		

		local phase = event.phase
		if "began" == phase then
			-- Make target the top-most object
			local parent = t.parent
			parent:insert( t )
			display.getCurrentStage():setFocus( t, event.id )

			-- Spurious events can be sent to the target, e.g. the user presses 
			-- elsewhere on the screen and then moves the finger over the target.
			-- To prevent this, we add this flag. Only when it's true will "move"
			-- events be sent to the target.
			t.isFocus = true

			-- Store initial position
			t.x0 = event.x - t.x
			t.y0 = event.y - t.y
		elseif t.isFocus then
			if "moved" == phase then
				-- Make object move (we subtract t.x0,t.y0 so that moves are
				-- relative to initial grab point, rather than object "snapping").
				t.x = event.x - t.x0
				t.y = event.y - t.y0
			elseif "ended" == phase or "cancelled" == phase then
				display.getCurrentStage():setFocus( t, nil )
				t.isFocus = false
			end
		end

		-- Important to return true. This tells the system that the event
		-- should not be propagated to listeners of any objects underneath.
		return true
	end

	--pearl:addEventListener( "touch", dragAdd )
	--strawberry:addEventListener( "touch", dragAdd )

	--old botton
	--[[local function onPearl(  )
		-- body
		local pearl =display.newImageRect(group,"pearl.png",15,15 )
		pearlGroup[#pearlGroup+1] = pearl
		pearl.x,pearl.y=pearlBtn.x+25,pearlBtn.y
		pearl:addEventListener( "touch", dragAdd )
	end

	pearlBtn = widget.newButton
	{
		defaultFile = "pearl.png",
		left = 40,
	    top = 75,
	    width = 15,
	    height =15,
	    onPress = onPearl
	}
	group:insert(pearlBtn)



	local function onStrawberry( ... )
		-- body
		local strawberry = display.newImageRect( group,"straw.png",50,50 )
		strawberryGroup[#strawberryGroup+1]=strawberry
		strawberry.x,strawberry.y=strawberryBtn.x+35,strawberryBtn.y
		strawberry:addEventListener( "touch", dragAdd )
	end

	strawberryBtn = widget.newButton
	{
		defaultFile = "straw.png",
		left = 25,
	    top = 125,
	    width = 50,
	    height = 50,
	    onRelease = onStrawberry
	}
	group:insert(strawberryBtn)
	--]]

	--first generate
	local pearl =display.newImageRect(group,"img/pearl.png",15,15 )
		pearlGroup[#pearlGroup+1] = pearl
		pearl.x,pearl.y=47.5,82.5
		pearl:addEventListener( "touch", dragAdd )
		
	local strawberry = display.newImageRect( group,"img/straw.png",20,20 )
		strawberryGroup[#strawberryGroup+1]=strawberry
		strawberry.x,strawberry.y=50,150
		strawberry:addEventListener( "touch", dragAdd )
		
	local lemon = display.newImageRect( group,"img/logo2.png",100,50 )
		lemonGroup[#lemonGroup+1]=lemon
		lemon.x,lemon.y = 60,230	
		lemon:addEventListener( "touch",dragAdd)
		lemon:toFront( )

	local function dragHappen( event )
		-- body
		if (pearlGroup[#pearlGroup].x ~=47.5 or pearlGroup[#pearlGroup].y~=82.5) then
			local pearl =display.newImageRect(group,"img/pearl.png",15,15 )
			pearlGroup[#pearlGroup+1] = pearl
			last1=last1+1
			pearl.x,pearl.y=47.5,82.5
			pearl:addEventListener( "touch", dragAdd )
			--pearl:toBack( )
			--image:toBack( )
		end
		if (strawberryGroup[#strawberryGroup].x ~=50 or strawberryGroup[#strawberryGroup].y ~=150) then
			local strawberry = display.newImageRect( group,"img/straw.png",20,20 )
			strawberryGroup[#strawberryGroup+1]=strawberry
			last2 = last2+1
			strawberry.x,strawberry.y=50,150
			strawberry:addEventListener( "touch", dragAdd )	
			--strawberry:toBack( )	
			--image:toBack( )
		end
		if (lemonGroup[#lemonGroup].x ~=48 or lemonGroup[#lemonGroup].y ~= 230) then
			local lemon = display.newImageRect( group,"img/logo2.png",100,50 )
			lemonGroup[#lemonGroup+1]=lemon
			lemon.x,lemon.y = 60,230	
			lemon:addEventListener( "touch",dragAdd)

		end
	end 

	Runtime:addEventListener( "enterFrame",dragHappen)
	--]]
	

	local bottom = display.newImageRect( group,"img/bottom.jpg",320,70 )
	bottom.x,bottom.y = 160,445

	group:insert(bottom)
	

	--save drink
	local function takePicture( ... )
		-- body
		

		pictureGroup=display.newGroup()
		pictureGroup:insert(image)

		for i= #pearlGroup-1,n1,-1  do
		
			pictureGroup:insert( pearlGroup[i] )
		end
		for i= #strawberryGroup-1 ,n2,-1 do
			pictureGroup:insert( strawberryGroup[i] )
		end

		pictureGroup:insert( imageFront )
		
		for i= #lemonGroup-1,n3,-1 do
			pictureGroup:insert( lemonGroup[i] )
		end



		pictureGroup:toBack( )
		


		--local finalPicture = display.capture( pictureGroup , {saveToPhotoLibrary = true,isFullResolution = true} )
		--finalPicture.x,finalPicture.y = 160,240
		
		display.save( pictureGroup,"img/teaFinal.png", system.DocumentsDirectory )
		
		--display save img
		--local teaFinal = display.newImageRect( "teaFinal.png" , system.DocumentsDirectory,320,480 )
		--teaFinal.x,teaFinal.y= 160,240
		

		--local teaFinal = display.captureScreen( false)

		--cancel display img
		--[[local function cancel(  )
			--pictureGroup:removeSelf( )


			--finalPicture:removeSelf( )
			--finalPicture = nil
			teaFinal:removeSelf( )
		end
		timer.performWithDelay( 3000,cancel, 1 )
		--]]	
	end

	--take picture button
	--[[local takePictureBtn = widget.newButton
	{
		defaultFile = "save.png",
		left = 220,
		top=  220,
		width = 100,
		height = 100,
		--sound  onPress = onBtnPress,
		onRelease = takePicture
	}
	group:insert(takePictureBtn)
	--]]

	--finish
	local function finishRelease(  )
		-- body
		takePicture()
		storyboard.gotoScene( "finish",{time = storyboard.parameters.sceneChangeTime,effect="fade"} )
		
		if (pictureGroup ~= nil) then
			pictureGroup:removeSelf( )
		end
	end

	local finish = widget.newButton{
		defaultFile = "img/finish.png",
		left = 240,
		top=  335,
		width = 60,
		height = 60,
		--sound  onPress = onBtnPress,
		onRelease = finishRelease
	}
	--finish.rotation=-10

	group:insert(finish)

	local function resetAdd( ... )
		-- body


		for i= #pearlGroup,n1,-1  do
			if (pearlGroup[i]~=nil) then
				pearlGroup[i]:removeSelf( )
			end
			
		end
		for i= #strawberryGroup ,n2,-1 do
			if (strawberryGroup[i]~=nil) then
				strawberryGroup[i]:removeSelf(  )
			end
				
		end

		for i= #lemonGroup,n3,-1 do
			if (lemonGroup[i]~=nil) then
				lemonGroup[i]:removeSelf( )
			end
			
		end

		n1 = #pearlGroup+1
		n2 = #strawberryGroup+1
		n3 = #lemonGroup +1
	end

	local reset = widget.newButton
	{
		defaultFile = "img/reset.png",
		left = 10,
		top = 350,
		width = 100,
		height =50,
		onRelease = resetAdd

	}
	group:insert(reset)
-------------------------------------------------------------------------------------------------------------------------
	

	local text = display.newText( "0" ,50,20,system.nativeFont,50)
	text:setFillColor( 0 )

	group:insert(text)



	local function setAccount( value )
		-- body
		if (value<0) then
			value = value*-1
		end

		value = value * 150

		if (value<40) then
			control = false
		end

		--[[if (control==true and value<80) then
			return 
		end--]]

		if (value>100) then
			value = 100
		end

		--account:setValue( value )

		if (value>80) then
			if (control == false) then
				n=n+1
				control = true
			end

			

		end
	end

	--move cup when shake
	local function onAccelerate( event )
    	

		setAccount(event.yInstant)
		print( event.yInstant )
	end

	

	--change display energy and change scene
  	local function listen( event )
		-- body
		text.text = n


		if ( n>10) then
			
		
			
			--old change scene
			--[[Runtime:removeEventListener("enterFrame" ,setFrame)
			Runtime:removeEventListener("accelerometer" , onAccelerate)
			--print( "ok" )
			local msg = display.newText( "OK!~",180,370,system.nativeFont,50 )
			msg:setFillColor( 0 )
			group:insert(msg)

			timer.performWithDelay( 800, function()  storyboard.gotoScene( "addIngredient" ,{time = storyboard.parameters.sceneChangTime-200 ,effect = "fade"}) end, 1)
			timer.cancel( timerID)--]]

			
    		
    			--135, 97,165,280,190,280,216,97
    			local imageShape1 = {-46, 97-210,164-180,70,-15,70,-45,97-210}
    			local imageShape2 = {-15,71,10,71,10,70,-15,70}
    			local imageShape3 = {10,70,11,70,37,97-210,36,97-210}
    			--15,15
    			local pearlShape = {-5,5,-5,-5,5,-5,5,5}
    			--50,50
    			local strawberryShape ={-5,5,-5,-5,5,-5,5,5}--0,-16,18,20,-20,20,-5,-16

    			physics.addBody( image, "static",
    				{shape = imageShape1, friction=0.5, bounce=0.1 }, 
    				{shape = imageShape2, friction=0.5, bounce=0.1 },
    				{shape = imageShape3, friction=0.5, bounce=0.1 }
    			)
    			
   			 	--excess addbody

    			for i= n1,last1,1  do
    			
    				physics.addBody( pearlGroup[i],  {shape=pearlShape ,density=0.3, friction=0.1, bounce=0.1  } )
					pearlGroup[i]:toBack( )
					image:toBack( )
				end

				

				for i= last2 ,n2,-1 do
					physics.addBody( strawberryGroup[i],  {shape = strawberryShape,density=0.5, friction=0.1, bounce=0.1 , } )
					strawberryGroup[i]:toBack( )	
					image:toBack( )
				end
    			
    		
    			n = 0 
		end



	end

	timerID=timer.performWithDelay( 50, listen,0 )

	
	Runtime:addEventListener("accelerometer", onAccelerate)
	
	--Runtime:addEventListener("accelerometer",listen)



end


-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	local group = self.view
	
	local options =
    {
        effect = "fade",
        time = storyboard.parameters.sceneChangeTime
    }

    storyboard.showOverlay( "addIngredientOverlay", options )


    --set teaGroup

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

-- the following event is dispatched once the overlay is in place
function scene:overlayBegan( event )
    print( "Showing overlay: " .. event.sceneName )
end
scene:addEventListener( "overlayBegan" )

-- the following event is dispatched once overlay is removed
function scene:overlayEnded( event )
    print( "Overlay removed: " .. event.sceneName )
end
scene:addEventListener( "overlayEnded" )

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