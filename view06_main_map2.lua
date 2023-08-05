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
    print("퀘스트 완료 창 / Modal창")

    -- 퀘스트 완료된 게임명 가져오기
    -- local questedListGet = composer.getVariable("questedList")
    -- if(questedListGet ~= nil) then
    --     print("퀘스트 완료된 게임 갯수", #questedListGet)
    -- else
    --     print("questedListGet에 아무것도 없음")
    -- end

    -- quest는 받아온 것을 저장 / questShow는 퀘스트 문구명을 저장하는 리스트
    local questShow = {}
    -- local quested

    -- -- get으로 받아온 퀘스트목록이 있으면 quest에 복사
    -- if (questedListGet ~= nil) then
    --     quested = questedListGet
    -- else
    --     quested = {}
    -- end

    -- local j = 0

    -- 퀘스트 보드에 퀘스트 완료된 게임명 show
    -- if (#quested ~= nil and #quested ~= 0)then

    --     if (#quested == 1) then
    --         questShow[1] = display.newText("- "..quested[1].."", 0, 30, "ttf/Galmuri7.ttf", 30)
    --         questShow[1]:setFillColor(0, 0, 0)
    --         questShow[1].x = display.contentWidth * 0.5
    --         questShow[1].y = display.contentHeight * 0.35
    --         sceneGroup:insert(questShow[1])
    --     else
    --         for i = 1, #quested do 
    --             questShow[i] = display.newText("- "..quested[i].."", display.contentWidth * 0.5, display.contentHeight * 0.35 + (i-1)*40, 400, 0, "ttf/DungGeunMo.ttf", 30)
    --             print(questShow[i].y)
    --             questShow[i].align="left"
    --             questShow[i]:setFillColor(0, 0, 0)
    --         end
    --     end
    -- end

    if (loadedSettings.total_success ~= 0)then

        if(loadedSettings.total_success >= 4) then

            if(loadedSettings.total_success % 4 == 0) then

            elseif (loadedSettings.total_success % 4 == 1) then
                local index = 4 * math.floor((loadedSettings.total_success / 4)) + (loadedSettings.total_success % 4)
                print(index)
                print("test",loadedSettings.total_success_names[index])
                questShow[1] = display.newText("- "..loadedSettings.total_success_names[index].."", 0, 30, "ttf/Galmuri7.ttf", 30)
                questShow[1]:setFillColor(0, 0, 0)
                questShow[1].x = display.contentWidth * 0.5
                questShow[1].y = display.contentHeight * 0.35
                sceneGroup:insert(questShow[1])
            else
                for i = 1, loadedSettings.total_success % 4 do 
                    questShow[i] = display.newText("- "..loadedSettings.total_success_names[i + math.floor((loadedSettings.total_success / 4)) * 4 ].."", display.contentWidth * 0.5, display.contentHeight * 0.35 + (i-1)*40, 400, 0, "ttf/DungGeunMo.ttf", 30)
                    print(questShow[i].y)
                    questShow[i].align="left"
                    questShow[i]:setFillColor(0, 0, 0)
                end
            end
        else
            if (loadedSettings.total_success == 1) then
            questShow[1] = display.newText("- "..loadedSettings.total_success_names[1].."", 0, 30, "ttf/Galmuri7.ttf", 30)
            questShow[1]:setFillColor(0, 0, 0)
            questShow[1].x = display.contentWidth * 0.5
            questShow[1].y = display.contentHeight * 0.35
            sceneGroup:insert(questShow[1])
            else
                for i = 1, loadedSettings.total_success do 
                    questShow[i] = display.newText("- "..loadedSettings.total_success_names[i].."", display.contentWidth * 0.5, display.contentHeight * 0.35 + (i-1)*40, 400, 0, "ttf/DungGeunMo.ttf", 30)
                    print(questShow[i].y)
                    questShow[i].align="left"
                    questShow[i]:setFillColor(0, 0, 0)
                end
            end
        end
    end


    -- if (loadedSettings.total_success ~= 0)then

    --     if (loadedSettings.total_success == 1) then
    --         questShow[1] = display.newText("- "..loadedSettings.total_success_names[1].."", 0, 30, "ttf/Galmuri7.ttf", 30)
    --         questShow[1]:setFillColor(0, 0, 0)
    --         questShow[1].x = display.contentWidth * 0.5
    --         questShow[1].y = display.contentHeight * 0.35
    --         sceneGroup:insert(questShow[1])
    --     else
    --         for i = 1, loadedSettings.total_success do 
    --             questShow[i] = display.newText("- "..loadedSettings.total_success_names[i].."", display.contentWidth * 0.5, display.contentHeight * 0.35 + (i-1)*40, 400, 0, "ttf/DungGeunMo.ttf", 30)
    --             print(questShow[i].y)
    --             questShow[i].align="left"
    --             questShow[i]:setFillColor(0, 0, 0)
    --         end
    --     end
    -- end


    name = composer.getVariable("name")

    print(name)



  -- 배경 어둡게
    local black = display.newRect(display.contentWidth/2, display.contentHeight/2, display.contentWidth*3, display.contentHeight)
    black.alpha = 0.8
    black:setFillColor(0)
    sceneGroup:insert(black)
    

    local questScript = display.newImageRect("image/map/퀘스트.png", 900, 900/1.4)
    questScript.x, questScript.y = display.contentWidth/2, display.contentHeight/2
    sceneGroup:insert(questScript)

    local boardTitle = display.newText("📌 퀘스트 완료 목록 📌", 0, 0, "font/DOSGothic.ttf", 22)
    boardTitle:setFillColor(0)
    boardTitle.size = 42
    boardTitle.x = display.contentWidth/2
    boardTitle.y = display.contentHeight * 0.25
    sceneGroup:insert(boardTitle)


    local close_paper = audio.loadStream( "soundEffect/snd_close_map.wav" )
    -- exit 버튼 눌렀을 때 volumeControl.lua파일에서 벗어나기
    local function goback(event)
        -- if event.phase == "began" then
        --     composer.hideOverlay("showGotoCheckMsg")
        -- end
        --composer.hideOverlay("view06_main_map1")
        if event.phase == "began" then
            --composer.removeScene("view06_main_map1")
            local closePaperChannel = audio.play(close_paper)
            --composer.gotoScene("view05_main_map")
            composer.hideOverlay("view06_main_map2")
        end
    end



    -- exit 버튼 생성 및 버튼에 이벤트 리스너 추가
    local exit = display.newImageRect("image/설정/닫기.png", 50, 50)

    exit.x, exit.y = display.contentWidth*1.4, display.contentHeight*0.25
    exit:addEventListener("touch",goback)
    sceneGroup:insert(exit)

    print("#questShow",#questShow)
    for i = 1, #questShow do 
        sceneGroup:insert(questShow[i])
    end

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