-----------------------------------------------------------------------------------------
--
-- cafeteria.lua
--
-----------------------------------------------------------------------------------------

local loadsave = require( "loadsave" )
local json = require( "json" )
local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

	local loadedEndings = loadsave.loadTable( "endings.json" )
	local loadedSettings = loadsave.loadTable( "settings.json" )

	composer.setVariable("gameName", "view20_moneyGame")

	local gametitle = display.newImageRect("image/fall/미니게임 타이틀.png", 687/1.2, 604/1.2)
	gametitle.x, gametitle.y = display.contentCenterX, display.contentCenterY

	local gameName = display.newText("간식 사기", 0, 0, "ttf/Galmuri7.ttf", 45)
	gameName.align = "center"
	gameName:setFillColor(0)
	gameName.x, gameName.y=display.contentWidth/2, display.contentHeight*0.65

	local section = display.newRect(display.contentWidth/2, display.contentHeight*0.8, display.contentWidth*4, display.contentHeight*0.9)
	section:setFillColor(0.35, 0.35, 0.35, 0.35)
	section.alpha=0
	sceneGroup:insert(section)


	local script = display.newText("게임방법\n\n주어진 금액에 맞춰 간식을 사세요.", section.x+30, section.y-100, native.systemFontBold)
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
		gameName.alpha=0
		section.alpha=1
		script.alpha=1
		display.remove(gameName)
		section:addEventListener("tap", scriptremove)
	end


	local background = display.newImageRect("image/cafeteria/store.png", 960, 640)
	background.x = display.contentCenterX
    background.y = display.contentCenterY

 	local object = {}

	object[1] = display.newImageRect("image/cafeteria/snack1.png", 100, 100)
 	object[2] = display.newImageRect("image/cafeteria/snack2.png", 100, 100)
 	object[3] = display.newImageRect("image/cafeteria/bread1.png", 100, 100)
 	object[4] = display.newImageRect("image/cafeteria/bread2.png", 100, 100)
 	object[5] = display.newImageRect("image/cafeteria/drink1.png", 100, 100)
 	object[6] = display.newImageRect("image/cafeteria/drink2.png", 100, 100)

	local objectGroup = display.newGroup()

	local money = {"1000", "1000", "2000", "2500", "1500", "1000"}

	for i = 1, 3 do
		object[i].x, object[i].y = display.contentWidth*0.1*i*i, display.contentHeight*0.3
		object[i].money = money[i]
 		objectGroup:insert(object[i])
 	end

	for i = 4, 6 do
		object[i].x, object[i].y = display.contentWidth*0.1*(i-3)*(i-3), display.contentHeight*0.6
		object[i].money = money[i]
 		objectGroup:insert(object[i])
 	end

 	local money = {"1000", "1000", "2000", "2500", "1500", "1000"}
 	local script = {}

 	for i = 1, 6 do
 		script[i] = display.newText(money[i], object[i].x, object[i].y+90, "font/DOSGothic.ttf")
		script[i].size = 45
		script[i]:setFillColor(1)
		objectGroup:insert(script[i])
	end

	local totalScript = display.newText("0", display.contentWidth/2, display.contentHeight*0.1, "font/DOSGothic.ttf")
	totalScript.size = 50
	totalScript:setFillColor(1)

	local total = 0
	local function tapEventListener( event )
		total = total + tonumber(event.target.money)
		totalScript.text = total
		local soundEffect = audio.loadSound( "soundEffect/coin.wav" )
		audio.play( soundEffect )
	end

	local errand = composer.getVariable("money")

	local reset = display.newText("reset", display.contentWidth*0.1, display.contentHeight*0.1, "font/DOSGothic.ttf")
	reset.size = 50
	reset:setFillColor(1)

	local buy = display.newText("계산하기", display.contentWidth*0.5, display.contentHeight*0.9, "font/DOSGothic.ttf", 50)
	buy:setFillColor(1)

 	local home = audio.loadStream( "music/music14.wav" )
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

    -- 2023.07.04 edit by jiruen // 샘플 볼륨 bgm
    local volumeBgm = audio.loadStream("soundEffect/263126_설정 클릭시 나오는 효과음(2).wav")

    --샘플볼륨함수--
    local function setVolume(event)
    	audio.play(volumeBgm)
        composer.showOverlay( "StopGame", options )
    end
    volumeButton:addEventListener("tap", setVolume)

	local function resetTotalListener( event )
		totalScript.text = "0"
		total = 0
	end

	local function pagemove()
		display.remove(objectGroup)
		-- display.remove(floor)
		-- Runtime:removeEventListener("touch", bearmove)
		-- timer.cancel( timer1 )
		-- display.remove(cat)
	end

	local text = ""
	local function buyListener( event )
		local soundEffect = audio.loadSound( "soundEffect/coin.8.ogg" )
		audio.play( soundEffect )

		if(total == errand) then
			-- text = display.newText("성공 !", display.contentWidth*0.5, display.contentHeight*0.85, "font/DOSGothic.ttf", 80)
			-- text:setFillColor(1)
			buy.alpha = 0
			-- objectGroup:insert(text)

			timer.performWithDelay( 1000, function() 
				pagemove()
				audio.pause(home)
				loadedSettings.money = loadedSettings.money + 3
				loadedSettings.total_success = loadedSettings.total_success + 1
				loadedSettings.total_success_names[loadedSettings.total_success] = "매점에서 간식 사기"
				loadsave.saveTable(loadedSettings,"settings.json")


				composer.setVariable("moneygame_status", "success")
				composer.removeScene("view20_moneyGame")
				composer.gotoScene("view20_moneyGame_over")
			end)
		else
			text = display.newText("실패다냥", display.contentWidth*0.5, display.contentHeight*0.85, "font/DOSGothic.ttf", 80)
			text:setFillColor(1)
			objectGroup:insert(text)
		end
		
		timer.performWithDelay( 1500, function() 
			-- text.alpha = 0
		end )	
	end
	
	for i = 1, 6 do
		object[i]:addEventListener("tap", tapEventListener)
	end

	gametitle:addEventListener("tap", titleremove)
	reset:addEventListener("tap", resetTotalListener)
	buy:addEventListener("tap", buyListener)

	objectGroup:insert(totalScript)
	objectGroup:insert(reset)
	objectGroup:insert(buy)

	sceneGroup:insert(background)
 	sceneGroup:insert(objectGroup)
 	sceneGroup:insert(volumeButton)
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