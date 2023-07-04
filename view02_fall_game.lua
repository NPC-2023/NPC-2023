-----------------------------------------------------------------------------------------
--
-- view02_fall_game.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local physics = require("physics")
local scene = composer.newScene()
local loadsave = require( "loadsave" )
local json = require( "json" )

function scene:create( event )
	local sceneGroup = self.view
	physics.start()
	loadedEndings = loadsave.loadTable( "endings.json" )

	composer.setVariable("gameName", "view02_fall_game")
	
	local gametitle = display.newImageRect("image/fall/미니게임 타이틀.png", 687/1.2, 604/1.2)
	gametitle.x, gametitle.y = display.contentWidth/2, display.contentHeight/2

	local gameName = display.newText("떨어지는\n참치캔 받기", 0, 0, "ttf/Galmuri7.ttf", 45)
	gameName.align = "center"
	gameName:setFillColor(0)
	gameName.x, gameName.y=display.contentWidth/2, display.contentHeight*0.65

	
	local background = display.newImageRect("image/fall/background_final.png", display.contentWidth, display.contentHeight)
	background.x, background.y=display.contentWidth/2, display.contentHeight/2
	sceneGroup:insert(background)



	local floor = display.newImage("image/fall/invisible.png")
	floor.x, floor.y = display.contentWidth/2, display.contentHeight*0.95
	floor.name = 'floor'
	physics.addBody(floor, 'static')
	sceneGroup:insert(floor)


	local scorebackground = display.newImageRect("image/fall/score.png", 100, 100)
	scorebackground.x, scorebackground.y = display.contentWidth*0.9-100, display.contentHeight*0.1
	sceneGroup:insert(scorebackground)
	


	local score = 0
	local showScore = display.newText(score, display.contentWidth*0.826, display.contentHeight*0.10)
	showScore:setFillColor(0)
	showScore.size = 30
	sceneGroup:insert(showScore)
	


	local cat = display.newImageRect("image/fall/cat1.png", 150, 150)
	cat.x, cat.y = display.contentWidth*0.4, display.contentHeight*0.8
	physics.addBody(cat, 'static')
	cat.name = 'cat'
	sceneGroup:insert(cat)
	

	local section = display.newRect(display.contentWidth/2, display.contentHeight*0.8, display.contentWidth, display.contentHeight*0.3)
	section:setFillColor(0.35, 0.35, 0.35, 0.35)
	section.alpha=0
	sceneGroup:insert(section)


	local script = display.newText("게임방법\n\n위에서 내려오는 참치캔을 받으세요! 쓰레기를 받게 될 시에는 점수가 깎입니다. \n10점을 달성할 시 게임 클리어 입니다.", section.x+30, section.y-100, native.systemFontBold)
	script.size = 30
	script:setFillColor(1)
	script.x, script.y = display.contentWidth/2, display.contentHeight*0.789
	script.alpha=0
	sceneGroup:insert(script)

	local function stopGame(event)
		physics.start()
	end
	
	timer2=timer.performWithDelay(500, stopGame, 0, "gameTime")

	-----음악
    -- showoverlay 함수 사용 option
    local options = {
        isModal = true
    }

    -- 2023.07.04 edit by jiruen // 샘플 볼륨 bgm
    local volumeBgm = audio.loadStream("soundEffect/263126_설정 클릭시 나오는 효과음(2).wav")

    local volumeButton = display.newImageRect("image/설정/설정.png", 100, 100)
    volumeButton.x,volumeButton.y = display.contentWidth * 0.95, display.contentHeight * 0.12
	sceneGroup:insert(volumeButton)
   	
    --샘플볼륨함수--
    local function setVolume(event)
    	--audio.pause(bgm_play)
    	physics.pause()
    	audio.play(volumeBgm)
        composer.showOverlay( "StopGame", options )
    end
    volumeButton:addEventListener("tap", setVolume)
	

	local musicoption = { 
    	loops = -1
	}

    local home = audio.loadStream( "music/music1.mp3" )
    local tunaCorrect = audio.loadStream( "soundEffect/참치캔_O.mp3" )
    local tunaIncorrect = audio.loadStream( "soundEffect/참치캔_X.mp3" )
    audio.setVolume( loadedEndings.logValue )--loadedEndings.logValue
    audio.play(home, musicoption)


    -------------


	local objects = {"1", "2", "3", "4", "5"}

	local object = { }	
	local i=1
	local objectGroup = display.newGroup()


	local function spawn()
		physics.start()
		local objIdx = math.random(#objects)
		local objName = objects[objIdx]
		object[i]= display.newImageRect(objectGroup,"image/fall/can" .. objName .. ".png", 80, 80)
		object[i].x = display.contentWidth*0.5 + math.random(-490, 490)
		object[i].y = 0
		sceneGroup:insert(object[i])
		if objIdx <4 then
			object[i].type="food"
		else
			object[i].type="trash"
		end
		physics.addBody(object[i])
		object[i].name='object'
		i = i+1
	end

	local function bearmove(event)
		if(event.x < display.contentWidth*0.1) then
			cat.x = display.contentWidth*0.1
		elseif event.x > display.contentWidth*0.9 then
			cat.x = display.contentWidth*0.9
		else
			cat.x = event.x
		end
	end

	local function scriptremove(event)
		timer1=timer.performWithDelay(500, spawn, 0, "gameTime")
		section.alpha=0
		script.alpha=0
		Runtime:addEventListener( "touch", bearmove)
	end	

	local function titleremove(event)
		gametitle.alpha=0
		section.alpha=1
		script.alpha=1
		display.remove(gameName)
		section:addEventListener("tap", scriptremove)
	end

	local function pagemove()
		display.remove(objectGroup)
		display.remove(floor)
		Runtime:removeEventListener("touch", bearmove)
		timer.cancel( timer1 )
		display.remove(cat)
	end

	local function onCollision(e)
		if e.other.name == 'object' then
			if e.other.type == 'food' then
				audio.play( tunaCorrect )
				score = score + 1
				display.remove(e.other)
				showScore.text = score
			else
				audio.play( tunaIncorrect )
				score = score-1
				display.remove(e.other)
				showScore.text=score
			end

			if score<0 then			
				pagemove()
				audio.pause(explosionSound)
				composer.removeScene("view02_fall_game")
				composer.setVariable("score", -1)
				composer.gotoScene("view02_fall_game_over")

			elseif score == 10 then
				pagemove()
				audio.pause(explosionSound)
				composer.removeScene("view02_fall_game")
				composer.setVariable("score", 5)
				composer.gotoScene( "view02_fall_game_over" )
			end
		end
	end

	local function onCollision2(e)
		if e.other.name == 'object' then
			display.remove(e.other)
		end
	end

	gametitle:addEventListener("tap", titleremove)
	cat:addEventListener("collision", onCollision)
	floor:addEventListener("collision", onCollision2)
	


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
