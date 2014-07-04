
local storyboard = require( "storyboard")
local physics = require( "physics")
local widget= require( "widget")
local scene = storyboard.newScene( )
local n = 0  --teanum
local bottom = nil
local startTime=0
local timeValue =20
local timebar =nil
local timerID = nil
local cup = nil
local teaCount = 0
local iceCount = 0
local sugarCount = 0

display.setDefault( "fillColor", 0, 0, 0 )

physics.start( )

function scene:createScene( event )
	-- body

	local group = self.view

	--time text and bar
	timebar = display.newLine( group, 12, 380-10*timeValue , 12, 380 )
	timebar:setStrokeColor(0,0.3,1)
	timebar.strokeWidth=5

	local function timeChange( event )
		-- body
		timeValue = 20 - (system.getTimer()-startTime)/500
		if (timeValue>0) then
			if (timebar ~= nil) then
				timebar:removeSelf( )
			end
			
			timebar = display.newLine( group, 12, 380-10*timeValue , 12, 380 )
			timebar:setStrokeColor(0,0.3,1)
			timebar.strokeWidth=5
		else
			


			local img = display.newText( "Time's up!!!",160,240,"Arial",60 )
			img.rotation = -10	
			img.y= 200
			group:insert( img )

			Runtime:removeEventListener("enterFrame",timeChange)
			timer.cancel( timerID )
			

			toScene = false
			local function goto()

				 physics.removeBody( cup )

				storyboard.gotoScene( "addIngredient",{time = storyboard.parameters.sceneChangTime-200,effect = "fade" })
				
			end
			timer.performWithDelay( 3000,goto ,1) 

		end
			
		

		
	end

	--Runtime:addEventListener("enterFrame",timeChange)
	

	--three bar and text
	--[[
	local teabar = widget.newSlider
	{
		left = 45,
		top = 60,
		width = 200,
		value = 0,
		--listener = teabarListener,

	}
	--teabar.alpha=1

	group:insert( teabar)

	local icebar = widget.newSlider
	{
		left = 45,
		top = 0,
		width = 180,
		value = 0,
		--listener = icebarListener, 
	}
	--icebar.alpha=1

	group:insert( icebar )
	
	local sugarbar = widget.newSlider
	{
		left = 45,
		top = 30,
		width = 120,
		value = 0,
		--listener = sugarbarListener,
	}
	--sugarbar.alpha=0.4

	group:insert(sugarbar)
	
	local iceText = display.newText( "冰塊" ,25,20,"Arial",18)
	iceText.alpha=0.7
	group:insert(iceText)

	local sugarText = display.newText( "甜度",25,50,"Arial",18 )
	sugarText.alpha=0.7
	group:insert(sugarText)

	local teaText = display.newText( "tea",25,80,"Arial",20 ) 
	teaText.alpha=0.7
	group:insert(teaText)
	--]]
	


	local function dragCup( event )
		-- body
		local phase = event.phase
		local t=event.target 

		if (phase == "began") then
			display.getCurrentStage( ):setFocus( t )
			t.isFocus = true
		elseif(phase == "moved") then
			t.x = event.x
		elseif(phase=="ended" or phase=="cancel")then	 
			display.getCurrentStage( ):setFocus( nil )
			t.isFocus = false
		end

		
	end 



	-- 3 boss
	local snowMan = display.newImageRect( group,"img/snowm.png" ,170,170 )
	snowMan.x,snowMan.y=cupX-50,cupY

	local littleG= display.newImageRect( group,"img/littleg.png", 200,200)
	littleG.x,littleG.y= cupX+50,cupY

	local teaCup = display.newImageRect( group,"img/teacup.png" ,170,170)
	teaCup.x,teaCup.y=  cupX,cupY-50
	--teaCup.xScale,teaCup.yScale=0.5,0.5

	cup = display.newRect( 0, 0, 50, 80 )
	cup.x,cup.y=160,320
	cup:setFillColor( 1 )
	cup.strokeWidth = 2	
	cup:setStrokeColor( 0 )

	cup:addEventListener( "touch", dragCup )

	--add collision
	local function cupCollision( self,event )
		-- body

		

		if (event.phase =="began") then
			--collision y range
			if (event.other.y<275) then

				if (event.other.name == "tea") then
					--teabar:setValue( teabar.value+5 )
					teaCatch = teaCatch +1
				elseif (event.other.name == "ice") then
					--icebar:setValue( icebar.value+5 )	
					iceCatch = iceCatch +1
				elseif	(event.other.name == "sugar") then
					--sugarbar:setValue( sugarbar.value+5 )
					sugarCatch = sugarCatch+1
				end
				event.other:removeSelf( )
			end

		end
	end

	cup.collision = cupCollision
	cup:addEventListener( "collision", cup )



	group:insert(cup)
	physics.addBody( cup,"kinematic", { friction=0.7 } )

	
	local function newTea(  )
		-- body
		--change every single
		n=n+1
		math.randomseed(os.time())

		if (n%3 ==0  and  teaCount < teaN ) then

			local tea = display.newImageRect(group, "img/brick.png" ,30,50)
			tea.x,tea.y=teaCup.x+75,teaCup.y-30 
			--tea.xScale,tea.yScale = 0.3,0.3
			physics.addBody( tea, "dynamic", {density=3, friction=0.01, bounce=1 } )
			tea.name="tea"
			
			tea.angularVelocity = 1
			tea:applyForce(math.random(50,800),math.random(-800,100),tea.x,tea.y)
			--]]
			teaCount = teaCount + 1 
		elseif(n%3 == 1 and iceCount < iceN )then
			local ice = display.newImageRect(group, "img/ice.png" ,50,50 )
			ice.x,ice.y=snowMan.x+75,snowMan.y-30
			physics.addBody( ice, "dynamic", {density=3, friction=0.01, bounce=1 } )
			ice.name ="ice"

			
			ice:applyForce( math.random(300,1800),math.random(-700,-50), ice.x, ice.y )
		--]]
			iceCount = iceCount + 1

		elseif(n%3 == 2 and sugarCount < sugarN)then
			local sugar = display.newImageRect(group, "img/sugar.png"  ,50,50)
			sugar.x,sugar.y=littleG.x-40,littleG.y+30	
			physics.addBody( sugar, "dynamic", {density=2, friction=0.01, bounce=1  } )
			sugar.name="sugar"

			--sugar.angularVelocity = 1
			sugar:applyForce( math.random(-900,-50),math.random(-900,100),sugar.x,sugar.y )
		--]]
			sugarCount = sugarCount+1 	
		end

		bottom :toFront( )
		
		
	end



	local function launch(  )
		-- body

		timerID =  timer.performWithDelay( 300, newTea ,0 )

		
	end


	local function moveTea(  )
		-- body
		--change posi. after tescup out of sceen
		local function changePo(  )
			-- body
			teaCup.alpha = 0
			teaCup.x,teaCup.y= - 40,10 -- math.random( -50,350)
			littleG.alpha=0
			littleG.x,littleG.y= 360,10
			snowMan.alpha=0
			snowMan.x,snowMan.y= -40,140
		end


		--teacup vanish 
		local function vanish( ... )
			-- body
			--transition.to( teaCup, {time=50,alpha=0} )
			--teaCup.alpha=0
			timer.performWithDelay( 20,changePo , 0 )
		end

		--3 path
		local function third( ... )
			-- body
			vanish()
			--transition.to( teaCup,{time = 1400,x=-100,y=-50,transition = easing.outExpo,onComplete=vanish}  )
		end

		local function next(  )
			-- body
			vanish()
			--transition.to( teaCup,{time = 1400,x=-20,y=10,onComplete=third}  )
		end

		launch()

		transition.to( teaCup,{time = 800,x=-20,y=10 ,onComplete=next}  )

		transition.to( snowMan, {time=800,x=-20,y=240} )	

		transition.to( littleG, {time=800,x=360,y=10} )

		startTime = system.getTimer() 

		Runtime:addEventListener("enterFrame",timeChange)
	end



	local function toStart( ... )
		-- body
	
		if (toScene == true) then
	 		timer.performWithDelay( 1000, moveTea , 1 )
	 		Runtime:removeEventListener("enterFrame",toStart)
	 	end
	end
	
	Runtime:addEventListener("enterFrame",toStart)

	bottom = display.newImageRect( group,"img/bottom.jpg",320,70 )
	bottom.x,bottom.y = 160,445

	group:insert(bottom)

	--around line
	--[[ocal lineLeft = display.newLine( group, -20,0,0,30, 0, 480 )
	physics.addBody( lineLeft,"static ", { friction=0, bounce=1 } )
	local lineRight = display.newLine( group, 340,0,320, 30, 320, 480 )
	physics.addBody( lineRight,"static ", { friction=0, bounce=1 } )
	--]]

end

function scene:enterScene( event )
	-- body
	local group = self.view
	storyboard.showOverlay( "catchTeaOverlay",{time = storyboard.parameters.sceneChangTime, effect="fade"} )
end


function scene:exitScene( event)
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

scene:addEventListener("createScene",scene )
scene:addEventListener("enterScene",scene)
scene:addEventListener("exitScene",scene)
scene:addEventListener("destoryScene",scene)
return scene