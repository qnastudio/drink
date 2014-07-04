local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

----------------------------------------------------------------------------------
-- 
--      NOTE:
--      
--      Code outside of listener functions (below) will only be executed once,
--      unless storyboard.removeScene() is called.
-- 
---------------------------------------------------------------------------------


-- local forward references should go here --
local movieclip = require("movieclip")
local hp = 3
local speed = 10
local soundFood = audio.loadSound( "touchObject.mp3" )
local soundBomb = audio.loadSound( "bomb.mp3" )
local eventChannel
local score
local scoreText
local background
local background2
local cat
local objectGroup = display.newGroup()
local offsetx
---------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

local setObject
setObject = function()
    objectGroup = display.newGroup()
    for i=1,5 do
            x = math.random(3)
            local obj
            if x==1 then
                    display.newImageRect( objectGroup, "tea.png", 50, 50)
                    objectGroup[i].label = 1
            elseif x==2 then
                    display.newImageRect( objectGroup, "milk.png", 50, 50)
                    objectGroup[i].label = 2
            else
                    display.newImageRect( objectGroup, "package.png", 50, 50)
                    objectGroup[i].label = 3
            end
    end
    for i=1,5 do
            objectGroup[i]:translate( 60*i - 20, 500 )
    end
    scoreText:toFront()
    timer.performWithDelay(1800, cleanObject)
    timer.performWithDelay(2000, setObject)
end

local cleanObject
cleanObject = function()
    print( "hello" )
    for i=1,objectGroup.numChildren do
            objectGroup[1]:removeSelf()
    end
end
---[[
local groupMgr = function ( event )
    local distance = math.sqrt( math.pow(self.x-cat.x,2) + math.pow(self.y+objectGroup.y-cat.y,2) )
    if distance < 40 then
        if self.label == 1 then
            score = score+1
            media.playEventSound( soundFood )
        elseif self.label == 2 then
            score = score+5
            media.playEventSound( soundFood )
        else
            score = math.max(score-10,0)
            media.playEventSound( soundBomb )
        end
        scoreText:setText(score)
        self:removeSelf()
    end
end

local frameMgr = function( event )
    --collision detect
    for i=1,5 do
            if objectGroup[i] ~= nil then
                    local distance = math.sqrt( math.pow(objectGroup[i].x-cat.x,2) + math.pow(objectGroup[i].y+objectGroup.y-cat.y,2) )
                    if distance < 40 then
                            if objectGroup[i].label == 1 then
                                    score = score+1
                                    audio.play( soundFood )
                            elseif objectGroup[i].label == 2 then
                                    score = score+5
                                    audio.play( soundFood )
                            else
                                    score = math.max(score-10,0)
                                    audio.play( soundBomb )
                            end
                            
                            scoreText:setText(score)
                            objectGroup[i]:removeSelf( )
                    end
            end
    end

    --object move
    objectGroup.y = objectGroup.y - speed

    if background.y > -240 then
    background.y = background.y - speed
    else
            background.y = 720
    end

    if background2.y > -240 then
    background2.y = background2.y - speed
    else
            background2.y = 720
    end
end

local catMove = function( event )
    if event.phase == "began" then
        offsetx = event.x - cat.x
    else
        if (event.x - offsetx > 0 and event.x - offsetx < 320) then
            cat.x = event.x - offsetx
        end
    end 
end

-- Called when the scene's view does not exist:
function scene:createScene( event )
        local group = self.view
        
        background = display.newImageRect( "background.jpg", 320, 500 )
        background:translate( 160, 240 )
        group:insert( background )

        background2 = display.newImageRect( "background.jpg", 320, 500 )
        background2:translate( 160, 720 )
        group:insert( background )
end


-- Called BEFORE scene has moved onscreen:
function scene:willEnterScene( event )
        local group = self.view

        -----------------------------------------------------------------------------

        --      This event requires build 2012.782 or later.

        -----------------------------------------------------------------------------

end


-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
    local group = self.view

    media.playSound( "backgroundMusicFast.mp3", true )    
    score = 0
    scoreText = display.newEmbossedText( score, 280, 40, native.systemFont, 30, { 1, 1, 1, 1 } )

    cat = movieclip.newAnim{"cat.png", "cat_left.png", "cat.png", "cat_right.png" }
    cat.width, cat.height = 50,50
    cat:translate( 160, 150 )
    cat:play()

    setObject()

    for i=1,hp do

    end

    Runtime:addEventListener( "enterFrame", frameMgr )
    background:addEventListener( "touch", catMove )
    background2:addEventListener( "touch", catMove )
    -----------------------------------------------------------------------------

    --      INSERT code here (e.g. start timers, load audio, start listeners, etc.)

    -----------------------------------------------------------------------------

end


-- Called when scene is about to move offscreen:
function scene:exitScene( event )
        local group = self.view

        -----------------------------------------------------------------------------

        --      INSERT code here (e.g. stop timers, remove listeners, unload sounds, etc.)

        -----------------------------------------------------------------------------

end


-- Called AFTER scene has finished moving offscreen:
function scene:didExitScene( event )
        local group = self.view

        -----------------------------------------------------------------------------

        --      This event requires build 2012.782 or later.

        -----------------------------------------------------------------------------

end


-- Called prior to the removal of scene's "view" (display group)
function scene:destroyScene( event )
        local group = self.view

        -----------------------------------------------------------------------------

        --      INSERT code here (e.g. remove listeners, widgets, save state, etc.)

        -----------------------------------------------------------------------------

end


-- Called if/when overlay scene is displayed via storyboard.showOverlay()
function scene:overlayBegan( event )
        local group = self.view
        local overlay_name = event.sceneName  -- name of the overlay scene

        -----------------------------------------------------------------------------

        --      This event requires build 2012.797 or later.

        -----------------------------------------------------------------------------

end


-- Called if/when overlay scene is hidden/removed via storyboard.hideOverlay()
function scene:overlayEnded( event )
        local group = self.view
        local overlay_name = event.sceneName  -- name of the overlay scene

        -----------------------------------------------------------------------------

        --      This event requires build 2012.797 or later.

        -----------------------------------------------------------------------------

end



---------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

-- "createScene" event is dispatched if scene's view does not exist
scene:addEventListener( "createScene", scene )

-- "willEnterScene" event is dispatched before scene transition begins
scene:addEventListener( "willEnterScene", scene )

-- "enterScene" event is dispatched whenever scene transition has finished
scene:addEventListener( "enterScene", scene )

-- "exitScene" event is dispatched before next scene's transition begins
scene:addEventListener( "exitScene", scene )

-- "didExitScene" event is dispatched after scene has finished transitioning out
scene:addEventListener( "didExitScene", scene )

-- "destroyScene" event is dispatched before view is unloaded, which can be
-- automatically unloaded in low memory situations, or explicitly via a call to
-- storyboard.purgeScene() or storyboard.removeScene().
scene:addEventListener( "destroyScene", scene )

-- "overlayBegan" event is dispatched when an overlay scene is shown
scene:addEventListener( "overlayBegan", scene )

-- "overlayEnded" event is dispatched when an overlay scene is hidden/removed
scene:addEventListener( "overlayEnded", scene )

---------------------------------------------------------------------------------

return scene