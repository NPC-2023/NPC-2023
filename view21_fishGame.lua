local composer = require("composer")
local scene = composer.newScene()
local loadsave = require( "loadsave" )

function scene:create( event )
	local sceneGroup = self.view

	local loadedEndings = loadsave.loadTable( "endings.json" )
	local loadedSettings = loadsave.loadTable( "settings.json" )

	composer.setVariable("gameName", "view21_fishGame")

	local background = display.newImageRect("image/fishing/mainbd_back.png", display.contentWidth, display.contentHeight)
 	background.x, background.y = display.contentWidth/2, display.contentHeight/2

 	local gametitle = display.newImageRect("image/fall/미니게임 타이틀.png", 687/1.2, 604/1.2)
	gametitle.x, gametitle.y = display.contentWidth/2, display.contentHeight/2

	local gameName = display.newText("물고기 사냥", 0, 0, "ttf/Galmuri7.ttf", 45)
	gameName.align = "center"
	gameName:setFillColor(0)
	gameName.x, gameName.y=display.contentWidth/2, display.contentHeight*0.65
	
	local section = display.newRect(display.contentWidth/2, display.contentHeight*0.8, display.contentWidth, display.contentHeight*0.3)
	section:setFillColor(0.35, 0.35, 0.35, 0.35)
	section.alpha=0
	sceneGroup:insert(section)

	local script = display.newText("게임방법\n\n도망다니는 물고기를 모두 잡으세요!", section.x+30, section.y-100, "font/DOSGothic.ttf", 80)
	script.size = 30
	script:setFillColor(1)
	script.x, script.y = display.contentWidth/2, display.contentHeight*0.789
	script.alpha=0
	sceneGroup:insert(script)


	local function scriptremove(event)
		-- timer1=timer.performWithDelay(500, spawn, 0, "gameTime")
		section.alpha=0
		script.alpha=0
		-- Runtime:addEventListener( "touch", bearmove)
	end	

	local function titleremove(event)
		gametitle.alpha=0
		section.alpha=1
		script.alpha=1
		display.remove(gameName)
		section:addEventListener("tap", scriptremove)
	end

 	local fish = {}

 	fish[1] = display.newImageRect("image/fishing/fish1.png", 80, 80)
	fish[1].x, fish[1].y = display.contentWidth*0.8, display.contentHeight*0.9
	fish[2] = display.newImageRect("image/fishing/fish2.png", 80, 80)
	fish[2].x, fish[2].y = display.contentWidth*0.3, display.contentHeight*0.9
	fish[3] = display.newImageRect("image/fishing/fish3.png", 50, 50)
	fish[3].x, fish[3].y = display.contentWidth*0.85, display.contentHeight*0.4
	fish[4] = display.newImageRect("image/fishing/fish4.png", 80, 80)
	fish[4].x, fish[4].y = display.contentWidth*0.5, display.contentHeight*0.9

	-- code minimize
	for i = 1, 4 do
		fish[i].name = "fish"..i 
		fish[i].alpha = 0.7
	end

	local cat = display.newImageRect("image/fishing/fishingCat.png", 200, 200)
 	cat.x, cat.y = display.contentWidth*0.3, display.contentHeight*0.7

 	local splash = display.newImageRect("image/fishing/splash.png", 120, 120)
 	splash.alpha = 0

	local objectGroup = display.newGroup()

 	local home = audio.loadStream( "music/music15.mp3" )
    audio.setVolume( loadedEndings.logValue )--loadedEndings.logValue

    local musicOption = { 
    	loops = -1
	}
	
	audio.play(home, musicOption)
	
	local volumeButton = display.newImageRect("image/설정/설정.png", 100, 100)
    volumeButton.x,volumeButton.y = display.contentWidth * 0.91, display.contentHeight * 0.1
   	
   	local options = {
        isModal = true
    }
    --샘플볼륨함수--
    local function setVolume(event)
    	--audio.pause(bgm_play)
        composer.showOverlay( "StopGame", options )
    end
    volumeButton:addEventListener("tap", setVolume)

	local function scriptremove(event)
		timer1=timer.performWithDelay(500, 0)
		section.alpha=0
		script.alpha=0
	end	

	local function titleremove(event)
		gametitle.alpha=0
		section.alpha=1
		script.alpha=1
		section:addEventListener("tap", scriptremove)
	end

	local function pagemove()
		display.remove(objectGroup)
		-- display.remove(floor)
		-- Runtime:removeEventListener("touch", bearmove)
		-- timer.cancel( timer1 )
		display.remove(cat)
	end


	local fish1_cnt, fish2_cnt, fish3_cnt, fish4_cnt = 0, 0, 0, 0

	local total_cnt = 0

	local lightsplash = audio.loadSound( "soundEffect/splash1.wav" )

	local function tapEventListener( event )
			audio.play( lightsplash )
 			ranX = math.random(10, 30) / 100
 			ranY = math.random(5, 15) / 100
 			local tag = 0
 			-- 랜덤으로 배경 기준 고정위치에서 계속 변환
 			if(event.target.name == 'fish1') then
 				cat.xScale = 1
				event.target.x = display.contentWidth*(0.5+ranX)
				event.target.y = display.contentHeight*(0.8+ranY)
				cat.y = display.contentHeight*0.7
				fish1_cnt = fish1_cnt + 1
				--어획시 커지고 살짝 위로 뜬 후 1.5초 있다 삭제
				if(fish1_cnt == 3) then
					tag = 1			
				end
			elseif(event.target.name == 'fish2') then
				cat.xScale = -1
				event.target.x = display.contentWidth*(0.2+ranX)
				event.target.y = display.contentHeight*(0.8+ranY)
				cat.y = display.contentHeight*0.7
				fish2_cnt = fish2_cnt + 1
				if(fish2_cnt == 4) then
					tag = 2
				end
			elseif(event.target.name == 'fish4') then
				cat.xScale = 1
				event.target.x = display.contentWidth*(0.2+ranX)
				event.target.y = display.contentHeight*(0.8+ranY)
				cat.y = display.contentHeight*0.7
				fish4_cnt = fish4_cnt + 1
				if(fish4_cnt == 4) then
					tag = 4
				end
			else
				cat.xScale = -1
				event.target.x = display.contentWidth*(0.8+(ranX/4.5))
				event.target.y = display.contentHeight*(0.4+(ranY/3))
				cat.y = display.contentHeight*0.25
				fish3_cnt = fish3_cnt + 1
				if(fish3_cnt == 3) then
					tag = 3
				end
			end
			--물고기 클릭시 고양이 위치가 같이 움직임
			cat.x = event.target.x
			if(tag ~= 0) then
					local strongsplash = audio.loadSound( "soundEffect/splash2.wav" )
					audio.play(strongsplash)
					splash.x, splash.y = event.target.x, event.target.y	
					splash.alpha = 1
					fish[tag].alpha = 1
					fish[tag]:scale(1.5, 1.5) 
					event.target.y = event.target.y + 10
					timer.performWithDelay( 1500, function() 
						event.target.x = display.contentWidth*(tag * 0.1)
						event.target.y = display.contentHeight*0.1 
						splash.alpha = 0
						total_cnt = total_cnt + 1	
						--물고기 다 잡은 경우										
						if(total_cnt == 4) then
							-- local text = display.newText("성공이다냥 !", display.contentWidth*0.5, display.contentHeight*0.85, "font/DOSGothic.ttf", 80)
							-- text:setFillColor(0)
							
							loadedSettings.money = loadedSettings.money + 3
							-- 2023.06.30 edit by jiruen // total_success_names에 추가 및 fishgame_status 변수 넘겨주기
							loadedSettings.total_success = loadedSettings.total_success + 1
							loadedSettings.total_success_names[loadedSettings.total_success] = "물고기 사냥"
							loadsave.saveTable(loadedSettings,"settings.json")
							composer.setVariable("fishgame_status", "success")

							timer.performWithDelay( 1000, function() 
								pagemove()
								audio.pause(home)
								text.alpha = 0
								gametitle.alpha = 0
								
								
								composer.removeScene("view21_fishGame")
								composer.gotoScene("view21_fishGame_over")
							end )
						end	
					end )				
			end
	end	

	objectGroup:insert(fish[1])
	objectGroup:insert(fish[2])
	objectGroup:insert(fish[3])
	objectGroup:insert(fish[4])
	objectGroup:insert(cat)
	objectGroup:insert(splash)
	objectGroup:insert(section)
	objectGroup:insert(script)

	sceneGroup:insert(background)
	sceneGroup:insert(objectGroup)
	sceneGroup:insert(volumeButton)

	gametitle:addEventListener("tap", titleremove)
	fish[1]:addEventListener("tap", tapEventListener)		
	fish[2]:addEventListener("tap", tapEventListener)	
	fish[3]:addEventListener("tap", tapEventListener)	  
	fish[4]:addEventListener("tap", tapEventListener)
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	--다른 장면으로 갔다가 돌아올때 실행 timer, sound 등
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then


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

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )	

return scene