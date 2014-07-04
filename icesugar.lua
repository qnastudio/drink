local storyboard= require( "storyboard")
local widget = require( "widget")
local scene = storyboard.newScene( )
local sugarValue = 100
local iceValue = 50
local x1,x2,x3,x4,x5 = 0,30,50,80,100--five point
local r1,r2,r3,r4 = 15, 40, 65,90 -- point range 


function scene:createScene( event )
	-- body
	display.setDefault( "fillColor", 0 )

	local group=self.view
	local cup = display.newImageRect(group,"ccup.png",cupW,cupH )
	cup.x,cup.y=cupX,cupY


	local function iceListener( event )
		-- body
		iceValue=event.value

	end
	local function sugarListener( event )
		-- body
		--print( event.value )
		cup.alpha = event.value/300+0.67
		sugarValue=event.value

	end
	

	local ice = widget.newSlider
	{
		left = 70,
		top = 305,
		width = 200,
		value = iceValue,
		listener = iceListener, 
	}

	group:insert( ice )
	
	local sugar = widget.newSlider
	{
		left = 70,
		top = 345,
		width = 200,
		value = sugarValue,
		listener = sugarListener,
	}

	group:insert(sugar)
	
	local iceText = display.newText( "冰塊" ,42,328,"Arial",10)

	group:insert(iceText)

	local sugarText = display.newText( "甜度",42,368,"Arial",10 )


	group:insert(sugarText)

	--set five point
	local function sugarSet( event )
		-- body
			if (sugarValue<r1) then
				sugar:setValue( x1 )
			elseif(r1<=sugarValue and sugarValue<r2)then
				sugar:setValue(x2)		
			elseif(r2<=sugarValue and sugarValue<r3)then
				sugar:setValue( x3 )	
			elseif(r3<=sugarValue and sugarValue <r4)then
				sugar:setValue( x4 )
			elseif(r4<=sugarValue)then
				sugar:setValue( x5 )
			end

		
		
	end

	Runtime:addEventListener( "enterFrame", sugarSet )

	--set five point
	local function iceSet( event )
		-- body
		if (iceValue<r1) then
				ice:setValue( x1 )
			elseif(r1<=iceValue and iceValue<r2)then
				ice:setValue(x2)		
			elseif(r2<=iceValue and iceValue<r3)then
				ice:setValue( x3 )	
			elseif(r3<=iceValue and iceValue <r4)then
				ice:setValue( x4 )
			elseif(r4<=iceValue)then
				ice:setValue( x5 )
		end
	end

	Runtime:addEventListener( "enterFrame", iceSet )

	local function nextFunction( )
		-- body
		storyboard.gotoScene( "catch" ,{time = storyboard.parameters.sceneChangTime-200,effect = "fade"} )
		--Runtime:removeEventListener( "enterFrame", sugarSet )
		--Runtime:removeEventListener( "enterFrame", iceSet )
	end

	

	local next = widget.newButton
	{	
		id ="next" ,
		left = 230,
		top = 280,
		defaultFile = "buttonBlueSmall.png",
		overFile = "buttonBlueSmallOver.png",
		label = "next",
		fontSize = 20,
		labelColor = {default={0}},	
		emboss = true,
		onEvent = nextFunction
	}

	group:insert(next)	
	--]]
	local bottom = display.newImageRect( group,"bottom.jpg",320,70 )
	bottom.x,bottom.y = 160,445

	group:insert(bottom)
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