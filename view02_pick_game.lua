-----------------------------------------------------------------------------------------
--
-- view1.lua
--
-----------------------------------------------------------------------------------------

local loadsave = require( "loadsave" )
local composer = require( "composer" )
local scene = composer.newScene()
local json = require( "json" ) 

function scene:create( event )
	local sceneGroup = self.view

	--physics.start()
	--physics.setDrawMode("hybrid")
	loadedEndings = loadsave.loadTable( "endings.json" )

	composer.setVariable("gameName", "view02_pick_game")

	local background = display.newImageRect("image/pick/background.png", display.contentWidth*3, display.contentHeight)
	background.x = display.contentCenterX
    background.y = display.contentCenterY
	background.alpha = 0.5
	sceneGroup:insert(background)
	
	local section = display.newRect(display.contentCenterX, display.contentCenterY*1.5, background.width, background.y*0.8)
	section:setFillColor(0.35, 0.35, 0.35, 0.35)
	sceneGroup:insert(section)
	
	local script = display.newText("게임방법\n\n제한 시간 이내에 물건을 클릭해서 주우세요!\n5점 이상 획득하면 CLEAR!\n\n생선뼈: -1점  폭탄: GameOver  나머지 물건: +1점", section.x+30, section.y-100, native.systemFontBold)
	script.size = 20
	script:setFillColor(1)
	script.x, script.y = section.x-200, section.y
	sceneGroup:insert(script)

	local score = 0 
	local scoreImage = display.newImageRect("image/pick/스코어.png", display.contentWidth/3.5, display.contentHeight/4.5)
	scoreImage.x,scoreImage.y = display.contentCenterX-410, display.contentCenterY*0.25
	scoreImage.alpha = 0
	sceneGroup:insert(scoreImage)

 	local showScore = display.newText(score, scoreImage.x+1, scoreImage.y-5) 
	showScore:setFillColor(1,0,0) 
	showScore.size = 30
	showScore.alpha = 0
	sceneGroup:insert(showScore)

	local alarm = display.newImageRect("image/pick/타이머.png", display.contentWidth/3, display.contentHeight/4)
	alarm.x, alarm.y = display.contentCenterX*3.6, display.contentCenterY*0.25
	alarm.alpha = 0
	sceneGroup:insert(alarm)

	local time = display.newText(20, alarm.x, alarm.y+5)
	time.size = 30
	time:setFillColor(1, 0, 0)
	time.alpha = 0
	sceneGroup:insert(time)
	
	local musicOption = { 
    	loops = -1
	}

	local pickGame_bgm = audio.loadStream("music/music2.flac")
	audio.play(pickGame_bgm, musicOption)

    audio.setVolume( loadedEndings.logValue )--loadedEndings.logValue
 	--sceneGroup:insert(home)


	local function pagemove()
		timer.cancel(timer1)
		timer.cancel(timer2)
		timer.cancel(timer3)
		if (score <= 4) then
			composer.setVariable("score1", -1)
		else
			composer.setVariable("score1", 5)
		end	
		audio.pause(bgm_play)
		composer.removeScene("view02_pick_game")
		composer.gotoScene("view02_pick_game_over")
	end

	local tapSound = audio.loadSound("soundEffect/clickeffect.ogg")
	local bomb = audio.loadSound("soundEffect/bomb.wav")
	local error = audio.loadSound("soundEffect/error.mp4")
	local function tapEventListener(event)	
		if (event.target.type == "food") then
			audio.play(tapSound)
			score = score + 1
			display.remove(event.target)
			showScore.text = score
		elseif (event.target.type == "trash") then
			audio.play(error)
			score = score - 1
			display.remove(event.target)
			showScore.text = score
		elseif (event.target.type=="die") then
			audio.play(bomb)
			score = -1
			display.remove(event.target)
			timer.performWithDelay( 400, function() pagemove()--게임오버
		end)
			pagemove()--게임오버
		end
	end

	local objectGroup = display.newGroup()
	local object = {}
	local objects = {"1", "2", "3", "4", "5"}
	local i = 1
	local x_differ = 0
	local function generate()
		local objIdx = math.random(#objects)
		local objName = objects[objIdx]
		object[i] = display.newImageRect(objectGroup, "image/pick/obj".. objName..".png", display.contentWidth/3.5, display.contentHeight/5.5)
		object[i].x, object[i].y = math.random(-130, 450), math.random(100, 400) 
		local obj = object[i] 
		local function remove(event)
			display.remove(obj)
		end
		timer3 = timer.performWithDelay(800, remove, 30, "gameTime")
		if (objIdx < 4) then
			object[i].type="food"
		elseif (objIdx == 4) then
			object[i].type="trash"
		else
			object[i].type="die"
		end

		sceneGroup:insert(object[i])
		object[i]:addEventListener("tap", tapEventListener)

		i = i + 1		
	end


	--샘플 볼륨 이미지
    -- local volumeButton = display.newImage("image/설정/설정.png")
    -- volumeButton.x,volumeButton.y = display.contentCenterX * 0.87, display.contentCenterY * 0.9
    
    -- 2023.07.04 edit by jiruen // 샘플 볼륨 bgm
    local volumeBgm = audio.loadStream("soundEffect/263126_설정 클릭시 나오는 효과음(2).wav")

    local volumeButton = display.newImageRect("image/설정/설정.png", display.contentWidth/5, display.contentHeight/8)
    volumeButton.x,volumeButton.y = alarm.x, alarm.y*2.5
    volumeButton.alpha = 0
	sceneGroup:insert(volumeButton)
   	
   	local options = {
        isModal = true
    }
    --샘플볼륨함수--
    local function setVolume(event)
    	audio.play(volumeBgm)
        composer.showOverlay( "StopGame", options )
    end
    volumeButton:addEventListener("tap", setVolume)


	--------------게임 시작--------------
	local function counter( event )
 		time.text = time.text - 1
 		print(time.text)
	 	if(time.text == "-1") then
	 		time.alpha = 0
	 		pagemove()
 		end
 	end  
 	local function playGame(event) 	
 		timer1 = timer.performWithDelay(1000, counter, 21, "gameTime")
 		time.alpha = 1
 		background.alpha = 1
 		alarm.alpha = 1
 		volumeButton.alpha = 1
 		scoreImage.alpha = 1
		showScore.alpha = 1
		section.alpha = 0
		script.alpha = 0
		timer2 = timer.performWithDelay(900, generate, 30, "gameTime")
	end

	section:addEventListener("tap", playGame)
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