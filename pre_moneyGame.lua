-----------------------------------------------------------------------------------------
--
-- pre_moneyGame.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

	local background = display.newImageRect("image/place1.jpg", display.contentWidth, display.contentHeight)
 	background.x, background.y = display.contentWidth/2, display.contentHeight/2

 	sceneGroup:insert(background)

 	local npc = display.newImageRect("image/npc1.png", 300, 400)
	npc.x, npc.y = display.contentWidth*0.7, display.contentHeight*0.6
	npc.xScale = -1

	local cat = display.newImageRect("image/cat_back.png", 200, 200)
	cat.x, cat.y = display.contentWidth*0.6, display.contentHeight*0.8

	local speechbubble = display.newImageRect("image/speechbubble.png", 250, 150)
	speechbubble.x, speechbubble.y = display.contentWidth*0.6, display.contentHeight*0.35

	local script, accept = nil, nil

	--npc 말풍선 및 수락 텍스트
	local function talkWithNPC( event )
		script = display.newText("학생증을 잃어버렸어..\n 본관 뒤에 있을텐데..\n", 
			speechbubble.x, speechbubble.y, "font/DOSGothic.ttf")
		script.size = 20
		script:setFillColor(0)

		timer.performWithDelay( 1000, function() 
			accept = display.newText("눌러서 퀘스트 수락\n", 
			speechbubble.x, speechbubble.y - 100, "font/DOSGothic.ttf")
			accept.size = 20
			accept:setFillColor(1)
		end)
	end

	local function acceptQuest( event )
		--수락시 말풍선, 대화 사라짐
		speechbubble.alpha = 0
		script.alpha = 0
		timer.performWithDelay( 500, function() 
			accept.alpha = 0
		end)
		--수락(말풍선)누르면 고양이가 말함
		local speechbubble2 = display.newImageRect("image/speechbubble.png", 200, 75)
		speechbubble2.x, speechbubble2.y = cat.x, cat.y-100
		local script2 = display.newText("내가 찾아줄게냥!\n", 
			speechbubble2.x, speechbubble2.y, "font/DOSGothic.ttf")
		script2.size = 20
		script2:setFillColor(0)
		--1초뒤 고양이 대화 사라짐
		timer.performWithDelay( 1000, function() 
			speechbubble2.alpha = 0
			script2.alpha = 0
		end)
	end

	npc:addEventListener("tap", talkWithNPC)
	speechbubble:addEventListener("tap", acceptQuest)

	local objectGroup = display.newGroup()

 	objectGroup:insert(npc)
 	objectGroup:insert(cat)
 	objectGroup:insert(speechbubble)

 	sceneGroup:insert(background)
 	sceneGroup:insert(objectGroup)

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