local loadsave = require( "loadsave" )
local composer = require( "composer" )
local scene = composer.newScene()
local json = require( "json" ) 

function scene:create( event )
    local sceneGroup = self.view
    local widget = require ("widget")

    --로드
    local loadedEnding = loadsave.loadTable( "ending.json" )
    music = loadedEnding.bgMusic

    -- 배경 어둡게
    local black = display.newRect(display.contentWidth/2,display.contentHeight/2,display.contentWidth,display.contentHeight)
    black.alpha = 0.5
    black:setFillColor(0)
    sceneGroup:insert(black)
    
    local settings = {}
    settings["fxvolume"] = 0.5
    settings["bgvolume"] = 0.5
    
    -- Audio setup
    audio.reserveChannels(1)
    --local backgroundSound = audio.loadStream(music)

    local bgImage = display.newImage("image/volume/창.png", display.contentWidth, display.contentHeight)
    bgImage.x = display.contentWidth / 2; 
    bgImage.y = display.contentHeight  / 2; 
    sceneGroup:insert(bgImage)
    
    -- 볼륨리스너  
    local function bgSliderListener( event )
        local sliderValue = event.value
        loadedEnding.slider = sliderValue
        local logValue
        if sliderValue == nil then sliderValue = 0 end
        if (sliderValue > 0) then
            logValue = (math.pow(3,sliderValue/100)-1)/(3-1)
        else
            logValue = 0.0
        end
        settings["bgvolume"] = logValue
        loadedEnding.logValue = logValue
        loadsave.saveTable(loadedEnding,"ending.json")
        audio.setVolume( settings["bgvolume"]  )
    end

    local background_image = display.newImage("image/volume/소리조절칸.png")
    background_image.x, background_image.y = display.contentWidth*0.29 + 200,display.contentHeight*0.53
    sceneGroup:insert(background_image)

    local options = {
    frames = {
        { x=0, y=0, width=41, height=41 },
        { x=41, y=0, width=41, height=41 },
        { x=82, y=0, width=41, height=41 },
        { x=123, y=0, width=41, height=41 },
        { x=164, y=0, width=41, height=41 }
    },
    sheetContentWidth = 205,
    sheetContentHeight = 41
    }
    local sliderSheet = graphics.newImageSheet( "image/volume/sound.png", options )
    
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
        top = 380,    x = display.contentCenterX*0.58 + 200,      
        width=380,  y=display.contentCenterY*1.06,      
        value=loadedEnding.slider,
        listener = bgSliderListener
    }
    sceneGroup:insert( bgSlider )

    -- exit 버튼 눌렀을 때 volumeControl.lua파일에서 벗어나기
    local function goback(event)
        if event.phase == "began" then
            composer.hideOverlay("volumeControl")
        end
    end

    -- exit 버튼 생성 및 버튼에 이벤트 리스너 추가
    local exit = display.newImageRect("image/volume/닫기.png", 80, 80)
    exit.x, exit.y = display.contentWidth*0.899, display.contentHeight*0.442
    sceneGroup:insert(exit)
    exit:addEventListener("touch",goback)
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