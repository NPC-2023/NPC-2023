
local composer = require( "composer" )
local physics = require("physics")
local scene = composer.newScene()
local loadsave = require( "loadsave" )
local json = require( "json" )

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local function gotoGame()
	composer.gotoScene( "game", { time=800, effect="crossFade" } )
end

-- local function gotoHighScores()
-- 	composer.gotoScene( "highscores", { time=800, effect="crossFade" } )
-- end


-- -----------------------------------------------------------------------------------
-- Scene event functions ---여기가 시작 화면 ( play버튼이 있는 첫 시작 화면 ) 
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen

	local background = display.newImageRect( sceneGroup, "image/frontgate/gate.jpg", 1280, 720)
	background.x = display.contentCenterX
	background.y = display.contentCenterY
	--sceneGroup:insert(background)

	local title = display.newImageRect( sceneGroup, "image/frontgate/title.png", 500, 450 ) --300 300
	title.x = display.contentCenterX
	title.y = 500
	--sceneGroup:insert(title)

	local playButton = display.newText( sceneGroup, "Play", display.contentCenterX, 770, native.systemFont, 70 ) --700  44
	playButton:setFillColor( 1 ) -- 0.82 0.86 1
	playButton:addEventListener( "tap", gotoGame )
	--sceneGroup:insert(playButton)

	local function gotoGame()
		composer.gotoScene( "view18_frontgate_game", { time=800, effect="crossFade" } )
	end

	title:addEventListener( "touch", gotoGame )
end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen

	end
end


-- hide()
function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is on screen (but is about to go off screen)

	elseif ( phase == "did" ) then
		-- Code here runs immediately after the scene goes entirely off screen

	end
end


-- destroy()
function scene:destroy( event )

	local sceneGroup = self.view
	-- Code here runs prior to the removal of scene's view

end


-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene
