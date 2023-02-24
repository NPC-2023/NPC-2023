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
	composer.gotoScene( "fishGame" )
end

onFirstView()	-- invoke first tab button's onPress event manually
