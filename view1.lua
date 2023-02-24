-----------------------------------------------------------------------------------------
--
-- view1.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

	local physics = require("physics")
	physics.start()
	physics.setDrawMode("hybrid")

	local gametitle = display.newText("게임 시작\n\n", display.contentWidth/2, display.contentHeight/2, native.systemFontBold)
	gametitle.size=80
	--local gametitle = display.newImageRect("image/carrot.png", display.contentWidth, display.contentHeight)
	gametitle.x, gametitle.y = display.contentWidth/2, display.contentHeight/2
	
	local section = display.newRect(display.contentWidth/2, display.contentHeight*0.8, display.contentWidth, display.contentHeight*0.3)
	section:setFillColor(0.35, 0.35, 0.35, 0.35)
	section.alpha=0
	
	local script = display.newText("                      게임방법\n\n물건을 줍자\n\n*쓰레기:-1  생선뼈:GameOver  나머지 물건:+1", section.x+30, section.y-100, native.systemFontBold)
	script.size = 30
	script:setFillColor(1)
	script.x, script.y = display.contentWidth/2, display.contentHeight*0.789
	script.alpha=0

	local background = display.newImageRect("image/background.png",display.contentWidth, display.contentHeight) ---배경
	background.x, background.y = display.contentWidth/2, display.contentHeight/2
	background.alpha = 0.5

	local score = 0
	local showScore = display.newText(score, display.contentWidth*0.826, display.contentHeight*0.10)
	showScore:setFillColor(0)
	showScore.size = 30
	showScore.alpha = 0

	local alarm = display.newImageRect("image/alarm.png", 150, 150)
	alarm.x, alarm.y = display.contentWidth*0.9, display.contentHeight*0.15
	alarm.alpha = 0
	local setting = display.newImageRect("image/setting.png", 100, 100)
	setting.x, setting.y = display.contentWidth*0.9 + 0.5, display.contentHeight*0.4
	setting.alpha = 0

	local objectGroup = display.newGroup()
	local object = {}
	local objects = {"1", "2", "3", "4", "5"}
	local i = 1

	local function pagemove()
		display.remove(objectGroup)
		display.remove(arrow)
		timer.cancel(timer1)
		timer.cancel(timer2)
		display.remove(alarm)
		display.remove(setting)
		timer.cancel(timer3)
		display.remove(cat)
		composer.removeScene("game")
		composer.gotoScene("view02_over")
	end

	local function tapEventListener(event)
		if (event.target.type == "food") then
			score = score + 1
			display.remove(event.target)
			showScore.text = score 
		elseif (event.target.type == "trash") then
			score = score-1
			display.remove(event.target)
			showScore.text=score
		else
			pagemove()--게임오버
		end

			--if score<0 then			
			--	pagemove()
			--	audio.pause(explosionSound)
			--	composer.removeScene("view02_fall_game")
			--	composer.setVariable("score", -1)
			--	composer.gotoScene("view02_fall_game_over")

			--elseif score == 10 then
			--	pagemove()
			--	audio.pause(explosionSound)
			--	composer.removeScene("view02_fall_game")
			--	composer.setVariable("score", 5)
			--	composer.gotoScene( "view02_fall_game_over" )
			--end
		
	end
	
	local function generate()
		local objIdx = math.random(#objects)
		local objName = objects[objIdx]
		object[i] = display.newImageRect(objectGroup, "image/obj".. objName..".png", 90, 90)
		object[i].x, object[i].y = math.random(100,1200), math.random(100,630)
		--timer4 = timer.performWithDelay(600, remove)
		--display.remove(object[i])
		local obj = object[i] 
		timer.performWithDelay(1300, function() display.remove(obj) end)
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

	local time1 = display.newText(3, display.contentWidth*0.9 + 9, display.contentWidth*0.1-3)
	time1.size = 50
	time1:setFillColor(1, 0, 0)
	time1.alpha = 0
	
	local function counter1( event )
 		time1.text = time1.text - 1

	 	if(time1.text == "-1") then
	 		time1.alpha = 0
 		end
 	end

 	local time2 = display.newText(20, display.contentWidth*0.9 + 9, display.contentWidth*0.1-3)
	time2.size = 50
	time2:setFillColor(1, 0, 0)
	time2.alpha = 0
	
	local function counter2( event )
 		time2.text = time2.text - 1

	 	if(time2.text == "-1") then
	 		time2.alpha = 0
 		end
 	end



 	local function playGame(event)
		timer2 = timer.performWithDelay(1000, counter2, 21)
		time2.alpha = 1
		timer3 = timer.performWithDelay(1100, generate, 20)
	end

 	local function startGame(event)
 		timer1 = timer.performWithDelay(1000, counter1, 4)
 		background.alpha = 1
 		alarm.alpha = 1
 		setting.alpha = 1
		section.alpha = 0
		script.alpha = 0
		time1.alpha = 1
		timer3 = timer.performWithDelay(5000, playGame)
	end

	--처음 실행
	local function titleremove(event)
		gametitle.alpha = 0
		section.alpha = 1
		alarm.alpha = 0
		script.alpha = 1
		section:addEventListener("tap", startGame)
	end

	gametitle:addEventListener("tap", titleremove)

	sceneGroup:insert(background)
	sceneGroup:insert(time1)
	sceneGroup:insert(time2)

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