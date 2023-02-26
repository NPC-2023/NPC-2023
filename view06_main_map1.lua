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
    -- 객체 생성
    print("건물 선택 창 / Modal창")


    -- showoverlay 함수 사용 option
    -- local options = {
    --     isModal = true
    -- }
    local target = event.params.targetName
    print(target)



    -- 배경 어둡게
    local black = display.newRect(display.contentWidth/2, display.contentHeight/2,display.contentWidth,display.contentHeight)
    black.alpha = 0.5
    black:setFillColor(0)
    sceneGroup:insert(black)

    local gotoScript = display.newImageRect("image/map/메뉴바.png", 1024/1.5, 1024/1.5)
    gotoScript.x, gotoScript.y = display.contentWidth/2, display.contentHeight/2
    sceneGroup:insert(gotoScript)

    local gotoContentScript = display.newText("".. target .."으로 이동하시겠습니까?", display.contentWidth/2, display.contentHeight/2, native.systemFontBold)
    gotoContentScript.size = 30
    gotoContentScript:setFillColor(0, 0, 0)
    gotoContentScript.x, gotoContentScript.y = display.contentWidth/2, display.contentHeight*0.4
    sceneGroup:insert(gotoContentScript)

    local gotoButton = display.newImageRect("image/map/확인,힌트 버튼.png", 768/4, 768/4)
    gotoButton.x, gotoButton.y = display.contentWidth/2, display.contentHeight*0.6
    sceneGroup:insert(gotoButton)

    local gotoButtonText = display.newText( "확 인", display.contentWidth/2, display.contentHeight*0.59, native.systemFont, 30 )
    gotoButtonText:setFillColor( 1, 1, 1 )  -- black
    sceneGroup:insert(gotoButtonText)

    
    

    -- 확인 버튼을 눌렀을 때 해당 건물의 게임 파일로 이동
    local function gotoChallenge(event)
        
        if(target == "인문관")then
            print("인문관")
            composer.hideOverlay("showGotoCheckMsg")
            composer.gotoScene("view03_climbing_the_tree_game_final")
            return true
        elseif(target == "음악관") then
            composer.hideOverlay("showGotoCheckMsg")
            composer.gotoScene("view01")
            return true
        elseif(target == "대학원")then
            composer.hideOverlay("showGotoCheckMsg")
            composer.gotoScene("view03_climbing_the_tree_game_final")
            return true
        elseif(target == "본관")then
            composer.hideOverlay("showGotoCheckMsg")
            composer.gotoScene("view03_climbing_the_tree_game_final")
            return true
        elseif(target == "정문")then
            composer.hideOverlay("showGotoCheckMsg")
            composer.gotoScene("view03_climbing_the_tree_game_final")
            return true
        elseif(target == "백주년")then
            composer.hideOverlay("showGotoCheckMsg")
            composer.gotoScene("view03_climbing_the_tree_game_final")
            return true
        elseif(target == "학생관")then
            composer.hideOverlay("showGotoCheckMsg")
            composer.gotoScene("view01")
            return true
        end
    end

    gotoButton:addEventListener("tap", gotoChallenge)

    -- exit 버튼 눌렀을 때 volumeControl.lua파일에서 벗어나기
    local function goback(event)
        -- if event.phase == "began" then
        --     composer.hideOverlay("showGotoCheckMsg")
        -- end
        composer.hideOverlay("view06_main_map1")
    end

    -- exit 버튼 생성 및 버튼에 이벤트 리스너 추가
    local exit = display.newImageRect("image/설정/닫기.png", 768/6, 768/6)
    sceneGroup:insert(exit)
    exit.x, exit.y = display.contentWidth*0.7, display.contentHeight*0.3
    exit:addEventListener("tap",goback)
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