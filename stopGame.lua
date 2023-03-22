local composer = require( "composer" )
local physics = require("physics")
local scene = composer.newScene()
local loadsave = require( "loadsave" )
local json = require( "json" ) 

function scene:create( event )
    local sceneGroup = self.view
    -- 객체 생성

    -- showoverlay 함수 사용 option
    local options = {
        isModal = true
    }
    local widget = require ("widget")

    --로드
    local loadedEndings = loadsave.loadTable( "endings.json" )
   -- music = loadedEndings.bgMusic

    -- 배경 어둡게
    local black = display.newRect(display.contentWidth/2,display.contentHeight/2,display.contentWidth,display.contentHeight)
    black.alpha = 0.5
    black:setFillColor(0)
    sceneGroup:insert(black)
  
    local stopText = display.newText("일시정지", display.contentWidth/2, display.contentHeight*0.3, native.systemFontBold, 50)
    stopText:setFillColor(1, 1, 0)
    sceneGroup:insert(stopText)
    local continueButton = display.newImageRect("image/button.png", 400, 300)  --버튼이미지 디자인 요청해서 수정 예정입니다
    continueButton.x, continueButton.y = display.contentWidth/2, display.contentHeight*0.45
    sceneGroup:insert(continueButton)
    local continueText = display.newText("계속하기", display.contentWidth/2, display.contentHeight*0.43, native.systemFontBold, 40)
    continueText:setFillColor(0, 0, 0)
    sceneGroup:insert(continueText)
    local closeButton = display.newImageRect("image/button.png", 400, 300)
    closeButton.x, closeButton.y = display.contentWidth/2, display.contentHeight*0.6
    sceneGroup:insert(closeButton)
    local closeText = display.newText("그만하기", display.contentWidth/2, display.contentHeight*0.58, native.systemFontBold, 40)
    closeText:setFillColor(0, 0, 0)
    sceneGroup:insert(closeText)

    --게임 타이머 설정--
    timer.pause("gameTime") --게임 전체 타이머
    timer.pause("generateTime") --pickGame에서 물건 생성하는 타이머
    timer.pause("removeTime") --pickGame에서 물건 없애는 타이머
    
    local function continueGame(event)
        timer.resume("gameTime")
        timer.resume("generateTime")
        timer.resume("removeTime")
        composer.removeScene("stopGame")
        composer.gotoScene("view02_pick_game")
    end

    local function closeGame(event)
        composer.removeScene("view02_pick_game")
        composer.gotoScene("view05_main_map")
    end

    continueText:addEventListener("tap", continueGame)
    closeText:addEventListener("tap", closeGame)

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