-----------------------------------------------------------------------------------------
--
-- View01_bear.lua
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

	-- 리스너 함수 (시간)
	function getDate(date)
		--print("설정 파일에 저장된 일: ", date.day, "일")
		local now = os.date( "*t" )   

		if(now.year > date.year) then
			print("몇 년이 흐름...")
			return 1
		else
			if(now.month > date.month) then
				print("몇 달이 흐름...")
				return 1
			else
				if(now.day > date.day)then
					print(now.day - date.day,"이 지남...")
					return 1
				else
					print("하루도 안 지남")
					return 2
				end
			end
		end
	end

	-- 설정 파일에서 저장된 시간 가져오기
	-- local time = loadsave.loadTable( "..." )
	--local saveTime = os.date( "*t" )
	--saveTime.day = 20
	print("설정 파일에 저장된 날짜: ", saveTime.month,"월", saveTime.day, "일")

	-- 현재 시간 가져오기
	local compareTime = getDate(saveTime)

	-- 건물 배치 코드
	local buildingFileNames = { "인문관", "음악관", "예지관", "대학원", "본관", "정문", "백주년", "학생관", "커스텀"}
	local buildingNames = { "인문관", "음악관", "예지관", "대학원", "본관", "정문", "백주년", "학생관", "커스텀"}
	
	local building_x = {0.42, 0.75, 0.84, 0.25, 0.35, 0.3, 0.09, 0.53, 0.85}
	local building_y = {0.22, 0.22, 0.44, 0.35, 0.52, 0.85, 0.87, 0.54, 0.1}
	local building_size = {2.3, 2.5, 2.5, 2.5, 2.3, 3, 3, 2.5 , 3.5}

	local buildingGroup = display.newGroup()
	local building = {}

	--print("오늘완료퀘스트수"..loadedSettings.today_success)
	--if(loadedSettings.today_success % 4 == 0 and loadedSettings.today_success ~= 0) then
	--	composer.removeScene("view05_main_map")
	--	composer.gotoScene("view23_hidden_game")
	--end

	-- 퀘스트 4개를 실행하면 계절 바꾸게 하기
	local background

	print(loadedSettings.total_success)
	
	local options1={
		effect = "fade",
		time = 2000,
		isModal = true
	}

	print(loadedSettings.openHiddenQuest)
	if(loadedSettings.openHiddenQuest == true) then
		loadedSettings.hidden_flag = false
	elseif(loadedSettings.total_success % 4 ~= 0) then
		print("왓??????????")
		loadedSettings.hidden_flag = true
	end

	--loadedSettings.total_success = 3
	print(loadedSettings.hidden_flag)
	if(loadedSettings.total_success ~= 0 and loadedSettings.total_success % 4 == 0 and loadedSettings.hidden_flag == true) then
		composer.showOverlay("hiddenQuest", options1)
	end
	

	--if(questedListGet == nil or #questedListGet < 2) then
	if(loadedSettings.total_success < 5) then
		print("봄")
		background = display.newImageRect("image/map/봄맵.png", display.contentWidth, display.contentHeight)

		for i = 1, 8 do 
			local size = building_size[i]
			building[i] = display.newImageRect(buildingGroup, "image/map/".. buildingFileNames[i] .."봄.png", 512/size, 512/size)
 		end
	else
		if(loadedSettings.total_success >= 4 or loadedSettings.total_success < 8) then
			print("4개이상 성공 / 계절 바꿈(여름)")
			-- 백그라운드 변경
			background = display.newImageRect("image/map/여름맵.png", display.contentWidth, display.contentHeight)

			for i = 1, 8 do 
				local size = building_size[i]
				building[i] = display.newImageRect(buildingGroup, "image/map/".. buildingFileNames[i] .."여름.png", 512/size, 512/size)
	 		end

		elseif(loadedSettings.total_success >= 8 or loadedSettings.total_success < 12)then
			print("8개이상 성공 / 계절 바꿈(가을)")
			background = display.newImageRect("image/map/가을맵.png", display.contentWidth, display.contentHeight)

			for i = 1, 8 do 
				local size = building_size[i]
				building[i] = display.newImageRect(buildingGroup, "image/map/".. buildingFileNames[i] .."가을.png", 512/size, 512/size)
	 		end
		else
			print("12개이상 성공 / 계절 바꿈(겨울)")
			background = display.newImageRect("image/map/겨울맵.png", display.contentWidth, display.contentHeight)

			for i = 1, 8 do 
				local size = building_size[i]
				building[i] = display.newImageRect(buildingGroup, "image/map/".. buildingFileNames[i] .."겨울.png", 512/size, 512/size)
			end
		end
	end

	background.x, background.y=display.contentWidth/2, display.contentHeight/2


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
			if (loadedSettings.total_success_names[i] == "떨어지는 참치캔 받기")then
				catSoles_idx = catSoles_idx + 1
				catSoles[catSoles_idx] = display.newImageRect(catSolesGroup, "image/map/6.png", 268/1.5, 275/1.5)
				catSoles[catSoles_idx].x, catSoles[catSoles_idx].y = display.contentWidth*0.44, display.contentHeight*0.2

				building[1].fill.effect = "filter.desaturate"
				building[1].fill.effect.intensity = 0.9

				-- building[1].fill.effect = "filter.brightness"
				-- building[1].fill.effect.intensity = 0.25

			elseif (loadedSettings.total_success_names[i] == "대신 학식 받아주기")then
				catSoles_idx = catSoles_idx + 1
				catSoles[catSoles_idx] = display.newImageRect(catSolesGroup, "image/map/6.png", 268/1.5, 275/1.5)
				catSoles[catSoles_idx].x, catSoles[catSoles_idx].y = display.contentWidth*0.75, display.contentHeight*0.21

				building[2].fill.effect = "filter.desaturate"
				building[2].fill.effect.intensity = 0.7
			elseif (loadedSettings.total_success_names[i] == "학생증 찾기")then
				catSoles_idx = catSoles_idx + 1
				catSoles[catSoles_idx] = display.newImageRect(catSolesGroup, "image/map/6.png", 268/1.5, 275/1.5)
				catSoles[catSoles_idx].x, catSoles[catSoles_idx].y = display.contentWidth*0.86, display.contentHeight*0.45

				building[3].fill.effect = "filter.desaturate"
				building[3].fill.effect.intensity = 0.7
			elseif (loadedSettings.total_success_names[i] == "매점에서 간식 사기")then
				for j = 1, loadedSettings.total_success do 
					if (loadedSettings.total_success_names[j] == "고양이 점프해서 츄르 찾기") then -- pre_jumpGame이지만 임시로 설정
						catSoles_idx = catSoles_idx + 1
						catSoles[catSoles_idx] = display.newImageRect(catSolesGroup, "image/map/6.png", 268/1.5, 275/1.5)
						catSoles[catSoles_idx].x, catSoles[catSoles_idx].y = display.contentWidth*0.25, display.contentHeight*0.32
						building[4].fill.effect = "filter.desaturate"
						building[4].fill.effect.intensity = 0.7
					end
				end
			elseif (loadedSettings.total_success_names[i] == "고양이 점프해서 츄르 찾기")then -- pre_jumpGame이지만 임시로 설정
				for j = 1, loadedSettings.total_success do 
					if(loadedSettings.total_success_names[j] == "매점에서 간식 사기") then
						catSoles_idx = catSoles_idx + 1
						catSoles[catSoles_idx] = display.newImageRect(catSolesGroup, "image/map/6.png", 268/1.5, 275/1.5)
						catSoles[catSoles_idx].x, catSoles[catSoles_idx].y = display.contentWidth*0.25, display.contentHeight*0.32
						building[4].fill.effect = "filter.desaturate"
						building[4].fill.effect.intensity = 0.7
					end
				end
			elseif (loadedSettings.total_success_names[i] == "나무 올라가기")then
				catSoles_idx = catSoles_idx + 1
				catSoles[catSoles_idx] = display.newImageRect(catSolesGroup, "image/map/6.png", 268/1.5, 275/1.5)
				catSoles[catSoles_idx].x, catSoles[catSoles_idx].y = display.contentWidth*0.1, display.contentHeight*0.85	

				building[7].fill.effect = "filter.desaturate"
				building[7].fill.effect.intensity = 0.7
			elseif (loadedSettings.total_success_names[i] == "Pick Game")then
				catSoles_idx = catSoles_idx + 1
				catSoles[catSoles_idx] = display.newImageRect(catSolesGroup, "image/map/6.png", 268/1.5, 275/1.5)
				catSoles[catSoles_idx].x, catSoles[catSoles_idx].y = display.contentWidth*0.54, display.contentHeight*0.52

				building[8].fill.effect = "filter.desaturate"
				building[8].fill.effect.intensity = 0.7
			elseif (loadedSettings.total_success_names[i] == "정문 지키기")then
				catSoles_idx = catSoles_idx + 1
				catSoles[catSoles_idx] = display.newImageRect(catSolesGroup, "image/map/6.png", 268/1.5, 275/1.5)
				catSoles[catSoles_idx].x, catSoles[catSoles_idx].y = display.contentWidth*0.3, display.contentHeight*0.85

				building[6].fill.effect = "filter.desaturate"
				building[6].fill.effect.intensity = 0.7
			end
		end
	end


	building[10] = display.newImageRect(buildingGroup, "image/map/맵아이콘.png", 384/3, 384/3)
	building[10].x, building[10].y=display.contentWidth*0.94, display.contentHeight*0.9
	building[10].name="퀘스트아이콘"

	local postbox = display.newImageRect("image/map/우체통.png", 150, 150)
	postbox.x, postbox.y = display.contentWidth*0.85, display.contentHeight*0.88
	postbox.name = "우체통"

	local options = {
        isModal = true
    }

 	local function showPostBox(event)
        composer.showOverlay( "openPostbox", options)
    end
	postbox:addEventListener("tap", showPostBox)



	--[[local function gotoCheckMsg( event )
		print("클릭함")
		target = event.target.name
		print(target)
		local options = {
        	isModal = true,
        	params = {
        	targetName = buildingNames[target]
    		}
    	}
    	print(options.params.targetName)
		composer.showOverlay("showGotoCheckMsg", options)
	end]]

    print("@@@@@test.." .. loadedSettings.days)

    -- 화면전환 이펙트
	local options={
		effect = "fade",
		time = 4000
	}

    if(loadedSettings.days == 16) then --1일째에 엔딩. day는 히든퀘 깨면 플러스. (0부터 시작)
        composer.removeScene("view06_main_map1")
        composer.gotoScene("ending", options)
    end

     loadsave.saveTable(loadedSettings,"settings.json")


-- 마을 맵 마을 객체 생성.
	local click1 = audio.loadStream( "music/스침.wav" )
	
-- 마을 객체 커서 범위 설정. 범위 밖으로 나가면 마을 크기 작아지고 안으로 들어가면 마을 크기 커짐.
	local i = 0
	local function bigbig (event)
		
		if (event.target.x-event.x)^2 + (event.target.y-event.y)^2 < 110^2 then
			-- i값을 지정해 놓는 이유는 범위 안에서는 크기가 더 늘어나거나 줄어들지 않고, 소리가 연이어 나오지 않음.
			if i == 0 then
				local backgroundMusicChannel = audio.play(click1)
				event.target.width = event.target.width*1.1
				event.target.height = event.target.height*1.1
				i = i + 1
			end
		
		elseif (event.target.x-event.x)^2 + (event.target.y-event.y)^2 > 110^2 then
			if i == 1 then
				event.target.width =event.target.width/11*10
				event.target.height =event.target.height/11*10
				i = i - 1 
			end
			
		end
	end

	local name = 0

	local options = {
        	isModal = true,
        	params = { targetName = name,
        	TargetquestedList = questedListGet }
	    	}	


-- 리스너 함수 생성
	local function touch_ui (event)
		if event.phase == "began" then
			name = event.target.name
	    	--print(options.params.targetName)
	    	print(name)

			if name == "커스텀" then
				---상점 코드
				composer.removeScene("view05_main_map")
				composer.gotoScene("custom")
			elseif name == "퀘스트아이콘" then
				composer.setVariable("questedListGet", questedListGet)
				
				composer.showOverlay( "view06_main_map2", options )
			else
				composer.setVariable("name", name)
                if(loadedSettings.openHiddenQuest == true) then
                	print("야호")
                	--그 건물 버튼만 활성화
                	if(composer.getVariable("name") == loadedSettings.buildings_index[loadedSettings.hidden_index]) then
                    	composer.removeScene("view05_main_map")
						composer.gotoScene("view06_main_map1")
                	end
                else
                	--히든퀘스트가 안 열렸으면 그대로
					-- showOverlay로 하면 view05_main_map 처음부터 실행시킬 수 X
					--composer.showOverlay( "view06_main_map1", options )
					composer.removeScene("view05_main_map")
					composer.gotoScene("view06_main_map1")
				end
			end
		end
	end

	sceneGroup:insert(background)
	sceneGroup:insert(postbox)
	sceneGroup:insert(buildingGroup)
	sceneGroup:insert(catSolesGroup)

-- 리스너 추가
	for i=1, 10 do
		building[i]:addEventListener("mouse",bigbig)
		building[i]:addEventListener("touch",touch_ui)
		--building[i]:addEventListener("tap", gotoCheckMsg)
	end

 
	--샘플 볼륨 이미지
    -----음악

    -- showoverlay 함수 사용 option
    local options = {
        isModal = true
    }

    --샘플 볼륨 이미지
    local volumeButton = display.newImageRect("image/설정/설정.png", 100, 100)
    volumeButton.x,volumeButton.y = display.contentWidth * 0.95, display.contentHeight * 0.12
    
    sceneGroup:insert(volumeButton)


    --샘플볼륨함수--
    local function setVolume(event)
        composer.showOverlay( "volumeControl", options )
    end
    volumeButton:addEventListener("tap",setVolume)

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
		--composer.removeScene("view05_main_map")
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