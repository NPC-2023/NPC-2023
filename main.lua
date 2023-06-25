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
        	-- composer.gotoScene( "view18_npc_frontgate_game" )
            
    else
        	local titleMusic = audio.loadStream( "music/Trust.mp3" )
    		audio.play(titleMusic)
    		audio.setVolume( loadedEndings.logValue )
    		--audio.setVolume( 0.5 )
			composer.gotoScene( "view01_1_start_game" )		
            -- composer.gotoScene( "view18_npc_frontgate_game" )
            
    end
	--composer.gotoScene( "View01_main" )

end

onFirstView()	-- invoke first tab button's onPress event manually
