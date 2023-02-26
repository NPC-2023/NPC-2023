-----------------------------------------------------------------------------------------
--
-- showGotoCheckMsg.lua -> 맵 클릭시 000으로 이동하시겠습니까? 화면 보여주기 및 게임으로 이동
--
-----------------------------------------------------------------------------------------

-- local loadsave = require( "loadsave" )
local composer = require( "composer" )
local scene = composer.newScene()
local json = require( "json" )  

function scene:create( event )
    local sceneGroup = self.view
    -- 객체 생성
    print("건물 선택 창 / Modal창")


    -- showoverlay 함수 사용 option
    -- local options = {
    --     isModal = true
    -- }
    local target = event.params.targetName
    print(target)

    -- local widget = require ("widget")

    --로드
    -- local loadedEndings = loadsave.loadTable( "endings.json" )
    -- music = loadedEndings.bgMusic

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

    
    -- local settings = {}
    -- settings["fxvolume"] = 0.5
    -- settings["bgvolume"] = 0.5
    
    -- Audio setup
    -- audio.reserveChannels(1)
    -- local backgroundSound = audio.loadStream(music)

    -- local bgImage = display.newImageRect("image/volume/창.png", 600, 600)
    -- bgImage.x = display.contentWidth / 2; 
    -- bgImage.y = display.contentHeight  *0.6; 
    -- sceneGroup:insert(bgImage)
    
    -- local text = "배경음"
    -- local showtext = display.newText(text, display.contentWidth*0.37, display.contentHeight*0.515)
    -- showtext:setFillColor(0)
    -- showtext.size = 30
    -- sceneGroup:insert(showtext)


    -- 볼륨리스너  
    -- local function bgSliderListener( event )
    --     local sliderValue = event.value
    --     loadedEndings.slider = sliderValue
    --     local logValue
    --     if sliderValue == nil then sliderValue = 0 end
    --     if (sliderValue > 0) then
    --         logValue = (math.pow(3,sliderValue/100)-1)/(3-1)
    --     else
    --         logValue = 0.0
    --     end
    --     settings["bgvolume"] = logValue
    --     loadedEndings.logValue = logValue
    --     loadsave.saveTable(loadedEndings,"endings.json")
    --     audio.setVolume( settings["bgvolume"]  )
    -- end

    -- local background_image = display.newImageRect("image/volume/소리조절칸.png", 325, 70)
    -- background_image.x, background_image.y = display.contentWidth*0.38 + 210,display.contentHeight*0.53
    -- sceneGroup:insert(background_image)

    -- local options = {
    -- frames = {
    --     { x=0, y=0, width=41, height=41 },
    --     { x=41, y=0, width=41, height=41 },
    --     { x=82, y=0, width=41, height=41 },
    --     { x=123, y=0, width=41, height=41 },
    --     { x=164, y=0, width=41, height=41 }
    -- },
    -- sheetContentWidth = 205,
    -- sheetContentHeight = 41
    -- }

    -- local sliderSheet = graphics.newImageSheet( "image/volume/sound1.png", options )
    
    -- 볼륨슬라이더
    -- local bgSlider = widget.newSlider{
    --     sheet = sliderSheet,
    --     leftFrame = 1,
    --     middleFrame = 2,
    --     rightFrame = 3,
    --     fillFrame = 4,
    --     frameWidth = 41,
    --     frameHeight = 41,
    --     handleFrame = 5,
    --     handleWidth = 41,
    --     handleHeight = 41,
    --     top = 380,    x = display.contentCenterX*0.78 + 190,      
    --     width=380,  y=display.contentCenterY*1.04,      
    --     value=loadedEndings.slider,
    --     listener = bgSliderListener
    -- }
    -- sceneGroup:insert( bgSlider )

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
        composer.hideOverlay("showGotoCheckMsg")
    end

    -- exit 버튼 생성 및 버튼에 이벤트 리스너 추가
    local exit = display.newImageRect("image/map/취소버튼.png", 768/6, 768/6)
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