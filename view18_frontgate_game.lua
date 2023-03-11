
local composer = require( "composer" )
local physics = require("physics")
local scene = composer.newScene()
local loadsave = require( "loadsave" )
local json = require( "json" )

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
--- game.lua 게임화면 ( 고양이가 펀치를 쏘아서 맞추는 장면 )

local physics = require( "physics" )
physics.start()
physics.setGravity( 0, 0 )

-- Configure image sheet
local sheetOptions =
{
    frames =
    {
        {   -- 1) asteroid 1 outsider1
            x = 0,
            y = 0,
            width = 512,
            height = 512
        },
        {   -- 2) asteroid 2 outsider2
            x = 0,
            y = 0,
            width = 512,
            height = 512
        },
        {   -- 3) asteroid 3 outsider3
            x = 0,
            y = 0,
            width = 512,
            height = 512
        },
        {   -- 4) ship cat
            x = 0,
            y = 0,
            width = 512,
            height = 512
        },
        {   -- 5) laser punch
            x = 0,
            y = 0,
            width = 512,
            height = 512
        },
    },
}
--local objectSheet = graphics.newImageSheet( "gameObjects.png", sheetOptions )

-- Initialize variables
local lives = 2
local score = 0
local died = false

local asteroidsTable = {}

local ship
local gameLoopTimer
local livesText
local scoreText

local backGroup
local mainGroup
local uiGroup

local explosionSound
local screamSound
local fireSound
local musicTrack

local function updateText()
	livesText.text = "Lives: " .. lives
	scoreText.text = "Score: " .. score
end


local function createAsteroid()

	local newAsteroid = display.newImageRect( mainGroup, "image/frontgate/outsider.png", 102, 85 )--외부인 사진 
	table.insert( asteroidsTable, newAsteroid )
	physics.addBody( newAsteroid, "dynamic", { radius=40, bounce=0.8 } )
	newAsteroid.myName = "asteroid"

	local whereFrom = math.random( 3 )

	if ( whereFrom == 1 ) then
		-- From the left
		newAsteroid.x = -60
		newAsteroid.y = math.random( 500 )
		newAsteroid:setLinearVelocity( math.random( 40,120 ), math.random( 20,60 ) )
	elseif ( whereFrom == 2 ) then
		-- From the top
		newAsteroid.x = math.random( display.contentWidth )
		newAsteroid.y = -60
		newAsteroid:setLinearVelocity( math.random( -40,40 ), math.random( 40,120 ) )
	elseif ( whereFrom == 3 ) then
		-- From the right
		newAsteroid.x = display.contentWidth + 60
		newAsteroid.y = math.random( 500 )
		newAsteroid:setLinearVelocity( math.random( -120,-40 ), math.random( 20,60 ) )
	end

	newAsteroid:applyTorque( math.random( -6,6 ) )
end


local function fireLaser()

    -- Play fire sound!
    audio.play( fireSound )

	local newLaser = display.newImageRect( mainGroup, "image/frontgate/punch1.png", 100, 106 )--냥이 발바닥 사진 
	physics.addBody( newLaser, "dynamic", { isSensor=true } )
	newLaser.isBullet = true
	newLaser.myName = "laser"

	newLaser.x = ship.x
	newLaser.y = ship.y
	newLaser:toBack()

	transition.to( newLaser, { y=-40, time=500,
		onComplete = function() display.remove( newLaser ) end
	} )
end


local function dragShip( event )

	local ship = event.target
	local phase = event.phase

	if ( "began" == phase ) then
		-- Set touch focus on the ship
		display.currentStage:setFocus( ship )
		-- Store initial offset position
		ship.touchOffsetX = event.x - ship.x

	elseif ( "moved" == phase ) then
		-- Move the ship to the new touch position
		ship.x = event.x - ship.touchOffsetX

	elseif ( "ended" == phase or "cancelled" == phase ) then
		-- Release touch focus on the ship
		display.currentStage:setFocus( nil )
	end

	return true  -- Prevents touch propagation to underlying objects
end


local function gameLoop()

	-- Create new asteroid
	createAsteroid()

	-- Remove asteroids which have drifted off screen
	for i = #asteroidsTable, 1, -1 do
		local thisAsteroid = asteroidsTable[i]

		if ( thisAsteroid.x < -100 or
			 thisAsteroid.x > display.contentWidth + 100 or
			 thisAsteroid.y < -100 or
			 thisAsteroid.y > display.contentHeight + 100 )
		then
			display.remove( thisAsteroid )
			table.remove( asteroidsTable, i )
		end
	end
end


local function restoreShip()

	ship.isBodyActive = false
	ship.x = display.contentCenterX
	ship.y = display.contentHeight - 100

	-- Fade in the ship
	transition.to( ship, { alpha=1, time=4000,
		onComplete = function()
			ship.isBodyActive = true
			died = false
		end
	} )
end


