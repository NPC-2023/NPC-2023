-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------
-- show default status bar (iOS)
display.setStatusBar( display.DefaultStatusBar )

-- include Corona's "widget" library
local widget = require "widget"
local composer = require "composer"
local physics = require "physics"
physics.start()
-- event listeners for tab buttons:
local function onFirstView( event )
	-- composer.gotoScene( "view02_lost_stuId_game" )
	-- composer.gotoScene( "view02_lost_stuId_game_final" )
	-- composer.gotoScene( "view03_climbing_the_tree_game" )
	composer.gotoScene("pre_climbingTree")
end

onFirstView()	-- invoke first tab button's onPress event manually
