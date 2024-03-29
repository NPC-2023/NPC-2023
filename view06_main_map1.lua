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
    local saveTime = loadedSettings.date

    -- local gametitle = display.newImageRect("image/map/background.png", display.contentWidth, display.contentHeight)
    -- gametitle.x, gametitle.y = display.contentWidth/2, display.contentHeight/2
    -- sceneGroup:insert(gametitle)


    -- local section = display.newRect(display.contentWidth/2, display.contentHeight*0.8, display.contentWidth, display.contentHeight*0.3)
    -- section:setFillColor(0.35, 0.35, 0.35, 0.35)
    -- section.alpha=0
    -- sceneGroup:insert(section)


    -- local script = display.newText("학교 지도야!\n건물을 클릭해보자!", section.x+30, section.y-100, native.systemFontBold)
    -- script.size = 30
    -- script:setFillColor(1)
    -- script.x, script.y = display.contentWidth/2, display.contentHeight*0.789
    -- script.alpha=0
    -- sceneGroup:insert(script)


    -- local background = display.newImageRect("image/map/background.png", display.contentWidth, display.contentHeight)
    -- background.x, background.y=display.contentWidth/2, display.contentHeight/2
    -- sceneGroup:insert(background)

    -- 화면전환 이펙트
    local options={
        effect = "fade",
        time = 4000
    }

    if(loadedSettings.total_success == 16) then --1일째에 엔딩. day는 히든퀘 깨면 플러스. (0부터 시작)
        composer.removeScene("view06_main_map1")
        composer.gotoScene("ending", options)
    end

     loadsave.saveTable(loadedSettings,"settings.json")


    -- 건물 배치 코드
    local buildingFileNames = { "인문관", "음악관", "예지관", "대학원", "본관", "정문", "백주년", "학생관", "커스텀"}
    local buildingNames = { "인문관", "음악관", "예지관", "대학원", "본관", "정문", "백주년", "학생관", "커스텀"}
    
    local building_x = {0.2, 1, 1.5, -0.45, 0.15, -0.1, -0.68, 0.65, 1.47}
    local building_y = {0.15, 0.2, 0.44, 0.35, 0.52, 0.82, 0.83, 0.52, 0.12}
    local building_size = {3, 3, 3, 3, 3, 3.2, 3.2, 3.2, 4.5}

    local buildingGroup = display.newGroup()
    local building = {}

    print("test")


    -- 퀘스트 4개를 실행하면 계절 바꾸게 하기
    local background
    --loadedSettings.total_success = 4
    --loadedSettings.total_success = 4
    print(loadedSettings.total_success .. "total_success print")
    --if(questedListGet == nil or #questedListGet < 2) then
    if(loadedSettings.total_success % 4 == 0 and loadedSettings.total_success ~= 0) then
        --4번 게임 진행시 게임진행도 리셋

        composer.setVariable("food_status", "renew")
        composer.setVariable("fallgame_status", "renew")
        composer.setVariable("pickgame_status", "renew")
        composer.setVariable("mousegame_status", "renew")
        composer.setVariable("jumpgame_status", "renew")
        composer.setVariable("stuId_status", "renew")
        composer.setVariable("climb_status", "renew")
        composer.setVariable("boongmake_status", "renew")
        composer.setVariable("frontgategame_status", "renew")
        composer.setVariable("moneygame_status", "renew")
        composer.setVariable("fishgame_status", "renew")
        --4번 게임 진행시 대화여부 리셋
        for i = 1,8 do
        composer.setVariable("talk"..i.."_status", "renew")
        end
    end
    --히든게임 리셋
    if(loadedSettings.total_success % 4 == 1 and loadedSettings.total_success ~= 0) then
        composer.setVariable("hiddengame_status", "renew")
    end

    --한 건물당 게임 두개일 경우 대화 여부 겹치지 않게함
    --예지관
    if(composer.getVariable("mousegame_status") == "success" and composer.getVariable("stuId_status") ~= "success") then
        composer.setVariable("talk8_status", "renew")
    end
    if(composer.getVariable("stuId_status") == "success" and composer.getVariable("mousegame_status") ~= "success") then
        composer.setVariable("talk8_status", "renew")
    end
    --대학원
    if(composer.getVariable("moneygame_status") == "success" and composer.getVariable("jumpgame_status") ~= "success") then
        composer.setVariable("talk5_status", "renew")
    end
    if(composer.getVariable("jumpgame_status") == "success" and composer.getVariable("moneygame_status") ~= "success") then
        composer.setVariable("talk5_status", "renew")
    end


    if(loadedSettings.total_success < 4) then
        print("봄")
        background = display.newImageRect("image/map/봄맵.png", display.contentWidth*3, display.contentHeight)
        
        for i = 1, 8 do 
            local size = building_size[i]
            building[i] = display.newImageRect(buildingGroup, "image/map/".. buildingFileNames[i] .."봄.png", 512/size, 512/size)
        end
    else
        if(loadedSettings.total_success >= 4 and loadedSettings.total_success < 8) then
            print("4개이상 성공 / 계절 바꿈(여름)")

            -- 2023.07.03 edit by jiruen // 게임 4개 성공 시, 게임 성공 리스트 reset
            if(loadedSettings.total_success == 4) then
                loadedSettings.total_success_names = {} 
            end

            -- 백그라운드 변경
            background = display.newImageRect("image/map/여름맵.png", display.contentWidth*3, display.contentHeight)

            for i = 1, 8 do 
                local size = building_size[i]
                building[i] = display.newImageRect(buildingGroup, "image/map/".. buildingFileNames[i] .."여름.png", 512/size, 512/size)
            end

        elseif(loadedSettings.total_success >= 8 and loadedSettings.total_success < 12)then
            print("8개이상 성공 / 계절 바꿈(가을)")

            -- 2023.07.03 edit by jiruen // 게임 8개 성공 시, 게임 성공 리스트 reset
            if(loadedSettings.total_success == 8) then
                loadedSettings.total_success_names = {} 
            end

            background = display.newImageRect("image/map/가을맵.png", display.contentWidth*3, display.contentHeight)

            for i = 1, 8 do 
                local size = building_size[i]
                building[i] = display.newImageRect(buildingGroup, "image/map/".. buildingFileNames[i] .."가을.png", 512/size, 512/size)
            end
        else
            print("12개이상 성공 / 계절 바꿈(겨울)")

            -- 2023.07.03 edit by jiruen // 게임 12개 성공 시, 게임 성공 리스트 reset
            if(loadedSettings.total_success == 12) then
                loadedSettings.total_success_names = {} 
            end

            background = display.newImageRect("image/map/겨울맵.png", display.contentWidth*3, display.contentHeight)

            for i = 1, 8 do 
                local size = building_size[i]
                building[i] = display.newImageRect(buildingGroup, "image/map/".. buildingFileNames[i] .."겨울.png", 512/size, 512/size)
            end
        end
    end

    background.x = display.contentWidth/2
    background.y = display.contentHeight/2


    for i = 1, 8 do 
        building[i].x, building[i].y = display.contentWidth*building_x[i], display.contentHeight*building_y[i]
        building[i].name = buildingNames[i]
    end

    local size = building_size[9]
    building[9] = display.newImageRect(buildingGroup, "image/map/".. buildingFileNames[9] ..".png", 512/size, 512/size)
    building[9].x, building[9].y = display.contentWidth*building_x[9], display.contentHeight*building_y[9]
    building[9].name = buildingNames[9]


    local catSolesGroup = display.newGroup()
    local catSoles = {}
    local catSoles_idx = 0

    
    if (loadedSettings.total_success ~= 0) then
        for i = 1, loadedSettings.total_success do
            if (loadedSettings.total_success_names[i] == "떨어지는 참치캔 받기")then  -- 인문관
                catSoles_idx = catSoles_idx + 1
                catSoles[catSoles_idx] = display.newImageRect(catSolesGroup, "image/map/6.png", 268/1.5, 275/1.5)
                catSoles[catSoles_idx].x, catSoles[catSoles_idx].y = display.contentWidth*0.25, display.contentHeight*0.15

                building[1].fill.effect = "filter.desaturate"
                building[1].fill.effect.intensity = 0.9

            elseif (loadedSettings.total_success_names[i] == "대신 학식 받아주기")then -- 음악관
                catSoles_idx = catSoles_idx + 1
                catSoles[catSoles_idx] = display.newImageRect(catSolesGroup, "image/map/6.png", 268/1.5, 275/1.5)
                catSoles[catSoles_idx].x, catSoles[catSoles_idx].y = display.contentWidth*1, display.contentHeight*0.2

                building[2].fill.effect = "filter.desaturate"
                building[2].fill.effect.intensity = 0.7
            elseif (loadedSettings.total_success_names[i] == "학생증 찾기" or loadedSettings.total_success_names[i] == "쥐 잡기")then -- 예지관
                catSoles_idx = catSoles_idx + 1
                catSoles[catSoles_idx] = display.newImageRect(catSolesGroup, "image/map/6.png", 268/1.5, 275/1.5)
                catSoles[catSoles_idx].x, catSoles[catSoles_idx].y = display.contentWidth*1.55, display.contentHeight*0.45

                building[3].fill.effect = "filter.desaturate"
                building[3].fill.effect.intensity = 0.7
            elseif (loadedSettings.total_success_names[i] == "매점에서 간식 사기"  or loadedSettings.total_success_names[i] == "고양이 점프해서 츄르 찾기")then -- 대학원
                catSoles_idx = catSoles_idx + 1
                catSoles[catSoles_idx] = display.newImageRect(catSolesGroup, "image/map/6.png", 268/1.5, 275/1.5)
                catSoles[catSoles_idx].x, catSoles[catSoles_idx].y = display.contentWidth*-0.45, display.contentHeight*0.32

                building[4].fill.effect = "filter.desaturate"
                building[4].fill.effect.intensity = 0.7

            --  for j = 1, loadedSettings.total_success do 
            --      if (loadedSettings.total_success_names[j] == "고양이 점프해서 츄르 찾기") then -- pre_jumpGame이지만 임시로 설정
            --          catSoles_idx = catSoles_idx + 1
            --          catSoles[catSoles_idx] = display.newImageRect(catSolesGroup, "image/map/6.png", 268/1.5, 275/1.5)
            --          catSoles[catSoles_idx].x, catSoles[catSoles_idx].y = display.contentWidth*0.25, display.contentHeight*0.32
            --          building[4].fill.effect = "filter.desaturate"
            --          building[4].fill.effect.intensity = 0.7
            --      end
            --  end
            -- elseif (loadedSettings.total_success_names[i] == "고양이 점프해서 츄르 찾기")then -- pre_jumpGame이지만 임시로 설정
            --  for j = 1, loadedSettings.total_success do 
            --      if(loadedSettings.total_success_names[j] == "매점에서 간식 사기") then
            --          catSoles_idx = catSoles_idx + 1
            --          catSoles[catSoles_idx] = display.newImageRect(catSolesGroup, "image/map/6.png", 268/1.5, 275/1.5)
            --          catSoles[catSoles_idx].x, catSoles[catSoles_idx].y = display.contentWidth*0.25, display.contentHeight*0.32
            --          building[4].fill.effect = "filter.desaturate"
            --          building[4].fill.effect.intensity = 0.7
            --      end
            --  end
            elseif (loadedSettings.total_success_names[i] == "나무 올라가기")then -- 백주년
                catSoles_idx = catSoles_idx + 1
                catSoles[catSoles_idx] = display.newImageRect(catSolesGroup, "image/map/6.png", 268/1.5, 275/1.5)
                catSoles[catSoles_idx].x, catSoles[catSoles_idx].y = display.contentWidth*-0.65, display.contentHeight*0.83

                building[7].fill.effect = "filter.desaturate"
                building[7].fill.effect.intensity = 0.7
            elseif (loadedSettings.total_success_names[i] == "Pick Game" )then -- 학생관
                catSoles_idx = catSoles_idx + 1
                catSoles[catSoles_idx] = display.newImageRect(catSolesGroup, "image/map/6.png", 268/1.5, 275/1.5)
                catSoles[catSoles_idx].x, catSoles[catSoles_idx].y = display.contentWidth*0.65, display.contentHeight*0.52

                building[8].fill.effect = "filter.desaturate"
                building[8].fill.effect.intensity = 0.7
            elseif (loadedSettings.total_success_names[i] == "붕어빵 만들기" )then -- 정문
                catSoles_idx = catSoles_idx + 1
                catSoles[catSoles_idx] = display.newImageRect(catSolesGroup, "image/map/6.png", 268/1.5, 275/1.5)
                catSoles[catSoles_idx].x, catSoles[catSoles_idx].y = display.contentWidth*-0.1, display.contentHeight*0.82

                building[6].fill.effect = "filter.desaturate"
                building[6].fill.effect.intensity = 0.7
            elseif (loadedSettings.total_success_names[i] == "물고기 사냥")then -- 본관 
                catSoles_idx = catSoles_idx + 1
                catSoles[catSoles_idx] = display.newImageRect(catSolesGroup, "image/map/6.png", 268/1.5, 275/1.5)
                catSoles[catSoles_idx].x, catSoles[catSoles_idx].y = display.contentWidth*0.13, display.contentHeight*0.5

                building[5].fill.effect = "filter.desaturate"
                building[5].fill.effect.intensity = 0.7
            end
        end
    end

    building[10] = display.newImageRect(buildingGroup, "image/map/맵아이콘.png", 384/3.5, 384/3.5)
    building[10].x, building[10].y=display.contentWidth*1.8, display.contentHeight*0.86
    building[10].name="퀘스트아이콘"

    building[11] = display.newImageRect(buildingGroup, "image/map/우체통.png", 150/1.2, 150/1.2)
    building[11].x, building[11].y = display.contentWidth*1.47, display.contentHeight*0.85
    building[11].name = "우체통"


    sceneGroup:insert(background)
    sceneGroup:insert(buildingGroup)
    sceneGroup:insert(catSolesGroup)

    --샘플 볼륨 이미지
    local volumeButton = display.newImageRect("image/설정/설정.png", display.contentWidth/5, display.contentHeight/8)
    volumeButton.x,volumeButton.y = display.contentWidth*1.8, display.contentHeight * 0.12
    
    sceneGroup:insert(volumeButton)

    -- 객체 생성
    print("건물 선택 창 / Modal창")


    -- showoverlay 함수 사용 option
    -- local options = {
    --     isModal = true
    -- }

    name = composer.getVariable("name")

    print(name)


  -- 배경 어둡게
    local black = display.newRect(display.contentCenterX,display.contentCenterY, 960, 480)
    black.alpha = 0.5
    black:setFillColor(0)
    sceneGroup:insert(black)
    

    local gotoScript = display.newImageRect("image/설정/창.png", display.contentWidth*1.6, display.contentHeight*1.05)
    gotoScript.x, gotoScript.y = display.contentCenterX, display.contentCenterY*1.2; 
    sceneGroup:insert(gotoScript)

    local gotoContentScript = display.newText(name.."으로 이동하시겠습니까?", display.contentCenterX, display.contentCenterY-10, native.systemFontBold)
    gotoContentScript.size = 27
    gotoContentScript:setFillColor(0, 0, 0)
    sceneGroup:insert(gotoContentScript)

    local gotoButton = display.newImageRect("image/설정/확인,힌트 버튼.png", display.contentWidth/2, display.contentHeight/2.8)
    gotoButton.x, gotoButton.y = display.contentCenterX, display.contentCenterY+75
    sceneGroup:insert(gotoButton)

    local gotoButtonText = display.newText( "확인", gotoButton.x, gotoButton.y-5, native.systemFont, 25 )
    gotoButtonText:setFillColor(0)  -- black
    sceneGroup:insert(gotoButtonText)

    --showoverlay 함수 사용 option
    -- 확인 버튼을 눌렀을 때 해당 건물의 게임 파일로 이동
    print(loadedSettings.total_success)
    local function gotoChallenge(event)
        if event.phase == "began" then
            if(loadedSettings.openHiddenQuest == true) then
                composer.removeScene("view06_main_map1")
                if(math.random(1, 2) == 1) then
                    composer.gotoScene("view23_npc_hidden_game")
                else
                    composer.gotoScene("view24_performance_game")
                end
            else
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
                elseif(name == "예지관") then
                    print("예지관")
                    composer.removeScene("view06_main_map1")
                    if(math.random(1, 2) == 1) then
                        composer.gotoScene("view10_npc_lost_stuId_game")
                    else
                        composer.gotoScene("view034_npc_mouse_game")
                    end
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
                    -- if(math.random(1, 2) == 1) then
                         composer.gotoScene("view21_npc_fishGame")
                    -- else
                        -- composer.gotoScene("view17_npc_boongmake_game") 
                    -- end
                    return true
                elseif(name == "정문")then
                    print("정문")
                    composer.removeScene("view06_main_map1")
                    -- composer.gotoScene("view18_npc_frontgate_game") --정문 게임 오류로 붕어빵 게임으로 대체
                    composer.gotoScene("view17_npc_boongmake_game")
                    return true
                elseif(name == "백주년")then
                    print("백주년")
                    composer.removeScene("view06_main_map1")
                    composer.gotoScene("view13_npc_climbingTree")
                    return true
                elseif(name == "학생관")then
                    print("학생관")
                    composer.removeScene("view06_main_map1") 
                    composer.gotoScene("view02_npc_pickGame")
                    return true
                end
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

    local exit = display.newImageRect("image/설정/닫기.png", display.contentWidth/7.5, display.contentHeight/13)
    exit.x, exit.y = display.contentCenterX*2.25, display.contentCenterY*0.5
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