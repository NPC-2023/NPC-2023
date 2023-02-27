-----------------------------------------------------------------------------------------
--
-- view1.lua
--
-----------------------------------------------------------------------------------------

local composer = require("composer")
local physics = require("physics")
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

	--physics.start()
	--physics.setDrawMode("hybrid")

	local background = display.newImageRect("image/background.png",display.contentWidth, display.contentHeight) ---배경
	background.x, background.y = display.contentWidth/2, display.contentHeight/2
	background.alpha = 0.5
	
	local section = display.newRect(display.contentWidth/2, display.contentHeight*0.8, display.contentWidth, display.contentHeight*0.3)
	section:setFillColor(0.35, 0.35, 0.35, 0.35)
	section.alpha=0
	
	local script = display.newText("게임방법\n제한 시간 이내에 물건을 클릭해서 주우세요!\n5점 이상 획득하면 CLEAR!\n\n쓰레기: -1점  생선뼈: GameOver  나머지 물건: +1점", section.x+30, section.y-100, native.systemFontBold)
	script.size = 30
	script:setFillColor(1)
	script.x, script.y = display.contentWidth/2, display.contentHeight*0.789
	script.alpha=0

	local score1=0 
	local score = display.newImageRect("image/score.png", 130, 130)
	score.x,score.y = display.contentWidth/11, display.contentHeight/5.5

 	local showScore = display.newText(score1, display.contentWidth/11,display.contentHeight/5.555) 
	showScore:setFillColor(1,0,0) 
	showScore.size = 60

	local alarm = display.newImageRect("image/alarm.png", 150, 150)
	alarm.x, alarm.y = display.contentWidth*0.9, display.contentHeight*0.15

	local objectGroup = display.newGroup()
	local object = {}
	local objects = {"1", "2", "3", "4", "5"}
	local i = 1

	local function pagemove()
		display.remove(objectGroup)
		display.remove(arrow)
		timer.cancel(timer1)
		display.remove(alarm)
		display.remove(score)
		display.remove(showScore)
		timer.cancel(timer2)
		display.remove(cat)
		showScore.alpha = 0

		if (score1 <= 4) then			
		--	audio.pause(explosionSound)
			composer.setVariable("score1", -1)
			composer.removeScene("view02_pick_game")
			composer.gotoScene("view02_pick_game_over")
		else
			composer.setVariable("score1", 5)
			composer.removeScene("view02_pick_game")
			composer.gotoScene("view02_pick_game_over")
		end
	end
	local tapSound = audio.loadSound("music/tap.mp3")
	local function tapEventListener(event)
		
    	audio.play(tapSound)
    	audio.setVolume(0.2)

		if (event.target.type == "food") then
			score1 = score1 + 1
			display.remove(event.target)
			showScore.text = score1
		elseif (event.target.type == "trash") then
			score1 = score1 - 1
			display.remove(event.target)
			showScore.text = score1
		else
			score1 = -1
			pagemove()--게임오버
		end
	end

	local function generate()
		local objIdx = math.random(#objects)
		local objName = objects[objIdx]
		object[i] = display.newImageRect(objectGroup, "image/obj".. objName..".png", 110, 110)
		object[i].x, object[i].y = math.random(250,1000), math.random(100,550)
		local obj = object[i] 
		timer.performWithDelay(1100, function() display.remove(obj) end)
		if (objIdx < 4) then
			object[i].type="food"
		elseif (objIdx == 4) then
			object[i].type="trash"
		else
			object[i].type="die"
		end
		object[i]:addEventListener("tap", tapEventListener)

		i = i + 1	
		
	end

	--------------게임 시작--------------
	local function apper(event)
		generate()
	end

 	local time = display.newText(20, display.contentWidth*0.9 + 9, display.contentWidth*0.1-3)
	time.size = 50
	time:setFillColor(1, 0, 0)
	time.alpha = 0
	
	local function counter( event )
 		time.text = time.text - 1

	 	if(time.text == "-1") then
	 		time.alpha = 0
	 		pagemove()
 		end
 	end

 	local function playGame(event)
 		timer1 = timer.performWithDelay(1000, counter, 21)
 		time.alpha = 1
 		background.alpha = 1
 		alarm.alpha = 1
 		score.alpha = 1
		showScore.alpha = 1
		section.alpha = 0
		script.alpha = 0
		showScore.alpha = 1
		timer2 = timer.performWithDelay(800, generate, 30)
	end

	--처음 실행
	local function titleremove(event)
		section.alpha = 1
		score.alpha = 0
		showScore.alpha = 0
		alarm.alpha = 0
		script.alpha = 1
		section:addEventListener("tap", playGame)
	end


	titleremove()

	sceneGroup:insert(background)
	sceneGroup:insert(time)
	sceneGroup:insert(score)
	sceneGroup:insert(showScore)
	
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