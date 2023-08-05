local composer = require( "composer" )
local physics = require("physics")
local scene = composer.newScene()
local loadsave = require( "loadsave" )
local json = require( "json" ) 

function scene:create( event )
    local sceneGroup = self.view
    -- 객체 생성

    local loadedSettings = loadsave.loadTable( "settings.json" )
    local loadedEndings = loadsave.loadTable( "endings.json" )


    -- showoverlay 함수 사용 option
    local options = {
        isModal = true
    }
    local widget = require ("widget")

   -- music = loadedEndings.bgMusic

    loadsave.saveTable(loadedSettings,"settings.json")

    -- 배경 어둡게
    local black = display.newRect(display.contentCenterX,display.contentCenterY,display.contentWidth*3, display.contentHeight)
    black.alpha = 0.5
    black:setFillColor(0)
    sceneGroup:insert(black)

    local p = display.newImageRect("image/postbox/우체통클릭화면.png", display.contentWidth*1.6, display.contentHeight*1.05)
    p.x, p.y = display.contentCenterX, display.contentCenterY*1.2
    sceneGroup:insert(p)
   
    local c_box = {}
    local objectGroup = display.newGroup()
    for i=1, 6 do 
        c_box[i] = display.newImageRect("image/postbox/옷 커스텀창.png", display.contentWidth/4.5, display.contentHeight/7)
        c_box[i].alpha = 0
        objectGroup:insert(c_box[i])
    end

    local clothes = {}
    clothes[1] = display.newImageRect("image/postbox/outer4.png", display.contentWidth/5.5, display.contentHeight/9) --봄옷
    clothes[1].name = "outer4"
    clothes[2] = display.newImageRect("image/postbox/outer5.png", display.contentWidth/5.5, display.contentHeight/9) --여름옷1
    clothes[2].name = "outer5"
    clothes[3] = display.newImageRect("image/postbox/outer6.png", display.contentWidth/5.5, display.contentHeight/9) --여름옷2
    clothes[3].name = "outer6"
    clothes[4] = display.newImageRect("image/postbox/outer7.png", display.contentWidth/5.5, display.contentHeight/9) --가을옷
    clothes[4].name = "outer7"
    clothes[5] = display.newImageRect("image/postbox/outer8.png", display.contentWidth/5.5, display.contentHeight/9) --겨울옷1
    clothes[5].name = "outer8"
    clothes[6] = display.newImageRect("image/postbox/outer9.png", display.contentWidth/5.5, display.contentHeight/9) --겨울옷2
    clothes[6].name = "outer9"
    
    for i=1, 6 do 
        objectGroup:insert(clothes[i])
         clothes[i].alpha = 0
    end
    sceneGroup:insert(objectGroup)

    local p_cnt = 1

    for i=1, 6 do
        print(loadedSettings.clothes[i])
        loadedSettings.clothes[i] = true
        if(loadedSettings.clothes[i] == true) then --히든 퀘스트 4개 완. 옷을 받았다 = true로 바꿈
            print("요"..i.."!")
            c_box[i].alpha = 1
            c_box[i].x , c_box[i].y = (p_cnt-1)*67, p.y/1.5
            clothes[i].alpha = 1
            clothes[i].x, clothes[i].y = c_box[i].x, c_box[i].y-2
            p_cnt = p_cnt + 1
        end
    end
    --local hQ_num = 8
    print(hQ_num)
    --if(hQ_num == 4) then
    --    loadedSettings.clothes[1] = true
    --elseif(hQ_num == 8) then
    --    loadedSettings.clothes[2] = true
    --    loadedSettings.clothes[3] = true
    --elseif(hQ_num == 12) then
    --    loadedSettings.clothes[4] = true
    --else
    --    loadedSettings.clothes[5] = true
    --    loadedSettings.clothes[6] = true
    --end
   
    local function getGift(event)
        for i=1, 6 do 
            if(event.target.name == "outer"..(i+3).."") then
                clothes[i].alpha = 0
                c_box[i].alpha = 0
                loadedSettings.clothes[i] = false
                loadedSettings.get_clothes[i] = true
                loadedSettings.clothesCount = loadedSettings.clothesCount + 1
                loadsave.saveTable(loadedSettings,"settings.json")
                break;
             end
        end
    end


    -- exit 버튼 눌렀을 때 volumeControl.lua파일에서 벗어나기
    local function goback(event)
        if event.phase == "began" then
            composer.hideOverlay("openPostBox")
        end
    end

    -- exit 버튼 생성 및 버튼에 이벤트 리스너 추가
    local exit = display.newImageRect("image/설정/닫기.png", display.contentWidth/7.5, display.contentHeight/13)
    exit.x, exit.y = display.contentCenterX*2.25, display.contentCenterY*0.5
    sceneGroup:insert(exit)
    
   
    exit:addEventListener("touch",goback)
    for i=1,6 do
        clothes[i]:addEventListener("tap", getGift)
    end
    loadsave.saveTable(loadedSettings,"settings.json")

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
