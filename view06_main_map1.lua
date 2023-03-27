-----------------------------------------------------------------------------------------
--
-- showGotoCheckMsg.lua -> 맵 클릭시 000으로 이동하시겠습니까? 화면 보여주기 및 게임으로 이동
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
    local widget = require ("widget")
    -- 객체 생성
    print("건물 선택 창 / Modal창")


    -- showoverlay 함수 사용 option
    -- local options = {
    --     isModal = true
    -- }

    name = composer.getVariable("name")

    print(name)


  -- 배경 어둡게
    local black = display.newRect(display.contentWidth/2,display.contentHeight/2,display.contentWidth,display.contentHeight)
    black.alpha = 0.9
    black:setFillColor(0)
    sceneGroup:insert(black)
    

    local gotoScript = display.newImageRect("image/설정/창.png", 700, 700)
    gotoScript.x, gotoScript.y = display.contentWidth/2, display.contentHeight*0.6
    sceneGroup:insert(gotoScript)

    local gotoContentScript = display.newText(name.."으로 이동하시겠습니까?", display.contentWidth/2, display.contentHeight/2, native.systemFontBold)
    gotoContentScript.size = 42
    gotoContentScript:setFillColor(0, 0, 0)
    gotoContentScript.x, gotoContentScript.y = display.contentWidth/2, display.contentHeight*0.4 +50
    sceneGroup:insert(gotoContentScript)

    local gotoButton = display.newImageRect("image/설정/확인,힌트 버튼.png", 768/4, 768/4)
    gotoButton.x, gotoButton.y = display.contentWidth/2, display.contentHeight*0.66
    sceneGroup:insert(gotoButton)

    local gotoButtonText = display.newText( "확 인", display.contentWidth/2, display.contentHeight*0.65, native.systemFont, 40 )
    gotoButtonText:setFillColor( 1, 1, 1 )  -- black
    sceneGroup:insert(gotoButtonText)


    -- 확인 버튼을 눌렀을 때 해당 건물의 게임 파일로 이동
    local function gotoChallenge(event)
        if event.phase == "began" then
            if(name == "인문관")then
                print("인문관")
                composer.removeScene("view06_main_map1")
                composer.gotoScene("view02_npc_fallgame")
                return true
            elseif(name == "음악관") then
                print("음악관")
                composer.removeScene("view06_main_map1")
                composer.gotoScene("view07_npc_schoolfood_game")
                return true
            elseif(name == "예지관")then
                print("예지관")
                composer.removeScene("view06_main_map1")
                composer.gotoScene("view10_pre_lost_stuId_game")
                return true
            elseif(name == "대학원")then
                print("대학원")
                composer.removeScene("view06_main_map1")
                if(math.random(1, 2) == 1) then
                    composer.gotoScene("view20_npc_moneyGame")
                else
                    composer.gotoScene("view03_npc_jump_game")
                end
                return true
            elseif(name == "본관")then
                print("본관")
                composer.removeScene("view06_main_map1")
                composer.gotoScene("view21_npc_fishGame")
                return true
            elseif(name == "정문")then
                print("정문")
                composer.removeScene("view06_main_map1")
                composer.gotoScene("view18_npc_frontgate_game")
                return true
            elseif(name == "백주년")then
                print("백주년")
                composer.removeScene("view06_main_map1")
                composer.gotoScene("view13_pre_climbingTree")
                return true
            elseif(name == "학생관")then
                print("학생관")
                composer.removeScene("view06_main_map1")
                composer.gotoScene("view02_npc_pickGame")
                return true
            end
        end
    end

    gotoButton:addEventListener("touch", gotoChallenge)

    -- exit 버튼 눌렀을 때 volumeControl.lua파일에서 벗어나기
    local function goback(event)
        -- if event.phase == "began" then
        --     composer.hideOverlay("showGotoCheckMsg")
        -- end
        --composer.hideOverlay("view06_main_map1")
        if event.phase == "began" then
            composer.removeScene("view06_main_map1")
            composer.gotoScene("view05_main_map")
            --composer.hideOverlay("view06_main_map1")
        end
    end

    loadsave.saveTable(loadedSettings,"settings.json")

    -- exit 버튼 생성 및 버튼에 이벤트 리스너 추가
    local exit = display.newImageRect("image/설정/닫기.png", 50, 50)

    exit.x, exit.y = display.contentWidth*0.7, display.contentHeight*0.37
    exit:addEventListener("touch",goback)
    sceneGroup:insert(exit)

--[[
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
    volumeButton:addEventListener("tap",setVolume)]]

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
        composer.removeScene("view06_main_map1")
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