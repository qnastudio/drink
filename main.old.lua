
local widget = require ( "widget" )
local storyboard = require( "storyboard")

display.setStatusBar( display.HiddenStatusBar )

cupW,cupH = 150, 150
cupX,cupY = display.viewableContentWidth/2,display.viewableContentWidth/1.8+10
toScene = false

storyboard.parameters = {
	sceneChangTime = 300
}

display.setDefault( "background", 1)


-- Create buttons table for the tab bar
--[[local tabButtons = 
{
	{
		width = 32, height = 32,
		defaultFile = "assets/tabIcon.png",
		overFile = "assets/tabIcon-down.png",
		label = "Tea",
		onPress = function() storyboard.gotoScene( "chooseTea" ); end,
		selected = true
	},
	{
		width = 32, height = 32,
		defaultFile = "assets/tabIcon.png",
		overFile = "assets/tabIcon-down.png",
		label = "basic",
		onPress = function() storyboard.gotoScene( "icesugar" ); end,
	},
	{
		width = 32, height = 32,
		defaultFile = "assets/tabIcon.png",
		overFile = "assets/tabIcon-down.png",
		label = "catch",
		onPress = function() storyboard.gotoScene( "catch" ); end,
	},
	{
		width = 32, height = 32,
		defaultFile = "assets/tabIcon.png",
		overFile = "assets/tabIcon-down.png",
		label = "shake",
		onPress = function() storyboard.gotoScene( "shake" ); end,
	},
	{
		width = 32, height = 32,
		defaultFile = "assets/tabIcon.png",
		overFile = "assets/tabIcon-down.png",
		label = "addIngredient",
		onPress = function() storyboard.gotoScene( "addIngredient" ); end,
	}
}

--Create a tab-bar and place it at the bottom of the screen
local demoTabs = widget.newTabBar
{	
	left = 0,
	top = display.contentHeight - 70,
	height = 70,
	width=display.contentWidth,
	backgroundFile = "assets/tabbar.png",
	tabSelectedLeftFile = "assets/tabBar_tabSelectedLeft.png",
	tabSelectedMiddleFile = "assets/tabBar_tabSelectedMiddle.png",
	tabSelectedRightFile = "assets/tabBar_tabSelectedRight.png",
	tabSelectedFrameWidth = 20,
	tabSelectedFrameHeight = 52,
	buttons = tabButtons
}
--]]

local monitorMen =function (  )
	-- body
	collectgarbage( )
	print( "MemUsage:  "..collectgarbage("count") )

	local textMen = system.getInfo( "textureMemoryUsed" )
	print( "TexMen:  "..textMen )
end

monitorMen()




storyboard.gotoScene( "start2" )
