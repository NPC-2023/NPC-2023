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
    music = loadedEndings.bgMusic

    -- 배경 어둡게
    local black = display.newRect(display.contentCenterX,display.contentCenterY,display.contentCenterX,display.contentCenterY)
    black.alpha = 0.5
    black:setFillColor(0)
    sceneGroup:insert(black)
    

    local bgImage = display.newImageRect("image/volume/창.png", 500, 500)
    bgImage.x = display.contentCenterX
    bgImage.y = display.contentCenterY*1.2; 
    sceneGroup:insert(bgImage)


    --[[local stopText = display.newText("일시정지", display.contentCenterX/2, display.contentCenterY*0.33, native.systemFontBold, 50)
    stopText:setFillColor( 1, 0.8, 0 )
    sceneGroup:insert(stopText)]]
    local continueButton = display.newImageRect("image/stop/노란버튼.png", 250, 80)
    continueButton.x, continueButton.y = display.contentCenterX, display.contentCenterY-50
    sceneGroup:insert(continueButton)
    local continueText = display.newText("계속하기", continueButton.x, continueButton.y, native.systemFontBold, 30)
    continueText:setFillColor(0, 0, 0)
    sceneGroup:insert(continueText)
    local closeButton = display.newImageRect("image/stop/노란버튼.png", 250, 80)
    closeButton.x, closeButton.y = continueButton.x, continueButton.y+80
    sceneGroup:insert(closeButton)
    local closeText = display.newText("그만하기", closeButton.x, closeButton.y, native.systemFontBold, 30)
    closeText:setFillColor(0, 0, 0)
    sceneGroup:insert(closeText)




    local settings = {}
    settings["fxvolume"] = 0.5
    settings["bgvolume"] = 0.5





     -- Audio setup
    audio.reserveChannels(1)
    local backgroundSound = audio.loadStream(music)

    --[[local bgImage = display.newImageRect("image/volume/창.png", 700, 700)
    bgImage.x = display.contentCenterX / 2; 
    bgImage.y = display.contentCenterY  *0.6; 
    sceneGroup:insert(bgImage)]]
    
    local text = "배경음"
    local showtext = display.newText(text, display.contentCenterX*0.1, display.contentCenterY*1.4)
    showtext:setFillColor(0)
    showtext.size = 25
    sceneGroup:insert(showtext)


    -- 볼륨리스너  
    local function bgSliderListener( event )
        local sliderValue = event.value
        loadedEndings.slider = sliderValue
        local logValue
        if sliderValue == nil then sliderValue = 0 end
        if (sliderValue > 0) then
            logValue = (math.pow(3,sliderValue/100)-1)/(3-1)
        else
            logValue = 0.0
        end
        settings["bgvolume"] = logValue
        loadedEndings.logValue = logValue
        loadsave.saveTable(loadedEndings,"endings.json")
        audio.setVolume( settings["bgvolume"]  )
    end

    local background_image = display.newImageRect("image/volume/소리조절칸.png", 300, 70)
    background_image.x, background_image.y = showtext.x+190, showtext.y+10
    sceneGroup:insert(background_image)

    local options = {
    frames = {
        { x=0, y=0, width=41, height=41 },
        { x=41, y=0, width=41, height=41 },
        { x=82, y=0, width=41, height=41 },
        { x=123, y=0, width=41, height=41 },
        { x=164, y=0, width=41, height=41 }
    },
    sheetcontentCenterX = 10,
    sheetcontentCenterY = 41
    }
    local sliderSheet = graphics.newImageSheet( "image/volume/sound1.png", options )
    
    -- 볼륨슬라이더
    local bgSlider = widget.newSlider{
        sheet = sliderSheet,
        leftFrame = 1,
        middleFrame = 2,
        rightFrame = 3,
        fillFrame = 4,
        frameWidth = 41,
        frameHeight = 41,
        handleFrame = 5,
        handleWidth = 41,
        handleHeight = 41,
        top = 380,    x = background_image.x,
        width=380,  y=background_image.y+10,
        value=loadedEndings.slider,
        listener = bgSliderListener
    }
    sceneGroup:insert( bgSlider )
    
    timer.pauseAll()
    local gameName = composer.getVariable("gameName")
    local function continueGame(event)
        --timer.resumeAll() --왜 제대로 실행 안 되는지 모르겠음
        timer.resume("gameTime")
        composer.hideOverlay("stopGame")
        composer.gotoScene(gameName)
    end

    local function closeGame(event)
        audio.pause(bgm_play)
        composer.removeScene(gameName)
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