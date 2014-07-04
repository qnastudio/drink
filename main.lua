-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------
display.setStatusBar( display.HiddenStatusBar )

local storyboard = require( "storyboard" )

actW = display.actualContentWidth
actH = display.actualContentHeight
conCX = display.contentCenterX
conCY = display.contentCenterY

teaN = 8
iceN = 8
sugarN = 8
teaCatch = 0
iceCatch = 0
sugarCatch = 0  


--need improve
cupW,cupH = 200,320
cupX,cupY = display.viewableContentWidth/2,display.viewableContentWidth/1.8+10
toScene = false
temp = 1

storyboard.parameters = {
	sceneChangTime = 300
}

display.setDefault( "background", 1)

storyboard.gotoScene( "start3" )