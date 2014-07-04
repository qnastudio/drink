


local storyboard = require( "storyboard")
local widget = require("widget" )
local scene = storyboard.newScene( )
local teaname = {"紅茶","綠茶","奶茶","珍珠奶茶","翡翠檸檬","橘子汁","柳橙汁","布丁奶茶"}
local item_amount = 8
local circleH = display.contentHeight-120
local textH=display.contentHeight-85
local dx=30
local distance = 65
local startTeaPo =30
local teaGroup={}
local i = 1 
local startPo=0
local presPo =0
local page=1 
local numOfPage=3
local cupGroup={}
local arrowLeftBtn,arrowRightBtn=nil


function scene:createScene( event )
	-- body

	local group = self.view

	--background
	local bg =display.newRect( group,0,0,display.viewableContentWidth,display.viewableContentHeight )
	bg.anchorX,bg.anchorY=0,0
	--bg:setFillColor( 0.2,0.5,1 )
	group:insert(bg)

	local cup = display.newImageRect( group, "img/tea1.png" ,cupW,cupH)
	cup.anchorX,cup.anchorY =0.5,0.5
	cup.x,cup.y = cupX,cupY
	cupGroup[1]=cup 

	local cup2 = display.newImageRect( group,"img/tea2.png",cupW,cupH )
	cup2.x,cup2.y=cupX+320,cupY
	cupGroup[2]=cup2

	local cup3 = display.newImageRect( group,"img/tea3.png",cupW,cupH) 
	cup3.x,cup3.y=cup2.x+320,cupY
	cupGroup[3]=cup3

	local function adjustButtons(  )
		-- body
		arrowLeftBtn.alpha = (page <= 1 and 0 or 1)
		arrowRightBtn.alpha = (page >= numOfPage and 0 or 1)
		if ((cup.x-cupX)%160 ~=0 ) then
			for k=1,3 do
            	transition.to( cupGroup[k], {time = 550,transition=easing.outExpo,delta = false,x= cupX+(k-page)*320 } )
            	
            end
		end
	end
	
	


	arrowLeftBtn = widget.newButton {
		defaultFile = "img/arrow.png",
     -- overFile = "arrow-left_over.png",
		width = 80,
		height = 50,
		top = 180,
		onRelease = function()
         if page > 1 then
         	page = page-1
            for k=1,3 do
            	transition.to( cupGroup[k], {time = 500,transition=easing.outExpo,delta=true,x=320} )
            end
         end
         adjustButtons()
      end
	}
	arrowLeftBtn.rotation = 180
	arrowLeftBtn.alpha = (page <= 1 and 0 or 1)
	group:insert(arrowLeftBtn)

	arrowRightBtn = widget.newButton {
      defaultFile = "img/arrow.png",
      --overFile = "arrow-right_over.png",
		width = 80,
		height = 50,
		left = 240,
		top = 180,
		onRelease = function()
         if page < numOfPage then
         	page = page +1
            for k=1,3 do
            	transition.to( cupGroup[k], {time = 500,transition=easing.outExpo,delta=true,x=-320} )
            	
            end
         end
         adjustButtons()
      end
	}

	--arrowRightBtn.alpha = (page >= numOfPage and 0 or 1)
	group:insert(arrowRightBtn)

	--create tea item function
	--[[
	local function newCircle(  )
	-- body
	 	local circle = display.newCircle( dx , circleH, 15 )
		circle:setFillColor( 0,0,0,0.5 )
		

		
		local  text = display.newText( teaname[i], dx , textH,"Arial",12 )
		text:setFillColor( 0 )


		i=i+1
		
		dx = dx+distance
		--circle:addEventListener( "touch", drag )

		return circle ,text
	end--]]

	
	--drag tea item to move 
	--[[
	local function drag( event )
		-- body
		local phase = event.phase
		local t = event.target

		if (event.phase=="began") then
			display.getCurrentStage():setFocus( event.target )
			event.target.isFocus=true
			t.text.alpha=0
			presPo = t.x 

		end	
		

		
		
		if event.phase == "moved" then
			 event.target.x, event.target.y = event.x, event.y
			 t.text.x ,t.text.y = event.x, event.y+35
			
		elseif event.phase == "ended" or event.phase =="cancel" then
			display.getCurrentStage():setFocus( nil )
			event.target.isFocus = false
			t.text.alpha=1
			
			if (t.x < cupX + cupW/3 and t.y < cupY + cupH/2 and t.x > cupX -cupW/3 and t.y > cupY - cupH/2 ) then
				t.text.alpha = 0
				t.alpha = 0
				if (page == 1) then
					--local imageFront = display.newImageRect(group, "addIngredientcup2.png", 350, 350)
					--imageFront.x ,imageFront.y = cupX,cupY
					--imageFront
					--imageFront.alpha = 0.5
					cup = display.newImageRect( group, "ccup.png", cupW-20,cupH+20 )
					cup.x,cup.y = cupX,cupY
				elseif(page== 2) then
					cup2 = display.newImageRect(group,"highcup2.png",cupW,cupH )
					cup2.x,cup2.y= cupX,cupY
				elseif(page==3) then
				 	cup3 = display.newImageRect( group,"beercup2.png",cupW,cupH) 
					cup3.x,cup3.y=cup2.x+320,cupY
				end
				
				
				timer.performWithDelay( 600,function () storyboard.gotoScene( "catch" , {time = storyboard.parameters.sceneChangTime-200, effect = "fade"} )end,1  )

				--when exit then recover
				function back(  )
					-- body
					cup = display.newImageRect( group,"cup.jpg" , cupW,cupH)
					cup.anchorX,cup.anchorY =0.5,0.5
					cup.x,cup.y = cupX,cupY

					for i=1,item_amount do
						--transition.to( teaGroup[i], {time=800,transition=easing.outExpo,x=startTeaPo+distance*(i-1)} )
						--transition.to( teaGroup[i].text,  {time=800,transition=easing.outExpo,x=startTeaPo+distance*(i-1)})
						

						t.y = circleH
						t.text.y = textH
						t.x =  presPo
						t.text.x = presPo
						t.text.alpha=1
					end
 
				end

				timer.performWithDelay( 1000, back,1 )
				--]]
			--back tea item
			--[[
			else
				t.x =  presPo
				t.text.x = presPo
				t.y = circleH
				t.text.y = textH
		
			end
		end	
	

				
		return true
	end

	--create new tea item
	for k=1, item_amount do
		local circle ,text = newCircle()
		
		teaGroup[k] =circle
		teaGroup[k].text =text
		teaGroup[k]:addEventListener( "touch", drag )
		group:insert( circle )
		group:insert(text)	
	end
	--]]
	--when select moving item
	--[[
	local function dragback( event )
		-- body
		local phase =event.phase
		local t = event.target

		if (phase =="began") then
			display.getCurrentStage( ):setFocus( t )
			t.isfocus =true 
			
			presPo = event.x
			startPo = event.x
			
		
		elseif(phase =="moved")then
			local delta = event.x - presPo
			presPo = event.x
			
			--difficult to move on boundary
			if (teaGroup[1].x<=startTeaPo and event.x-startPo<=0) then
				delta=delta/2
			elseif(teaGroup[item_amount].x<startTeaPo+distance*4 and event.x - startPo>=0)then
				delta=delta/2

			end
			
			---move item
			for k=1,item_amount do
				teaGroup[k].x = teaGroup[k].x+delta
				teaGroup[k].text.x = teaGroup[k].text.x + delta
			end
		elseif(phase == "ended" or "cancel")then
			display.getCurrentStage():setFocus( nil )
			event.target.isFocus = false
			
			--back item to viewable center 
			if (teaGroup[1].x>startTeaPo) then
				for i=1,item_amount do
					transition.to( teaGroup[i], {time=800,transition=easing.outExpo,x=startTeaPo+distance*(i-1)} )
					transition.to( teaGroup[i].text,  {time=800,transition=easing.outExpo,x=startTeaPo+distance*(i-1)})
				end
			end
			if (teaGroup[item_amount].x<(startTeaPo+distance*4) )then
				for i=1,item_amount do
					transition.to(teaGroup[i], {time = 800,transition=easing.outExpo,x=startTeaPo+distance*(4-item_amount+i)} )
					transition.to( teaGroup[i].text, {time = 800,transition=easing.outExpo,x=startTeaPo+distance*(4-item_amount+i)})
				end
				
			end


		end


	end


	bg:addEventListener( "touch", dragback )
	--]] 
	local function chooseRelease(  )
		-- body
		storyboard.gotoScene( "catch" , {time = storyboard.parameters.sceneChangTime-200, effect = "fade"} )
	end

	local choose = widget.newButton
	{
		defaultFile = "img/select.jpg",
		left = 230,
		top=  335,
		width = 80,
		height = 50,
		--sound  onPress = onBtnPress,
		onRelease = chooseRelease
	}
	group:insert(choose)
	

	local bottom = display.newImageRect( group,"img/bottom.jpg",320,70 )
	bottom.x,bottom.y = 160,445

	group:insert(bottom)
end



function scene:enterScene( event )
	-- body
	local group = self.view

	local options = {
		effect = "fade",
		time = storyboard.parameters.sceneChangTime-200
	}

	storyboard.showOverlay( "chooseTeaOverlay" , options  )
end

function scene:exitScene( event )
	-- body

	local group =self.view
	
	--[[cup:removeSelf( )
	cup = nil

	for _,item in pairs(teaGroup) do
		item:removeSelf( )
			
	end

--]]
	
	
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

scene:addEventListener("exitScene",scene)

scene:addEventListener( "destoryScene", scene )
return scene