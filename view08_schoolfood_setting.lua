-----------------------------------------------------------------------------------------
--
-- setting.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local physics = require("physics")
local scene = composer.newScene()
local loadsave = require( "loadsave" )
local json = require( "json" )

function scene:create( event )
	local sceneGroup = self.view

	-- local background = display.newRoundedRect(display.contentWidth/2, display.contentHeight/2, display.contentWidth/2, display.contentHeight*0.6, 55)
 -- 	background.strokeWidth = 10
	-- background:setStrokeColor( 0.4, 0.2, 0.2 )
 -- 	background:setFillColor(0.6, 0.5, 0.5)

 	local background = display.newImageRect("image/schoolfood/memo.png", display.contentWidth*1.5, display.contentHeight)--배경이미지  520 520
	background.x, background.y = display.contentWidth/2, display.contentHeight/2

 	-- local cancelButton = display.newText("hint", display.contentWidth/2, display.contentHeight*0.3)
 	-- title.size = 70
    local cancelButton = display.newImageRect("image/schoolfood/cancelButton.png", display.contentWidth/8, display.contentHeight/11.5) --40 40
 	cancelButton.x, cancelButton.y = background.x*2.11, background.y*0.18--display.contentWidth*1.1, display.contentHeight*0.06

 	function cancelButton:tap( event )
 		composer.hideOverlay('view08_schoolfood_setting')
 	end
 	cancelButton:addEventListener("tap", cancelButton)

 	sceneGroup:insert(background)
 	sceneGroup:insert(cancelButton)

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
