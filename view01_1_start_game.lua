-----------------------------------------------------------------------------------------
--
-- view1.lua
--
-----------------------------------------------------------------------------------------
local loadsave = require( "loadsave" )
local composer = require( "composer" )
local physics = require("physics")
local scene = composer.newScene()
local json = require( "json" ) 


--게임 시작 화면

function scene:create( event )
	local sceneGroup = self.view

	local background = display.newImageRect("image/게임시작/background.png", display.contentWidth, display.contentHeight)
	background.x, background.y = display.contentWidth/2, display.contentHeight/2
	sceneGroup:insert(background)

	local newgame = display.newImageRect("image/게임시작/새게임.png", 200, 80)
    newgame.x,newgame.y = display.contentWidth * 0.5, display.contentHeight * 0.8
    sceneGroup:insert(newgame)


	--샘플 볼륨 이미지
    local volumeButton = display.newImageRect("image/설정/설정.png", 100, 100)
    volumeButton.x,volumeButton.y = display.contentWidth * 0.5, display.contentHeight * 0.5
    sceneGroup:insert(volumeButton)

 	--샘플볼륨함수--
    local function setVolume(event)
        composer.showOverlay( "volumeControl", options1 )
    end
    volumeButton:addEventListener("tap",setVolume)



	-- 엔딩 제이쓴 파일 생성
    local path = system.pathForFile( "ending.json", system.DocumentsDirectory)
 
    local file, errorString = io.open( path, "r" )
    if not file then
        print("make an ending file")
        --엔딩관련 데이터 파일 생성
        local ending = {
            bgMusic = "music/Trust.mp3",
            logValue = "0.5",
            slider = 50
        }
        loadsave.saveTable( ending, "ending.json" )
    end



	loadedEnding = loadsave.loadTable( "ending.json" )


	--마우스 가져다대면 커짐
	local i = 0
    local function bigbig (event)
        if ((event.target.x-event.x)^2 < 13000) and ((event.target.y-event.y)^2<1700) then
            -- i값을 지정해 놓는 이유는 범위 안에서는 크기가 더 늘어나거나 줄어들지 않고, 소리가 연이어 나오지 않음.
            if i == 0 then
               -- local backgroundMusicChannel = audio.play(click1)
                event.target.width = event.target.width*1.1
                event.target.height = event.target.height*1.1
                i = i + 1
            end
        end
        if ((event.x-event.target.x)^2 > 9000) then
            if i == 1 then
                event.target.width = event.target.width/11*10
                event.target.height = event.target.height/11*10
                i = i - 1 
            end
        elseif ((event.target.y-event.y)^2>1100) then
            if i == 1 then
                event.target.width = event.target.width/11*10
                event.target.height = event.target.height/11*10
                i = i - 1 
            end
        end
    end

    
-- newgame 객체 생성 및 openpopup 리스너 추가
    local function openPopup()
        composer.removeScene("view01_1_start_game")
        composer.gotoScene("view01_2_input_name", options1)
    end
    newgame:addEventListener("touch",openPopup)
    newgame:addEventListener("mouse",bigbig)

    -- 화면전환 이펙트
    local options1={
        effect = "fade",
        time = 2000
    }

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