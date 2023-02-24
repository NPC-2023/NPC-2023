-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------
-- show default status bar (iOS)

-- include Corona's "widget" library
local widget = require "widget"
local loadsave = require( "loadsave" )
local composer = require "composer"
local physics = require "physics"
local json = require( "json" ) 
loadedEndings = loadsave.loadTable( "endings.json" )
physics.start()
-- event listeners for tab buttons:

display.setStatusBar( display.DefaultStatusBar )

local function onFirstView( event )
	 -- Path for the file to read
    local path = system.pathForFile( "endings.json", system.DocumentsDirectory)

    -- Open the file handle
    local file, errorString = io.open( path, "r" )
    
    composer.gotoScene("view01_1_start_game")
    if not file then
        	local titleMusic = audio.loadStream( "music/Trust.mp3" )
    		audio.play(titleMusic)
    		audio.setVolume( 0.5 )
			composer.gotoScene( "title" )
    else
        	local titleMusic = audio.loadStream( "music/Trust.mp3" )
    		audio.play(titleMusic)
    		audio.setVolume( loadedEndings.logValue )
			composer.gotoScene( "title" )
    end
end

onFirstView()	-- invoke first tab button's onPress event manually
