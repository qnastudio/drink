

local storyboard = require( "storyboard")
local scene = storyboard.newScene(  )
local widget = require("widget" )
local n = 0    --energy
local control=false   --whether shaking arrive enough ammount
local to0 = 1 ---n back to zero

function scene:createScene( event )
	-- body
	local group = self.view

	local text = display.newText( "0" ,50,20,system.nativeFont,50)
	text:setFillColor( 0 )

	group:insert(text)

	-- display the acceleration of shake
	local account  = widget.newSlider
	{
		left = 20,
		top = 100,
		orientation = "vertical",
		height = 200,
		value =0,

	}
	group:insert( account )

	local cup = display.newImageRect( group,"cup.png" , cupW, cupH )
	cup.x,cup.y = cupX+20,cupY


	local function setAccount( value )
		-- body
		if (value<0) then
			value = value*-1
		end

		value = value * 150

		if (value<20) then
			return
		end

		--[[if (control==true and value<80) then
			return 
		end--]]

		if (value>100) then
			value = 100
		end

		account:setValue( value )

		if (value>80) then
			control=true
			if (to0==2) then
				n=0
				to0 = 1
			end

		end
	end

	--move cup when shake
	local function onAccelerate( event )
    	
		setAccount(event.yInstant)

    	cup.y = cupY+(-50)*event.yInstant

    	if (cup.y<cupY-50) then
    		cup.y=cupY-50
    	elseif(cup.y>cupY+50) then
    		cup.y=cupY+50
    	end


	end


	local function setFrame( event )
		-- body
		--display text when shake not enough
		if (account.value<80 ) then
			if (control==true) then
				local t = display.newText( "shake more~",180,370,"Arial",30 )
				t:setFillColor( 0 )
				
				local function del(  )
					-- body
					t:removeSelf()	
				end
				transition.to( t, {time=1500,alpha=0.5} )
				timer.performWithDelay( 1500, del, 1 )
				
				--transition.to( t, {time= 200,alpha=0.5},function (  )t:removeSelf() end )
				to0 = 2
			end

			
			control=false
		end

		--accumulate the shake energy
		if (account.value>80) then
			n=n+1.5
			if (n>100) then
				n=100
			end
			
		end
		
		--minus energy when no shake
		if (account.value>0) then
			account:setValue( account.value-1.5 )
		end

	end

	--change display energy and change scene
  	local function listen( )
		-- body
		text.text = n

		if (n==100) then
			
			Runtime:removeEventListener("enterFrame" ,setFrame)
			Runtime:removeEventListener("accelerometer" , onAccelerate)
			--print( "ok" )
			local msg = display.newText( "OK!~",180,370,system.nativeFont,50 )
			msg:setFillColor( 0 )
			group:insert(msg)

			timer.performWithDelay( 800, function()  storyboard.gotoScene( "addIngredient" ,{time = storyboard.parameters.sceneChangTime-200 ,effect = "fade"}) end, 1)
			timer.cancel( timerID)
		end

	end

	timerID=timer.performWithDelay( 50, listen,0 )

	
	Runtime:addEventListener("accelerometer", onAccelerate)
	Runtime:addEventListener("enterFrame",setFrame)

	
	local bottom = display.newImageRect( group,"bottom.jpg",320,70 )
	bottom.x,bottom.y = 160,445

	group:insert(bottom)
	
end

function scene:enterScene( event )
	-- body
	local group = self.view

	storyboard.showOverlay( "shakingTimeOverlay" ,{time =storyboard.parameters.SceneChangTime,effect = "fade"})
end

function scene:exitSCene( event )
	-- body

end

function scene:destorySCene( event )
	-- body
	local group = self.view

   	for i = group.numChildren, 1, -1 do
    	if group[i] ~= nil then
       	 	 group[i]:removeSelf()
        	 group[i] = nil
     	end
   	end
end

scene:addEventListener( "createScene", scene)
scene:addEventListener("enterScene",scene)
scene:addEventListener( "exitSCene", scene )
scene:addEventListener( "destoryScene", scene )

return scene