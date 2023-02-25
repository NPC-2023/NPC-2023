-----------------------------------------------------------------------------------------
--
-- custom.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

	local background = display.newImageRect("image/custom/catroom.png", display.contentWidth, display.contentHeight)
 	background.x, background.y = display.contentWidth/2, display.contentHeight/2

 	local backgroundMusic = audio.loadStream( "soundEffect/safe room theme.ogg" )
	audio.play( backgroundMusic )

	local cat = display.newImageRect("image/custom/cat.png", 300, 300)
 	cat.x, cat.y = display.contentWidth*0.3, display.contentHeight*0.5
 	cat.xScale = -1

 	local objectGroup = display.newGroup()

 	local panel = {}
 	for i = 1,3 do
	 	panel[i] = display.newImageRect("image/custom/glassPanel_tab.png", 100, 100)
	 	panel[i].x, panel[i].y = display.contentWidth*(0.5+0.1*i), display.contentHeight*0.3
	 	objectGroup:insert(panel[i])
 	end
 	for i = 1,3 do
	 	panel[3+i] = display.newImageRect("image/custom/glassPanel_tab.png", 100, 100)
	 	panel[3+i].x, panel[3+i].y = display.contentWidth*(0.5+0.1*i), display.contentHeight*0.5
	 	panel[3+i].name = "panel"..(3+i)
	 	objectGroup:insert(panel[3+i])
 	end	
 	for i = 1,3 do
	 	panel[6+i] = display.newImageRect("image/custom/glassPanel_tab.png", 100, 100)
	 	panel[6+i].x, panel[6+i].y = display.contentWidth*(0.5+0.1*i), display.contentHeight*0.7
	 	objectGroup:insert(panel[6+i])
 	end	

 	local function changefurColorEvent(event)
 		if(event.target.name == 'panel4') then
 			cat = display.newImageRect("image/custom/graycat.png", 300, 300)
 			cat.x, cat.y = display.contentWidth*0.3, display.contentHeight*0.5
 			cat.xScale = -1
 		elseif(event.target.name == 'panel5') then
 			cat.alpha = 0
 			cat = display.newImageRect("image/custom/pinkcat.png", 300, 300)
 			cat.x, cat.y = display.contentWidth*0.3, display.contentHeight*0.5
 			cat.xScale = -1
 		else 
 			cat = display.newImageRect("image/custom/cat.png", 300, 300)
 			cat.x, cat.y = display.contentWidth*0.3, display.contentHeight*0.5
 			cat.xScale = -1
 		end
 	end	

 	local paint = {}
 	paint[1] = display.newImageRect("image/custom/graypaint.png", 80, 80)
 	paint[1].x, paint[1].y = display.contentWidth*(0.5+0.1*1), display.contentHeight*0.5
 	paint[2] = display.newImageRect("image/custom/pinkpaint.png", 80, 80)
 	paint[2].x, paint[2].y = display.contentWidth*(0.5+0.1*2), display.contentHeight*0.5
	paint[3] = display.newImageRect("image/custom/yellowpaint.png", 80, 80)
 	paint[3].x, paint[3].y = display.contentWidth*(0.5+0.1*3), display.contentHeight*0.5

 	

	objectGroup:insert(cat)
	objectGroup:insert(panel[4])

	objectGroup:insert(paint[1])
	objectGroup:insert(paint[2])
	objectGroup:insert(paint[3])

 	sceneGroup:insert(background)
 	sceneGroup:insert(objectGroup)

 	panel[4]:addEventListener("tap", changefurColorEvent)
 	panel[5]:addEventListener("tap", changefurColorEvent)
 	panel[6]:addEventListener("tap", changefurColorEvent)
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