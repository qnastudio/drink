----------------------------------------------------------------------------------
--
-- chooseCup.lua
--
----------------------------------------------------------------------------------

local storyboard = require( "storyboard" )
local widget = require( "widget" )
--local physics = require("physics")
local scene = storyboard.newScene()
local onBotton =nil
local temp1,temp2,temp3
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
	--display.setDefault( "background",0 )
----
	local d1 = display.newImageRect(group, "d1.jpg",60,80 )
	d1.x,d1.y=95,240
	d1:toBack( )	

	local d4 = display.newImageRect( group,"d2.jpg",60,80 )
	d4.x,d4.y = 95,160

	local d5 = display.newImageRect( group,"d3.jpg",60,80 )
	d5.x,d5.y= 95,320
---
	local d2 = display.newImageRect(group,"d2.jpg",60,80 ) 
	d2.x,d2.y = 155,240

	local d6 = display.newImageRect( group,"d3.jpg",60,80 )
	d6.x,d6.y= 155,160

	local d7 = display.newImageRect( group,"d1.jpg",60,80 )
	d7.x,d7.y= 155,320
---
	local d3 = display.newImageRect( group,"d3.jpg",60,80 )
	d3.x,d3.y= 215,240

	local d8 = display.newImageRect( group,"d1.jpg",60,80 )
	d8.x,d8.y= 215,160

	local d9 = display.newImageRect( group,"d2.jpg",60,80 )
	d9.x,d9.y= 215,320





	local bar = display.newImageRect(group,"bar.png",240,380 )
	bar.x,bar.y = 160,250
	--bar:toBack( )

	local function run(  )
		-- body

		-- 19.5
		--19.7
		--19.258
		onBotton:setEnabled( false )
		
		math.randomseed( os.time() )

		local speed = math.random(1,1000)%3
		local speed2 = nil
		local speed3 = nil
		print( speed )
		
		
		temp = speed
		

		if ( speed== 0)then
			speed =47.63
			speed2 =48.5
			speed3 =49.07
		elseif(speed== 1)then
			speed = 46.57
			speed2=47.68
			speed3 =  48.4
		elseif( speed== 2)then 	
			speed =  47.1
			speed2 =  48.08
			speed3 =  48.73
		end		
		

		local  function runMgr( event )
			-- body

			speed = speed - 0.3
			if (speed <= 0) then
				Runtime:removeEventListener( "enterFrame", runMgr )
			else
				if (d1.y>=360) then

					d1.y = 120 + d1.y -360 
					d1.y= d1.y+speed
				else
					d1.y= d1.y+speed


				end
				
				if (d4.y>=360) then
					
					d4.y = 120 +d4.y-360
					d4.y= d4.y+speed
				else	
					
					d4.y= d4.y+speed	
				end

				if (d5.y>=360) then

					d5.y = 120 +d5.y-360
					d5.y= d5.y+speed
				else	
					d5.y= d5.y+speed
				end
			end		

		end 	
		local  function runMgr2( event )
			-- body

			speed2 = speed2 - 0.24
			if (speed2 <= 0) then
				Runtime:removeEventListener( "enterFrame", runMgr2 )
			else
				if (d2.y>=360) then
					d2.y = 120 + d2.y -360
					d2.y= d2.y+speed2

				else
					d2.y= d2.y+speed2


				end
				
				if (d6.y>=360) then
					
					d6.y = 120 +d6.y-360
					d6.y= d6.y+speed2
				else	
					
					d6.y= d6.y+speed2	
				end

				if (d7.y>=360) then

					d7.y = 120 +d7.y-360
					d7.y= d7.y+speed2
				else	
					d7.y= d7.y+speed2
				end
			end		

		end 	
		local  function runMgr3( event )
			-- body
			local function showOverlay( ... )
				-- body
				storyboard.showOverlay( "barOverlay", {time = 300,effect = "fade"})
			end

			speed3 = speed3 - 0.2
			if (speed3 <= 0) then
				Runtime:removeEventListener( "enterFrame", runMgr3 )
				timer.performWithDelay( 800,showOverlay,1 )
			else
				if (d3.y>=360) then
					d3.y = 120 + d3.y -360
					d3.y= d3.y+speed3
				else
					d3.y= d3.y+speed3


				end
				
				if (d8.y>=360) then
					
					d8.y = 120 +d8.y-360
					d8.y= d8.y+speed3
				else	
					
					d8.y= d8.y+speed3
				end

				if (d9.y>=360) then

					d9.y = 120 +d9.y-360
					d9.y= d9.y+speed3
				else	
					d9.y= d9.y+speed3
				end
			end		

		end 	
		Runtime:addEventListener( "enterFrame", runMgr )
		Runtime:addEventListener("enterFrame",runMgr2)
		Runtime:addEventListener("enterFrame",runMgr3)
	end

	onBotton = widget.newButton
	{
		defaultFile = "pearl.png",
		x = 263,
		y = 180,
		width = 20,
		height = 20,
		onRelease = run

	}
	group:insert( onBotton )
	onBotton:toBack( )

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

-- the following event is dispatched once the overlay is in place

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