local function endGame() --게임 실패 (처음 play화면으로)
	composer.removeScene("view19_highscores") 
	composer.setVariable("score", -1)
	composer.gotoScene( "view19_highscores", { time=800, effect="crossFade" } )
end


local function onCollision( event )

	if ( event.phase == "began" ) then

		local obj1 = event.object1
		local obj2 = event.object2

		if ( ( obj1.myName == "laser" and obj2.myName == "asteroid" ) or
			 ( obj1.myName == "asteroid" and obj2.myName == "laser" ) )
		then
			-- Remove both the laser and asteroid
			display.remove( obj1 )
			display.remove( obj2 )

            -- Play explosion sound!  
            audio.play( screamSound )

			for i = #asteroidsTable, 1, -1 do
				if ( asteroidsTable[i] == obj1 or asteroidsTable[i] == obj2 ) then
					table.remove( asteroidsTable, i )
					break
				end
			end

			-- Increase score
			score = score + 100
			scoreText.text = "Score: " .. score
			if (score >= 700)then----게임 성공 (5000점 넘겼을때)
				composer.removeScene("game")
				composer.setVariable("score", 5)
				audio.stop ( 1 )
				composer.gotoScene( "view19_highscores" )
			end

		elseif ( ( obj1.myName == "ship" and obj2.myName == "asteroid" ) or
				 ( obj1.myName == "asteroid" and obj2.myName == "ship" ) )
		then
			if ( died == false ) then
				died = true

                -- Play explosion sound!--고양이가 맞았을 때 
                audio.play( explosionSound )
				-- Update lives

				lives = lives - 1
				livesText.text = "Lives: " .. lives

				if ( lives == 0 ) then
					display.remove( ship )
					timer.performWithDelay( 2000, endGame )
				else
					ship.alpha = 0
					timer.performWithDelay( 1000, restoreShip )
				end
			end
		end
	end
end


-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen

	physics.pause()  -- Temporarily pause the physics engine

	-- Set up display groups
	backGroup = display.newGroup()  -- Display group for the background image
	sceneGroup:insert( backGroup )  -- Insert into the scene's view group

	mainGroup = display.newGroup()  -- Display group for the ship, asteroids, lasers, etc.
	sceneGroup:insert( mainGroup )  -- Insert into the scene's view group

	uiGroup = display.newGroup()    -- Display group for UI objects like the score
	sceneGroup:insert( uiGroup )    -- Insert into the scene's view group
	
	-- Load the background
	local background = display.newImageRect( backGroup, "image/frontgate/gate.jpg", 1280, 720 )--배경이미지 
	background.x = display.contentCenterX
	background.y = display.contentCenterY

	local security = display.newImageRect( backGroup, "image/frontgate/security.png", 200, 200)--경비원 이미지 
	security.x = display.contentCenterX*1.7
	security.y = display.contentCenterY*1.2
	
	ship = display.newImageRect( mainGroup, "image/frontgate/cat1.png", 200, 191)--고양이 이미지 108 99
	ship.x = display.contentCenterX
	ship.y = display.contentHeight - 100
	physics.addBody( ship, { radius=30, isSensor=true } )
	ship.myName = "ship"

	-- Display lives and score
	livesText = display.newText( uiGroup, "Lives: " .. lives, 200, 80, native.systemFont, 36 )
	scoreText = display.newText( uiGroup, "Score: " .. score, 400, 80, native.systemFont, 36 )

	ship:addEventListener( "tap", fireLaser )
	ship:addEventListener( "touch", dragShip )

	explosionSound = audio.loadSound( "music/Meow 2.mp3" ) --고양이 맞았을때 
    fireSound = audio.loadSound( "music/Mew 1.mp3" )--고양이 펀치쏠때
    screamSound = audio.loadSound("music/No.mp3") --펀치가 적중했을때 
    musicTrack = audio.loadStream( "music/backgroundM.mp3")--배경음악 
end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen
		physics.start()
		Runtime:addEventListener( "collision", onCollision )
		gameLoopTimer = timer.performWithDelay( 500, gameLoop, 0 )
		-- Start the music!
        audio.play( musicTrack, { channel=1, loops=-1 } )
	end
end


-- hide()
function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is on screen (but is about to go off screen)
		timer.cancel( gameLoopTimer )

	elseif ( phase == "did" ) then
		-- Code here runs immediately after the scene goes entirely off screen
		Runtime:removeEventListener( "collision", onCollision )
		physics.stop()---
		 -- Stop the music!
        audio.stop( 1 )
		composer.removeScene( "game" )
	end
end


-- destroy()
function scene:destroy( event )

	local sceneGroup = self.view
	-- Code here runs prior to the removal of scene's view
    -- Dispose audio!
    audio.dispose( explosionSound )
    audio.dispose( screamSound)
    audio.dispose( fireSound )
    audio.dispose( musicTrack )
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
