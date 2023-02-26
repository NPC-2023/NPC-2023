-----------------------------------------------------------------------------------------
--
-- View01_bear.lua
--
-----------------------------------------------------------------------------------------
local loadsave = require( "loadsave" )
local composer = require( "composer" )
local physics = require("physics")
local scene = composer.newScene()
local json = require( "json" ) 


function scene:create( event )
	local sceneGroup = self.view
	
	local loadedSettings = loadsave.loadTable( "settings.json" )
    local loadedEndings = loadsave.loadTable( "endings.json" )


	local background = display.newImageRect("image/지도/background.png", display.contentWidth, display.contentHeight)
	background.x, background.y=display.contentWidth/2, display.contentHeight/2
	sceneGroup:insert(background)
	
	local foundation1 = display.newImageRect("image/게임시작/새게임.png", 200, 80)
    foundation1.x,foundation1.y = display.contentWidth * 0.1, display.contentHeight * 0.8
    foundation1.name = "1"
    sceneGroup:insert(foundation1)

    local foundation2 = display.newImageRect("image/게임시작/새게임.png", 200, 80)
    foundation2.x,foundation2.y = display.contentWidth * 0.3, display.contentHeight * 0.8
    foundation2.name = "2"
    sceneGroup:insert(foundation2)

    local foundation3 = display.newImageRect("image/게임시작/새게임.png", 200, 80)
    foundation3.x,foundation3.y = display.contentWidth * 0.5, display.contentHeight * 0.8
    foundation3.name = "3"
    sceneGroup:insert(foundation3)

    local foundation4 = display.newImageRect("image/게임시작/새게임.png", 200, 80)
    foundation4.x,foundation4.y = display.contentWidth * 0.7, display.contentHeight * 0.8
    foundation4.name = "4"
    sceneGroup:insert(foundation4)


	
	


-- 마을 맵 마을 객체 생성.
	local click1 = audio.loadStream( "music/스침.wav" )
	
-- 마을 객체 커서 범위 설정. 범위 밖으로 나가면 마을 크기 작아지고 안으로 들어가면 마을 크기 커짐.
	local i = 0
	local function bigbig (event)
		
		if (event.target.x-event.x)^2 + (event.target.y-event.y)^2 < 110^2 then
			-- i값을 지정해 놓는 이유는 범위 안에서는 크기가 더 늘어나거나 줄어들지 않고, 소리가 연이어 나오지 않음.
			if i == 0 then
				local backgroundMusicChannel = audio.play(click1)
				event.target.width = event.target.width*1.1
				event.target.height = event.target.height*1.1
				i = i + 1
			end
		
		elseif (event.target.x-event.x)^2 + (event.target.y-event.y)^2 > 110^2 then
			if i == 1 then
				event.target.width =event.target.width/11*10
				event.target.height =event.target.height/11*10
				i = i - 1 
			end
			
		end
	end

	local color = 0

	
-- 리스너 함수 생성
	local function touch_ui (event)
		if event.phase == "began" then
			color = event.target.name

			if color == "1" then
				local click01 = audio.play(click1)
				local home = audio.loadStream( "music/Trust.mp3" )
				audio.setVolume( loadedEndings.logValue )
				audio.play(home)
				loadedEndings.bgMusic = "music/Trust.mp3"
        		loadsave.saveTable(loadedEndings,"endings.json")
				composer.removeScene("view05_main_map")
				composer.gotoScene( "view02_fall_game" )

			elseif color == "2" then
				local click01 = audio.play(click1)
				local storeMusic = audio.loadStream( "music/Trust.mp3" )
				audio.setVolume( loadedEndings.logValue )
				audio.play(storeMusic);
				loadedEndings.bgMusic = "music/Trust.mp3"
        		loadsave.saveTable(loadedEndings,"endings.json")
				composer.removeScene("view05_main_map")
				composer.gotoScene( "view03_mouse_game" )

			elseif color == "8" then
				local click01 = audio.play(click1)
				local storeMusic = audio.loadStream( "music/Trust.mp3" )
				audio.setVolume( loadedEndings.logValue )
				audio.play(storeMusic);
				loadedEndings.bgMusic = "music/Trust.mp3"
        		loadsave.saveTable(loadedEndings,"endings.json")
				composer.removeScene("view1Map")
				composer.gotoScene( "view04Deco" )

			else
				local click01 = audio.play(click1)
				composer.setVariable("color", color)
				composer.removeScene("view1Map")
				composer.gotoScene("view02Map")

			end
		end
	end

-- 리스너 추가
	foundation1:addEventListener("mouse",bigbig)
	foundation2:addEventListener("mouse",bigbig)
	foundation3:addEventListener("mouse",bigbig)
	foundation4:addEventListener("mouse",bigbig)

	foundation1:addEventListener("touch",touch_ui)
	foundation2:addEventListener("touch",touch_ui)
	foundation3:addEventListener("touch",touch_ui)
	foundation4:addEventListener("touch",touch_ui)









	-- showoverlay 함수 사용 option
    local options = {
        isModal = true
    }
    
	--샘플 볼륨 이미지
    -----음악

    -- showoverlay 함수 사용 option
    local options = {
        isModal = true
    }

    --샘플 볼륨 이미지
    local volumeButton = display.newImageRect("image/설정/설정.png", 100, 100)
    volumeButton.x,volumeButton.y = display.contentWidth * 0.91, display.contentHeight * 0.4
    
    sceneGroup:insert(volumeButton)


    --샘플볼륨함수--
    local function setVolume(event)
        composer.showOverlay( "volumeControl", options )
    end
    volumeButton:addEventListener("tap",setVolume)

    --[[local home = audio.loadStream( "음악/음악샘플.mp3" )
    audio.setVolume( loadedEnding.logValue )--loadedEndings.logValue
    audio.play(home)
]]



 

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
		composer.removeScene("stage01")
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