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


	-- 퀘스트 완료된 게임명 가져오기
    local questedListGet = composer.getVariable("questedList")
    if(questedListGet ~= nil) then
		print("받아온 것 ", #questedListGet)
	else
		print("questedListGet에 아무것도 없음")
	end


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



	-- 퀘스트 4개를 실행하면 계절 바꾸게 하기
	local background

	--if(questedListGet == nil or #questedListGet < 2) then
	if(questedListGet == nil) then
		print("봄")
		background = display.newImageRect("image/map/봄맵.png", display.contentWidth, display.contentHeight)

		for i = 1, 8 do 
			local size = building_size[i]
			building[i] = display.newImageRect(buildingGroup, "image/map/".. buildingFileNames[i] .."봄.png", 512/size, 512/size)
 		end
	end


	if(questedListGet ~= nil and #questedListGet >= 1 ) then
		local cnt = #questedListGet
		if(cnt == 1) then
			print("4개 성공 / 계절 바꿈(여름)")
			-- 백그라운드 변경
			background = display.newImageRect("image/map/여름맵.png", display.contentWidth, display.contentHeight)

			for i = 1, 8 do 
				local size = building_size[i]
				building[i] = display.newImageRect(buildingGroup, "image/map/".. buildingFileNames[i] .."여름.png", 512/size, 512/size)
	 		end

		elseif(cnt == 2)then
			print("8개 성공 / 계절 바꿈(가을)")
			background = display.newImageRect("image/map/가을맵.png", display.contentWidth, display.contentHeight)

			for i = 1, 8 do 
				local size = building_size[i]
				building[i] = display.newImageRect(buildingGroup, "image/map/".. buildingFileNames[i] .."가을.png", 512/size, 512/size)
	 		end

		elseif(cnt == 3)then
			print("12개 성공 / 계절 바꿈(겨울)")
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



	-- 계절에 따라 백그라운드 변경
	local season = os.date( "%m" )
	
	if(season == "03" or season == "04" or season == "05") then
		--print("봄")
	elseif (season == "06" or season == "07" or season == "08") then
		--print("여름")
	elseif (season == "09" or season == "10" or season == "11") then
		--print("가을")
	else
		--print("겨울")
	end



	-- 추가
	-- 퀘스트 완료된 보드 배치 -> 오른쪽 하단 위치 
	local board = display.newImageRect("image/map/퀘스트.png", 1280/2.4, 720/2.4)
	board.x, board.y=display.contentWidth*0.82, display.contentHeight*0.83

	local boardTitle = display.newText("📌 퀘스트 완료 목록 📌", 0, 0, "font/DOSGothic.ttf", 22)
	boardTitle:setFillColor(0)
	boardTitle.x = display.contentWidth * 0.82
	boardTitle.y = display.contentHeight * 0.741


	-- for i = 1, 9 do 
	-- 	local size = building_size[i]
	-- 	building[i] = display.newImageRect(buildingGroup, "image/map/".. buildingFileNames[i] ..".png", 512/size, 512/size)
 	-- 	building[i].x, building[i].y = display.contentWidth*building_x[i], display.contentHeight*building_y[i]
 	-- 	building[i].name = buildingNames[i]
	-- end


	if (questedListGet~=nil) then
		for i = 1, #questedListGet do
			if (questedListGet[i] == "떨어지는 참치캔 줍기")then
				building[1].fill.effect = "filter.desaturate"
				building[1].fill.effect.intensity = 0.7
			elseif (questedListGet[i] == "대신 학식 받아주기")then
				building[2].fill.effect = "filter.desaturate"
				building[2].fill.effect.intensity = 0.7
			elseif (questedListGet[i] == "학생증 찾기")then
				building[3].fill.effect = "filter.desaturate"
				building[3].fill.effect.intensity = 0.7
			elseif (questedListGet[i] == "나무 올라가기")then
				building[7].fill.effect = "filter.desaturate"
				building[7].fill.effect.intensity = 0.7
			elseif (questedListGet[i] == "Pick Game")then
				building[8].fill.effect = "filter.desaturate"
				building[8].fill.effect.intensity = 0.7
			end
		end
	end

	
	local target

	-- quest는 받아온 것을 저장 / questShow는 퀘스트 문구명을 저장하는 리스트
	local questShow = {}
	local quested

	-- get으로 받아온 퀘스트목록이 있으면 quest에 복사
	if (questedListGet ~= nil) then
		quested = questedListGet
	else
		quested = {}
	end

	local j = 0

	-- 퀘스트 보드에 퀘스트 완료된 게임명 show
	if (#quested ~= nil and #quested ~= 0)then
		if (#quested == 1) then
			questShow[1] = display.newText("- "..quested[1].."", 0, 0, "ttf/Galmuri7.ttf", 20)
			questShow[1]:setFillColor(0, 0, 1)
			questShow[1].x = display.contentWidth * 0.74
			questShow[1].y = display.contentHeight * 0.93 - 90
			sceneGroup:insert(questShow[1])
		else
			for i = 1, #quested do 
				print(#quested)
				questShow[i] = display.newText("- "..quested[i].."", 0, 0, "ttf/DungGeunMo.ttf", 20)
				
				if (i <= #quested/2) then
					questShow[i].x = display.contentWidth * 0.74
					questShow[i].y = display.contentHeight * 0.93 - (110-i*20)
				else
					questShow[i].x = display.contentWidth * 0.88
					questShow[i].y = display.contentHeight * 0.93 - (110-(i - #quested/2)*20)
				end
				questShow[i]:setFillColor(0, 0, 1)
			end
		end
	end
	-- 추가 끝

	


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
        	params = { targetName = name }
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
			else
				composer.setVariable("name", name)
				composer.showOverlay( "view06_main_map1", options )
				--composer.removeScene("view05_main_map")
				--composer.gotoScene("view06_main_map1")
			end
		end
	end

	sceneGroup:insert(background)
	sceneGroup:insert(buildingGroup)

-- 리스너 추가
	for i=1, 9 do
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