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

	local background = display.newImageRect("image/게임시작/background.png", display.contentWidth*3, display.contentHeight)
	background.x = display.contentCenterX
    background.y = display.contentCenterY
	sceneGroup:insert(background)

	local newgame = display.newImageRect("image/게임시작/새로시작.png", display.contentWidth/2, display.contentHeight/7)
    newgame.name ="new"
    newgame.x,newgame.y = display.contentCenterX * 0.4, display.contentCenterY * 1.83
    sceneGroup:insert(newgame)

    local loadgame = display.newImageRect("image/게임시작/이어하기.png", display.contentWidth/2, display.contentHeight/7)
    loadgame.name ="load"
    loadgame.x,loadgame.y = newgame.x+170, newgame.y
    sceneGroup:insert(loadgame)

    -- 2023.06.30 edit by jiruen // 시작하기, 이어하기 버튼 클릭 시 bgm 
    local newBtnBgm = audio.loadStream( "soundEffect/619832_시작하기 클릭 시 효과음.wav" )
    local loadBtnBgm = audio.loadStream( "soundEffect/528862_이어하기 클릭 시 효과음(2).wav" )


	-- 엔딩 제이쓴 파일 생성
    local path = system.pathForFile( "endings.json", system.DocumentsDirectory)
 
    local file, errorString = io.open( path, "r" )
    if not file then
        print("make an ending file")
        --엔딩관련 데이터 파일 생성
        local endings = {
            end_num = 0,
            bgMusic = "music/Trust.mp3",
            logValue = "0.5",
            slider = 50,
            logValue_effect = "0.5",
            slider_effect = 50
        }
        loadsave.saveTable( endings, "endings.json" )
    end



    loadedEndings = loadsave.loadTable( "endings.json" )



    --마우스 가져다대면 커짐
    local i = 0
    local function bigbig (event)
        if ((event.target.x-event.x)^2 < 13000) and ((event.target.y-event.y)^2<1700) then
            -- i값을 지정해 놓는 이유는 범위 안에서는 크기가 더 늘어나거나 줄어들지 않고, 소리가 연이어 나오지 않음.
            if i == 0 then
                -- 2023.06.30 edit by jiruen // 시작하기, 이어하기 버튼 클릭 시 bgm 추가
                if (event.target.name == "new") then
                    audio.play(newBtnBgm)
                else
                    audio.play(loadBtnBgm)
                end
                -- local backgroundMusicChannel = audio.play(newBtnBgm)
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



    --샘플 볼륨 이미지
    --volumeButton:addEventListener("mouse",bigbig)
    local volumeButton = display.newImageRect("image/설정/설정.png", display.contentWidth/5, display.contentHeight/8)
    volumeButton.x,volumeButton.y = display.contentCenterX*3.7, display.contentCenterY*0.2
    sceneGroup:insert(volumeButton)

    -- 2023.06.30 edit by jiruen // 샘플 볼륨 bgm
    local volumeBgm = audio.loadStream("soundEffect/263126_설정 클릭시 나오는 효과음(2).wav")

    local function volumeButtonBgm (event)
        if event.phase == "began" then
            audio.play(volumeBgm)
        end
    end

    --샘플볼륨함수--
    local function setVolume(event)
        composer.showOverlay( "volumeControl", options1 )
    end
    volumeButton:addEventListener("tap",setVolume)
    volumeButton:addEventListener("touch",volumeButtonBgm)
    --[[audio.pause( titleMusic )
    local home = audio.loadStream( "music/Trust.mp3" )
    audio.setVolume( loadedEnding.logValue )--loadedEndings.logValue
    audio.play(home)]]


-- 화면전환 이펙트
    local options1={
        --effect = "fade",
        --time = 2000
        isModal = true
    }
    
-- newgame 객체 생성 및 openpopup 리스너 추가
    local function openPopup()
        composer.removeScene("view01_1_start_game")
        composer.gotoScene("view01_2_input_name", options1)
    end
    newgame:addEventListener("touch",openPopup)
    newgame:addEventListener("mouse",bigbig)

    


    local function startLoad(event)
            --세이브 파일 불러오기--
            -- Path for the file to read
            local path = system.pathForFile( "settings.json", system.DocumentsDirectory)
 
            -- Open the file handle
            local file, errorString = io.open( path, "r" )
 
            if not file then --or (loadedEndings.end_num==1) then
                composer.showOverlay( "nosave", options )
            else
                -- ,options1
                audio.pause( titleMusic )
              --local home = audio.loadStream( "music/Trust.mp3" )
              --audio.setVolume( loadedEndings.logValue )
               --audio.play(home)
                composer.removeScene("view01_1_start_game")
                composer.gotoScene( "view05_main_map")
            end
    end
    loadgame:addEventListener("touch",startLoad)
    loadgame:addEventListener("mouse",bigbig)




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