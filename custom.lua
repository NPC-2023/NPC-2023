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

	--------------


	--local background = display.newImageRect("image/custom/catroom.png", display.contentWidth*1.1, display.contentHeight*1.1)
 	--background.x, background.y = display.contentWidth/2.3, display.contentHeight/2.3

	--sceneGroup:insert(background)

 	--[[local backgroundMusic = audio.loadStream( "soundEffect/custom_music.mp3" )
	audio.play( backgroundMusic )]]

	local cat = display.newImageRect("image/custom/cat.png", 300, 300)
 	cat.x, cat.y = display.contentWidth*0.3, display.contentHeight*0.6
 	cat.xScale = -1

 	local objectGroup = display.newGroup()

 	local can = display.newImageRect("image/custom/can.png", 200, 200)
 	can.x, can.y = display.contentWidth*0.25, display.contentHeight*0.15

 	local can_cnt_text = display.newText(tostring(can_cnt), can.x + 20, can.y, "font/DOSGothic.ttf") --변수받아와서 쓰기
 	can_cnt_text.size = 40
 	can_cnt_text:setFillColor(1)

	local map = display.newImageRect("image/npc/map_goback.png", 150, 150)
	map.x, map.y = display.contentWidth*0.83, display.contentHeight*0.12

	local map_text = display.newText("맵 보기", map.x, map.y, "font/DOSGothic.ttf")
	map_text.size = 40

 	local expression_name = {"cat_twinkle", "cat_tear", "cat_crank"}
 	local color_name = {"graycat", "pinkcat", "blackcat"}
 	local clothes_name = {"outer1", "outer2", "outer3"}

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
 	end	

 	local expression = {}
 	expression[1] = display.newImageRect("image/custom/cat_twinkle.png", 80, 80)
 	expression[1].x, expression[1].y = display.contentWidth*(0.5+0.1*1), display.contentHeight*0.3
 	expression[2] = display.newImageRect("image/custom/cat_tear.png", 80, 80)
 	expression[2].x, expression[2].y = display.contentWidth*(0.5+0.1*2), display.contentHeight*0.3
	expression[3] = display.newImageRect("image/custom/cat_crank.png", 80, 80)
 	expression[3].x, expression[3].y = display.contentWidth*(0.5+0.1*3), display.contentHeight*0.3

 	--잠금해제전 투명도 설정
 	-- local i = 1
	-- for i = 1,3 do
	--  		if(loadedSettings.expression[i] == true) then
	--  			expression[i].alpha = 0.5
	--  		else
	--  			expression[i].alpha = 1
	--  		end
	--  end

 	local paint = {}
 	paint[1] = display.newImageRect("image/custom/graypaint.png", 80, 80)
 	paint[1].x, paint[1].y = display.contentWidth*(0.5+0.1*1), display.contentHeight*0.5
 	paint[2] = display.newImageRect("image/custom/pinkpaint.png", 80, 80)
 	paint[2].x, paint[2].y = display.contentWidth*(0.5+0.1*2), display.contentHeight*0.5
	paint[3] = display.newImageRect("image/custom/blackpaint.png", 80, 80)
 	paint[3].x, paint[3].y = display.contentWidth*(0.5+0.1*3), display.contentHeight*0.5

	 -- for i = 1,3 do
	 -- 		if(loadedSettings.paint[i] == true) then
	 -- 			paint[i].alpha = 0.5
	 -- 		else
	 -- 			paint[i].alpha = 1
	 -- 		end
	 -- end

 	local clothes = {}
 	clothes[1] = display.newImageRect("image/custom/outer1.png", 80, 80)
 	clothes[1].x, clothes[1].y = display.contentWidth*(0.5+0.1*1), display.contentHeight*0.7
 	clothes[2] = display.newImageRect("image/custom/outer2.png", 80, 80)
 	clothes[2].x, clothes[2].y = display.contentWidth*(0.5+0.1*2), display.contentHeight*0.7
	clothes[3] = display.newImageRect("image/custom/outer3.png", 80, 80)
 	clothes[3].x, clothes[3].y = display.contentWidth*(0.5+0.1*3), display.contentHeight*0.7


 	-- for i = 1,3 do
	--  		if(loadedSettings.clothes[i] == true) then
	--  			clothes[i].alpha = 0.5
	--  		else
	--  			clothes[i].alpha = 1
	--  		end
	--  end

 	local function setAlpha()
 		print("실행됨")
 		local i = 1
	 	for i = 1,9 do
	 		if(loadedSettings.closed[i] == true) then
	 			print("미해제")
	 			if(i <= 3) then
	 				expression[i].alpha = 0.5
	 			elseif(i <= 6) then
	 				paint[i-3].alpha = 0.5
	 			else
	 				clothes[i-6].alpha = 0.5
	 			end
	 		else
	 			print("해제됨")
	 			if(i <= 3) then
	 				expression[i].alpha = 1
	 			elseif(i <= 6) then
	 				paint[i-3].alpha = 1
	 			else
	 				clothes[i-6].alpha = 1
	 			end
	 		end --closed
	 	end --for문
 	end --function

 	setAlpha()
 	
 	local reset = display.newImageRect("image/custom/cat_paw.png", 150, 150)
 	reset.x, reset.y = display.contentWidth*0.1, display.contentHeight*0.1

 	local resetText = display.newText("RESET", reset.x, reset.y, "font/DOSGothic.ttf")
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

    local clothesFlag = 0

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

		local function btnTapListener(event)
 					if(event.target.name == "btn_ok" and can_cnt >= 3) then

 						if(clothesFlag == 1) then --이전 선택에서 옷을 선택했다면 곧 바로 옷을 숨김
				 			cat.alpha = 0
				 			print("숨김")
				 		end

 						cat = display.newImageRect("image/custom/"..item_name..".png", 300, 300)
			 			cat.x, cat.y = display.contentWidth*0.3, display.contentHeight*0.6
			 			cat.xScale = -1

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
			 			
			 			--옷 갈아입을때 오류 방지용 코드(선택한 것이 옷이면 1)
			 			if(string.find(item_name, "outer") == nil) then
							clothesFlag = 0
			 			else
			 				clothesFlag = 1
			 			end			

			 			objectGroup:insert(cat)	

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
 				local popup = display.newImageRect("image/custom/popup.png", 400, 400)
 				popup.x, popup.y = display.contentWidth*0.5, display.contentHeight*0.5

 				btn_ok = display.newImageRect("image/custom/btn_ok.png", 100, 200)
 				btn_ok.x, btn_ok.y = display.contentWidth*0.45, display.contentHeight*0.55
 				btn_ok.name = "btn_ok"

 				btn_no = display.newImageRect("image/custom/btn_ok.png", 100, 200)
 				btn_no.x, btn_no.y = display.contentWidth*0.55, display.contentHeight*0.55
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
 		else		
			if(clothesFlag == 1) then --이전 선택에서 옷을 선택했다면 곧 바로 옷을 숨김
	 			cat.alpha = 0
	 		end

	 		--아이템 선택이 옷인지 아닌지의 여부
	 		if(string.find(item_name, "outer") == nil) then 
				clothesFlag = 0
			else
				clothesFlag = 1
			end	

 			cat = display.newImageRect("image/custom/"..item_name..".png", 300, 300)
			cat.x, cat.y = display.contentWidth*0.3, display.contentHeight*0.6
			cat.xScale = -1	
			objectGroup:insert(cat)
		end
 	end

 	local function resetListener( event )
 		--[[local soundEffect = audio.loadSound( "soundEffect/custom_music.mp3" )
		audio.play( soundEffect )]]
 		cat = display.newImageRect("image/custom/cat.png", 300, 300)
 		cat.x, cat.y = display.contentWidth*0.3, display.contentHeight*0.6
 		cat.xScale = -1
 		objectGroup:insert(cat)
 	end 

 	local function goBackToMap(event)
 		if event.phase == "began" then
 			resetText.alpha = 0 
	 		composer.removeScene("custom")
	 		audio.pause(home)
			composer.gotoScene("view05_main_map")
		end
	end

	objectGroup:insert(cat)

	for i = 1, 9 do
		objectGroup:insert(panel[i])
	end

	for i = 1, 3 do
		objectGroup:insert(paint[i])
		objectGroup:insert(expression[i])
		objectGroup:insert(clothes[i])
	end
	
	objectGroup:insert(cat)
	objectGroup:insert(reset)
	objectGroup:insert(resetText)
	objectGroup:insert(map)
 	objectGroup:insert(map_text)
 	objectGroup:insert(can)
 	objectGroup:insert(can_cnt_text)

 	sceneGroup:insert(background)
 	sceneGroup:insert(objectGroup)
    sceneGroup:insert(volumeButton)

 	for i = 1, 9 do
	 	panel[i]:addEventListener("tap", changeCatApperanceEvent)
	 end

	map:addEventListener("touch", goBackToMap)
 	reset:addEventListener("tap", resetListener)
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