-----------------------------------------------------------------------------------------
--
-- view1.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

	local background = display.newRect(display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight)

	local object = {}

 	object[1] = display.newRect(display.contentCenterX, display.contentCenterY, 500, 500)
 	object[1]:setFillColor(1, 0, 0)

 	object[2] = display.newRect(display.contentCenterX, display.contentCenterY, 300, 300)
 	object[2]:setFillColor(1, 0.5, 0)

 	object[3] = display.newRect(display.contentCenterX, display.contentCenterY, 100, 100)
 	object[3]:setFillColor(1, 1, 0)

	local objectGroup = display.newGroup()

 	objectGroup:insert(object[1])
 	objectGroup:insert(object[2])
 	objectGroup:insert(object[3])

 	sceneGroup:insert(background)
 	sceneGroup:insert(objectGroup)

 	objectGroup.x = objectGroup.x + 100
 	objectGroup.y = objectGroup.y - 100




end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		-- Called when the scene is now on screen
		-- 
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.
	end	
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
	elseif phase == "did" then
		-- Called when the scene is now off screen
	end
end

function scene:destroy( event )
	local sceneGroup = self.view
	
	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene