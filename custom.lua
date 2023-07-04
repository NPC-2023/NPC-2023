-----------------------------------------------------------------------------------------
--
-- custom.lua
--
-----------------------------------------------------------------------------------------
local composer = require( "composer" )
local physics = require("physics")
local scene = composer.newScene()
local loadsave = require( "loadsave" )
local json = require( "json" )

function scene:create( event )
	local sceneGroup = self.view

	----저장관련 기능------
	local loadedEndings = loadsave.loadTable( "endings.json" )
	local loadedSettings = loadsave.loadTable( "settings.json" )

	local background = display.newImageRect("image/custom/catroom.png", display.contentWidth*1.15, display.contentHeight*1.15)
	background.x, background.y = display.contentWidth/2.3, display.contentHeight/2.3

	local can_cnt = loadedSettings.money
	local cloth_count = loadedSettings.clothesCount
	print(loadedSettings.custom2)
	print(cloth_count)
	
	----bgm 관련 기능------

	-- 2023.07.04 edit by jiruen // custom 창에 들어오면 짧게 실행된 옷장 bgm 추가
	local openCustomBgm = audio.loadStream( "soundEffect/15419_커스텀 창 클릭시 나오는 효과음.wav" )
	audio.play(openCustomBgm)
	
	--------------

	--local background = display.newImageRect("image/custom/catroom.png", display.contentWidth*1.1, display.contentHeight*1.1)
 	--background.x, background.y = display.contentWidth/2.3, display.contentHeight/2.3

	--sceneGroup:insert(background)

 	--[[local backgroundMusic = audio.loadStream( "soundEffect/custom_music.mp3" )
	audio.play( backgroundMusic )]]

	
	local cat = display.newImageRect(loadedSettings.custom1, 300, 300)
 	cat.x, cat.y = display.contentWidth*0.3, display.contentHeight*0.6
 	cat.xScale = -1

 	local cat_cloth = display.newImageRect(loadedSettings.custom2, 300, 300) --고양이의 몸, 옷 따로 구현
 	cat_cloth.x, cat_cloth.y = display.contentWidth*0.3, display.contentHeight*0.6
 	cat_cloth.xScale = -1

 	local objectGroup = display.newGroup()

 	local can = display.newImageRect("image/custom/can.png", 200, 200)
 	can.x, can.y = display.contentWidth*0.25, display.contentHeight*0.15

 	local can_cnt_text = display.newText(tostring(can_cnt), can.x + 15, can.y, "font/NanumSquare_acB.ttf") --변수받아와서 쓰기
 	can_cnt_text.size = 40
 	can_cnt_text:setFillColor(1)

	local map = display.newImageRect("image/npc/map_goback.png", 150, 150)
	map.x, map.y = display.contentWidth*0.83, display.contentHeight*0.12

	local map_text = display.newText("맵 보기", map.x, map.y, "font/DOSGothic.ttf")
	map_text.size = 40

 	local expression_name = {"cat_twinkle", "cat_tear", "cat_crank"}
 	local color_name = {"graycat", "pinkcat", "blackcat"}
 	local clothes_name = {"outer1", "outer2", "outer3", "outer4", "outer5", "outer6", "outer7", "outer8", "outer9"}

 	local panel = {}
 	for i = 1,3 do
	 	panel[i] = display.newImageRect("image/custom/glassPanel_tab.png", 100, 100)
	 	panel[i].x, panel[i].y = display.contentWidth*(0.5+0.1*i), display.contentHeight*0.3
	 	panel[i].name = "panel"..i
	 	panel[i].i = i --i번째 panel 이라는 뜻. 전체 저장 변수의 인덱스로 쓰기위함.
	 	panel[i].item = expression_name[i]
	 	objectGroup:insert(panel[i])

	 	panel[3+i] = display.newImageRect("image/custom/glassPanel_tab.png", 100, 100)
	 	panel[3+i].x, panel[3+i].y = display.contentWidth*(0.5+0.1*i), display.contentHeight*0.5
	 	panel[3+i].name = "panel"..(3+i)
	 	panel[3+i].i = 3+i
	 	panel[3+i].item = color_name[i]
	 	objectGroup:insert(panel[3+i])

	 	panel[6+i] = display.newImageRect("image/custom/glassPanel_tab.png", 100, 100)
	 	panel[6+i].x, panel[6+i].y = display.contentWidth*(0.5+0.1*i), display.contentHeight*0.7
	 	panel[6+i].name = "panel"..(6+i)
	 	panel[6+i].i = 6+i
	 	panel[6+i].item = clothes_name[i]
	 	objectGroup:insert(panel[6+i])

	 	--옷을 담을 panel 구현
	 	panel[9+i] = display.newImageRect("image/custom/glassPanel_tab.png", 100, 100)
		panel[9+i].x, panel[9+i].y = display.contentWidth*(0.5+0.1*i), display.contentHeight*0.7
		panel[9+i].name = "panel"..(9+i)
		panel[9+i].i = 9+i
		panel[9+i].item = clothes_name[3+i]
		panel[9+i].alpha = 0
		objectGroup:insert(panel[9+i])

		panel[12+i] = display.newImageRect("image/custom/glassPanel_tab.png", 100, 100)
		panel[12+i].x, panel[12+i].y = display.contentWidth*(0.5+0.1*i), display.contentHeight*0.7
		panel[12+i].name = "panel"..(12+i)
		panel[12+i].i = 12+i
		panel[12+i].item = clothes_name[6+i]
		panel[12+i].alpha = 0
		objectGroup:insert(panel[12+i])
 	end	

 	local expression = {}
 	expression[1] = display.newImageRect("image/custom/cat_twinkle.png", 80, 80)
 	expression[1].x, expression[1].y = display.contentWidth*(0.5+0.1*1), display.contentHeight*0.3
 	expression[2] = display.newImageRect("image/custom/cat_tear.png", 80, 80)
 	expression[2].x, expression[2].y = display.contentWidth*(0.5+0.1*2), display.contentHeight*0.3
	expression[3] = display.newImageRect("image/custom/cat_crank.png", 80, 80)
 	expression[3].x, expression[3].y = display.contentWidth*(0.5+0.1*3), display.contentHeight*0.3

 	local paint = {}
 	paint[1] = display.newImageRect("image/custom/graypaint.png", 80, 80)
 	paint[1].x, paint[1].y = display.contentWidth*(0.5+0.1*1), display.contentHeight*0.5
 	paint[2] = display.newImageRect("image/custom/pinkpaint.png", 80, 80)
 	paint[2].x, paint[2].y = display.contentWidth*(0.5+0.1*2), display.contentHeight*0.5
	paint[3] = display.newImageRect("image/custom/blackpaint.png", 80, 80)
 	paint[3].x, paint[3].y = display.contentWidth*(0.5+0.1*3), display.contentHeight*0.5

 	local clothes = {}
 	clothes[1] = display.newImageRect("image/custom/outer1.png", 80, 80)
 	clothes[1].x, clothes[1].y = display.contentWidth*(0.5+0.1*1), display.contentHeight*0.7
 	clothes[2] = display.newImageRect("image/custom/outer2.png", 80, 80)
 	clothes[2].x, clothes[2].y = display.contentWidth*(0.5+0.1*2), display.contentHeight*0.7
	clothes[3] = display.newImageRect("image/custom/outer3.png", 80, 80)
 	clothes[3].x, clothes[3].y = display.contentWidth*(0.5+0.1*3), display.contentHeight*0.7
 	clothes[4] = display.newImageRect("image/custom/outer4.png", 80, 80) --봄옷
 	clothes[4].x, clothes[4].y = display.contentWidth*(0.5+0.1*1), display.contentHeight*0.7
 	clothes[5] = display.newImageRect("image/custom/outer5.png", 80, 80) --여름옷1
 	clothes[5].x, clothes[5].y = display.contentWidth*(0.5+0.1*2), display.contentHeight*0.7
 	clothes[6] = display.newImageRect("image/custom/outer6.png", 80, 80) --여름옷2
 	clothes[6].x, clothes[6].y = display.contentWidth*(0.5+0.1*3), display.contentHeight*0.7
 	clothes[7] = display.newImageRect("image/custom/outer7.png", 80, 80) --가을옷
 	clothes[7].x, clothes[7].y = display.contentWidth*(0.5+0.1*1), display.contentHeight*0.7
 	clothes[8] = display.newImageRect("image/custom/outer8.png", 80, 80) --겨울옷1
 	clothes[8].x, clothes[8].y = display.contentWidth*(0.5+0.1*2), display.contentHeight*0.7
 	clothes[9] = display.newImageRect("image/custom/outer9.png", 80, 80) --겨울옷2
 	clothes[9].x, clothes[9].y = display.contentWidth*(0.5+0.1*3), display.contentHeight*0.7


 	--투명도 설정
 	local function setAlpha() 
 		print("실행됨")
 		local i = 1
	 	for i = 1,15 do
	 		if(loadedSettings.closed[i] == true) then
	 			print("미해제")
	 			if(i <= 3) then
	 				expression[i].alpha = 0.5
	 			elseif(i <= 6) then
	 				paint[i-3].alpha = 0.5
	 			elseif(i <= 9) then
	 				clothes[i-6].alpha = 0.5
	 			else
	 				clothes[i-6].alpha = 0
	 			end
	 		else
	 			print("해제됨")
	 			if(i <= 3) then
	 				expression[i].alpha = 1
	 			elseif(i <= 6) then
	 				paint[i-3].alpha = 1
	 			elseif(i <= 9) then
	 				clothes[i-6].alpha = 1
	 			else
	 				clothes[i-6].alpha = 0
	 			end
	 		end --closed
		end
 	end --function

 	setAlpha()
 	
 	local reset = display.newImageRect("image/custom/cat_paw.png", 150, 150)
 	reset.x, reset.y = display.contentWidth*0.1, display.contentHeight*0.1

 	local resetText = display.newText("RESET", reset.x, reset.y, "font/NanumSquare_acB.ttf")
 	resetText.size = 40
 	resetText:setFillColor(1)

 	-----음악

    -- showoverlay 함수 사용 option
    local options = {
        isModal = true
    }

    --샘플 볼륨 이미지
    local volumeButton = display.newImageRect("image/설정/설정.png", 100, 100)
    volumeButton.x,volumeButton.y = display.contentWidth * 0.95, display.contentHeight * 0.12


    --샘플볼륨함수--
    local function setVolume(event)
        composer.showOverlay( "volumeControl", options )
    end
    volumeButton:addEventListener("tap",setVolume)

    loadedEndings.bgMusic = "soundEffect/custom_music.mp3"

    local custom = audio.loadStream( loadedEndings.bgMusic )
    audio.setVolume( loadedEndings.logValue )--loadedEndings.logValue
    audio.play(custom)

    --버튼 이미지 바꿀 예정
 	local right_button = display.newImageRect(objectGroup, "image/custom/공통 좌우상하버튼.png", 80, 80)
 	right_button.x, right_button.y = display.contentWidth*0.9, display.contentHeight*0.7
 	local left_button = display.newImageRect(objectGroup, "image/custom/공통 좌우상하버튼.png", 80, 80)
 	left_button.xScale = -1
 	left_button.x, left_button.y = display.contentWidth*0.5, display.contentHeight*0.7

	for i=1,6 do 
 		if(loadedSettings.get_clothes[i] == true) then
 			loadedSettings.closed[9+i] = false 
		end
	end

 
    local item_for_reset = ''
    -------------
    local function changeCatApperanceEvent(event)
		-- 이름 적는 화면에서 퀘스트 성공 갯수, can 갯수 변수 설정, 커스텀 창 열린거 여부 확인
		-- setVariable() -> 히든게임 성공시 사용하여 can 갯수늘리고, 
		-- 이 함수에서 setVariable() 사용해 can 갯수 감소 시키기
		local item = event.target
		local item_name = event.target.item
		local popup_text = ""
		local btn_ok, btn_no = nil, nil
		local btn_ok_text, btn_no_text = "", ""
		local popupGroup = display.newGroup()
		local event_occur = false
		local clothesFlag = loadedSettings.clothesFlag --초기값:0 (옷을 안 입은 상태)
		local clothesFlag2 = 0
		item_for_reset = cat

		local function btnTapListener(event)
	 		if(event.target.name == "btn_ok" and can_cnt >= 3) then
	 			--고양이 모습 바뀜
	 			if(clothesFlag == 1) then --clothesFlag == 1 -> 이전 선택이 옷이라는 뜻
	 				cat_cloth.alpha = 0 -->이전 옷을 숨긴다
	 				--print("헤이")
	 			end
	 			for i=1, 9 do
	 				if(item_name == "outer"..i) then  
	 					loadedSettings.custom2 = "image/custom/"..item_name..".png"
	 					clothesFlag2 = 1 -->옷을 클릭했을 때 clothesFlag2 = 1 로 설정
	 					break
	 				end
	 			end
	 			--옷을 안 입었을 때는 투명 이미지로 설정
				cat_cloth = display.newImageRect(loadedSettings.custom2, 300, 300) 
				cat_cloth.x, cat_cloth.y = display.contentWidth*0.3, display.contentHeight*0.6
				cat_cloth.xScale = -1
	 				
	 			if(clothesFlag2 == 0) then --클릭한 게 옷이 아닐 때(고양이 몸색, 표정 클릭)
				 	loadedSettings.custom1 = "image/custom/"..item_name..".png"
				 	cat = display.newImageRect(loadedSettings.custom1, 300, 300)
					cat.x, cat.y = display.contentWidth*0.3, display.contentHeight*0.6
					cat.xScale = -1
				end

			 	event_occur = true --모습 바뀌었다는 것을 알려주는 변수
				 
				--팝업창
				popup_text.text = "해제되었습니다."
				popup_text.size = 20
	 			popup_text:setFillColor(0)
	 			btn_ok.x = display.contentWidth*0.5
	 			btn_ok_text.text, btn_ok_text.x = "확인", btn_ok.x
	 			btn_no.alpha, btn_no_text.alpha = 0, 0
	 			
	 			btn_ok:addEventListener("tap", function() 
	 				popupGroup.alpha = 0 
	 				popup_text.alpha = 0 

	 				if(event_occur == true) then
					can_cnt = can_cnt - 3 can_cnt_text.text = can_cnt event_occur = false
					end 
				end)

				--잠금해제
				loadedSettings.closed[item.i] = false 
				setAlpha()

				loadedSettings.money = loadedSettings.money - 3
				loadsave.saveTable(loadedSettings,"settings.json")
				loadsave.saveTable(loadedItems,"items.json")
				print(loadedSettings.custom1)
				print(loadedSettings.custom2)

			 	item.closed = false --잠금해제
			 			
				if(string.find(item_name, "outer") ~= nil) then  --클릭한 게 옷일 때 clothesFlag == 1
				 	clothesFlag = 1
				end		

				objectGroup:insert(cat)
				objectGroup:insert(cat_cloth)	

				loadedSettings.clothesFlag = clothesFlag
				 loadedSettings.money = can_cnt - 3	--왜 3을 빼야 제대로 저장되는지 이해못함
				 print("@@@@@" .. loadedSettings.money) 
				loadsave.saveTable(loadedSettings,"settings.json")					
			elseif (event.target.name == "btn_ok" and can_cnt < 3) then
				popup_text.text = "캔 수가 모자랍니다."
				btn_ok.x = display.contentWidth*0.5
	 			btn_ok_text.text, btn_ok_text.x = "확인", btn_ok.x
	 			btn_no.alpha, btn_no_text.alpha = 0, 0
	 			btn_ok:addEventListener("tap", function() popupGroup.alpha = 0 popup_text.alpha = 0 end) 
			else
				popupGroup.alpha = 0
			end
		end

		if(loadedSettings.closed[item.i] == true) then
			if(item.i <= 9) then
		 		local popup = display.newImageRect("image/custom/popup.png", 400, 400)
		 		popup.x, popup.y = display.contentWidth*0.5, display.contentHeight*0.5

		 		btn_ok = display.newImageRect("image/custom/btn_ok.png", 155, 200)
		 		btn_ok.x, btn_ok.y = display.contentWidth*0.44, display.contentHeight*0.55
		 		btn_ok.name = "btn_ok"

		 		btn_no = display.newImageRect("image/custom/btn_ok.png", 155, 200)
		 		btn_no.x, btn_no.y = display.contentWidth*0.56, display.contentHeight*0.55
		 		btn_no.name = "btn_no"

		 		popup_text = display.newText("캔을 3개 사용하여 해제할까요?", popup.x, popup.y-50, "font/DOSGothic.ttf")
		 		popup_text.size = 20
		 		popup_text:setFillColor(0)

		 		btn_ok_text =display.newText("네", btn_ok.x, btn_ok.y, "font/DOSGothic.ttf")
		 		btn_no_text =display.newText("아니오", btn_no.x, btn_no.y, "font/DOSGothic.ttf")

		 		popupGroup:insert(popup)
		 		popupGroup:insert(popup_text)
		 		popupGroup:insert(btn_ok)
		 		popupGroup:insert(btn_no)
		 		popupGroup:insert(btn_ok_text)
		 		popupGroup:insert(btn_no_text)

		 		sceneGroup:insert(popupGroup)

		 		btn_ok:addEventListener("tap", btnTapListener)	
				btn_no:addEventListener("tap", btnTapListener)	
			end
	 	else
	 					
			if(clothesFlag == 1) then --clothesFlag == 1 -> 이전 선택이 옷이라는 뜻
	 			cat_cloth.alpha = 0 -->이전 옷을 숨긴다
	 		end

	 		for i=1, 9 do
	 			print(item_name)
	 			if(item_name == "outer"..i) then
	 				loadedSettings.custom2 = "image/custom/"..item_name..".png"
	 				clothesFlag2 = 1 --옷을 클릭했을 때 clothesFlag2 = 1로 설정
	 				break
	 			end
	 		end

	 		cat_cloth = display.newImageRect(loadedSettings.custom2, 300, 300)
			cat_cloth.x, cat_cloth.y = display.contentWidth*0.3, display.contentHeight*0.6
			cat_cloth.xScale = -1
			
			if(clothesFlag2 == 0) then --고양이 표정, 몸 색 선택했을 때 바꾸도록!(옷 클릭 아닐 때)
			 	loadedSettings.custom1 = "image/custom/"..item_name..".png"
			 	cat = display.newImageRect(loadedSettings.custom1, 300, 300)
				cat.x, cat.y = display.contentWidth*0.3, display.contentHeight*0.6
				cat.xScale = -1
			end
			
			if(string.find(item_name, "outer") ~= nil) then --옷을 클릭했다면 clothesFlag = 1로 설정
			 	clothesFlag = 1
			end
			
			loadedSettings.clothesFlag = clothesFlag

			loadsave.saveTable(loadedSettings,"settings.json") --매번 해야 되나. 모르겠음
			loadsave.saveTable(loadedItems,"items.json")
			print(loadedSettings.custom1)
			print(loadedSettings.custom2)
		
			objectGroup:insert(cat)
	 		objectGroup:insert(cat_cloth)
	 		end
		end


 	local function resetListener( event )
 		--[[local soundEffect = audio.loadSound( "soundEffect/custom_music.mp3" )
		audio.play( soundEffect )]]
		
		cat_cloth.alpha = 0 --지금 입고 있는 옷을 없앰
		loadedSettings.custom1 = "image/custom/cat.png" --고양이는 기본 고양이 이미지
		loadedSettings.custom2 = "image/custom/투명.png" --옷은 투명 이미지

		local cat = display.newImageRect(loadedSettings.custom1, 300, 300)
 		cat.x, cat.y = display.contentWidth*0.3, display.contentHeight*0.6
 		cat.xScale = -1

 		local cat_cloth = display.newImageRect(loadedSettings.custom2, 300, 300)
 		cat_cloth.x, cat_cloth.y = display.contentWidth*0.3, display.contentHeight*0.6
 		cat_cloth.xScale = -1

 		clothesFlag = 1  --> reset하고 옷을 선택했을 때 투명 이미지가 사라지도록 
		loadedSettings.clothesFlag = clothesFlag

 		loadsave.saveTable(loadedSettings,"settings.json") --매번 해야 되나. 모르겠음
		loadsave.saveTable(loadedItems,"items.json")

 		objectGroup:insert(cat)
 		objectGroup:insert(cat_cloth)
 	end 

 	-- 2023.07.04 edit by jiruen // 맵 보기 클릭 시 옷장 닫는 bgm 추가
	local closeCustomBgm = audio.loadStream( "soundEffect/15418_커스텀 창에서 맵 클릭시 나오는 효과음.wav" )

 	local function goBackToMap(event)
 		if event.phase == "began" then
 			resetText.alpha = 0 
	 		composer.removeScene("custom")
	 		audio.pause(home)
	 		audio.play(closeCustomBgm)
			composer.gotoScene("view05_main_map")
		end
	end

	--옷장 closet_num = 1 -> 기본 옷 3개 보임
	--옷장 closet_num = 2 -> 봄 여름 여름
	--옷장 closet_num = 3 -> 가을 겨울 겨울
	local left_num = 1 --왼쪽 화살표
	local right_num = 1 --오른쪽 화살표
	local function right(event) --오른쪽으로 이동
		left_num = left_num + 1 --오른쪽으로 갔을 때만 왼쪽 가능하게 설정.  l = 2 r =3
		right_num = right_num + 1
		if(right_num <= 3) then
			if(right_num == 2) then --right_num==2 -> 봄 여름 여름 
				for i = 1,3 do
					panel[6+i].alpha = 0 --기본 옷 3개 panel
					clothes[i].alpha = 0 -- 기본 옷 3개 
					panel[9+i].alpha = 1 -- 봄 여름 여름 panel
					if(loadedSettings.get_clothes[i] == false) then--봄 여름 여름 옷
					--옷 안 받았을 때
	 					clothes[3+i].alpha = 0.5
	 				else
	 					clothes[3+i].alpha = 1
					end
					panel[12+i].alpha = 0 --가을 겨울 겨울 panel	
					clothes[6+i].alpha = 0 --가을 겨울 겨울 옷
				end
			elseif(right_num == 3) then --right_num==3 -> 가을 겨울 겨울
				for i = 1,3 do
					panel[6+i].alpha = 0 
					clothes[i].alpha = 0
					clothes[3+i].alpha = 0
					panel[9+i].alpha = 0
					panel[12+i].alpha = 1 --가을 겨울 겨울 panel	
					if(loadedSettings.get_clothes[3+i] == false) then --가을 겨울 겨울 옷
	 					clothes[6+i].alpha = 0.5
	 				else
	 					clothes[6+i].alpha = 1
					end 
				end
			end
		end
	end

	local function left(event) --왼쪽으로 이동
		left_num = left_num - 1 
		right_num = right_num - 1
		if(left_num >= 1) then 
			if(left_num == 1) then --closet_num이 2일 때
				for i = 1,3 do
					panel[6+i].alpha = 1 --기본 옷 3개 panel
					if(loadedSettings.closed[6+i] == true) then--봄 여름 여름 옷
	 					clothes[i].alpha = 0.5
	 				else
	 					clothes[i].alpha = 1
					end
					clothes[3+i].alpha = 0 --봄 여름 여름 옷
					panel[9+i].alpha = 0 -- 봄 여름 여름 panel
					panel[12+i].alpha = 0 --가을 겨울 겨울 panel	
					clothes[6+i].alpha = 0 --가을 겨울 겨울 옷
				end
			elseif(left_num == 2) then
				for i = 1,3 do
					panel[6+i].alpha = 0
					clothes[i].alpha = 0
					panel[9+i].alpha = 1
					if(loadedSettings.get_clothes[i] == false) then--봄 여름 여름 옷
	 					clothes[3+i].alpha = 0.5
	 				else
	 					clothes[3+i].alpha = 1
					end
					panel[12+i].alpha = 0
					clothes[6+i].alpha = 0 --가을 겨울 겨울 옷
				end
			end
		end
	end


	for i = 1, 15 do
		objectGroup:insert(panel[i])
	end
	
	objectGroup:insert(cat)
	objectGroup:insert(cat_cloth)
	objectGroup:insert(reset)
	objectGroup:insert(resetText)
	objectGroup:insert(map)
 	objectGroup:insert(map_text)
 	objectGroup:insert(can)
 	objectGroup:insert(can_cnt_text)

 	sceneGroup:insert(background)
 	sceneGroup:insert(objectGroup)
    sceneGroup:insert(volumeButton)
	

	for i = 1, 3 do
		objectGroup:insert(paint[i])
	end
	for i = 1, 3 do
		objectGroup:insert(expression[i])
	end
	for i = 1, 9 do
		objectGroup:insert(clothes[i])
	end

 	for i = 1, 15 do
	 	panel[i]:addEventListener("tap", changeCatApperanceEvent)
	end

	map:addEventListener("touch", goBackToMap)
 	reset:addEventListener("tap", resetListener)
 	right_button:addEventListener("tap", right)
	left_button:addEventListener("tap", left)
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