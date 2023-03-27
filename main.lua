-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------
-- show default status bar (iOS)

-- include Corona's "widget" library
local loadsave = require( "loadsave" )
local composer = require( "composer" )
local json = require( "json" ) 
loadedEndings = loadsave.loadTable( "endings.json" )


-- show default status bar (iOS)
display.setStatusBar( display.DefaultStatusBar )

-- include Corona's "widget" library
local widget = require "widget"
local composer = require "composer"
point=0

-- event listeners for tab buttons:
local function onFirstView( event )

    -- Path for the file to read
    local path = system.pathForFile( "endings.json", system.DocumentsDirectory)

    -- Open the file handle
    local file, errorString = io.open( path, "r" )
    

    composer.gotoScene( "view01_1_start_game")

    if not file then
        	local titleMusic = audio.loadStream( "music/Trust.mp3" )
    		audio.play(titleMusic)
    		audio.setVolume( 0.5 )
			composer.gotoScene( "view01_1_start_game" )
            -- composer.gotoScene( "ending" )
            
    else
        	local titleMusic = audio.loadStream( "music/Trust.mp3" )
    		audio.play(titleMusic)
    		audio.setVolume( loadedEndings.logValue )
    		--audio.setVolume( 0.5 )
			composer.gotoScene( "view01_1_start_game" )		
            -- composer.gotoScene( "ending" )
            
    end

end

local function onSecondView( event )
	composer.gotoScene( "view00Room" )
end

local function on3View( event )
	composer.gotoScene( "custom" )
end



onFirstView()	-- invoke first tab button's onPress event manually
--수정끝

