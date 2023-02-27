-----------------------------------------------------------------------------------------
--
-- custom.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

	local background = display.newImageRect("image/custom/catroom.png", display.contentWidth*1.1, display.contentHeight*1.1)
 	background.x, background.y = display.contentWidth/2.3, display.contentHeight/2.3

	sceneGroup:insert(background)

 	local backgroundMusic = audio.loadStream( "soundEffect/custom_music.mp3" )
	audio.play( backgroundMusic )

	local cat = display.newImageRect("image/custom/cat.png", 300, 300)
 	cat.x, cat.y = display.contentWidth*0.3, display.contentHeight*0.6
 	cat.xScale = -1

 	local objectGroup = display.newGroup()

 	local can = display.newImageRect("image/custom/can.png", 200, 200)
 	can.x, can.y = display.contentWidth*0.25, display.contentHeight*0.15

 	-- local can_cnt_global = composer.getVariable("can_cnt_global")
 	local can_cnt = 20

 	local can_cnt_text = display.newText(can_cnt, can.x + 20, can.y, "font/DOSGothic.ttf") --변수받아와서 쓰기
 	can_cnt_text.size = 40
 	can_cnt_text:setFillColor(1)

	local map = display.newImageRect("image/npc/map_goback.png", 150, 150)
	map.x, map.y = display.contentWidth*0.88, display.contentHeight*0.15

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
	 	panel[i].closed = true
	 	panel[i].item = expression_name[i]
	 	objectGroup:insert(panel[i])

	 	panel[3+i] = display.newImageRect("image/custom/glassPanel_tab.png", 100, 100)
	 	panel[3+i].x, panel[3+i].y = display.contentWidth*(0.5+0.1*i), display.contentHeight*0.5
	 	panel[3+i].name = "panel"..(3+i)
	 	panel[3+i].closed = true
	 	panel[3+i].item = color_name[i]
	 	objectGroup:insert(panel[3+i])

	 	panel[6+i] = display.newImageRect("image/custom/glassPanel_tab.png", 100, 100)
	 	panel[6+i].x, panel[6+i].y = display.contentWidth*(0.5+0.1*i), display.contentHeight*0.7
	 	panel[6+i].name = "panel"..(6+i)
	 	panel[6+i].closed = true
	 	panel[6+i].item = clothes_name[i]
	 	objectGroup:insert(panel[6+i])
 	end	

 	local expression = {}
 	expression[1] = display.newImageRect("image/custom/cat_twinkle.png", 80, 80)
 	expression[1].x, expression[1].y = display.contentWidth*(0.5+0.1*1), display.contentHeight*0.3
 	-- expression[1].alpha = 0.5 --잠금해제전 투명도 설정
 	expression[2] = display.newImageRect("image/custom/cat_tear.png", 80, 80)
 	expression[2].x, expression[2].y = display.contentWidth*(0.5+0.1*2), display.contentHeight*0.3
 	-- expression[2].alpha = 0.5
	expression[3] = display.newImageRect("image/custom/cat_crank.png", 80, 80)
 	expression[3].x, expression[3].y = display.contentWidth*(0.5+0.1*3), display.contentHeight*0.3
 	-- expression[3].alpha = 0.5

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
 	
 	local reset = display.newImageRect("image/custom/cat_paw.png", 150, 150)
 	reset.x, reset.y = display.contentWidth*0.1, display.contentHeight*0.1

 	local resetText = display.newText("RESET", reset.x, reset.y, "font/DOSGothic.ttf")
 	resetText.size = 40
 	resetText:setFillColor(1)

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
			print(can_cnt)
 					if(event.target.name == "btn_ok" and can_cnt >= 3) then
 						--고양이 모습 바뀜
 						cat = display.newImageRect("image/custom/"..item_name..".png", 300, 300)
			 			cat.x, cat.y = display.contentWidth*0.3, display.contentHeight*0.6
			 			cat.xScale = -1

			 			objectGroup:insert(cat)

			 			event_occur = true

			 			--팝업창
			 			popup_text.text = "해제되었습니다."
			 			popup_text.size = 20
 						popup_text:setFillColor(0)
 						btn_ok.x = display.contentWidth*0.5
 						btn_ok_text.text, btn_ok_text.x = "확인", btn_ok.x
 						btn_no.alpha, btn_no_text.alpha = 0, 0


 						btn_ok:addEventListener("tap", function() popupGroup.alpha = 0 popup_text.alpha = 0 if(event_occur == true) then
							can_cnt = can_cnt - 3 can_cnt_text.text = can_cnt event_occur = false
						end end) 
			 			item.closed = false --잠금해제
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

		if(event.target.closed == true) then
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
 				cat = display.newImageRect("image/custom/"..item_name..".png", 300, 300)
			 	cat.x, cat.y = display.contentWidth*0.3, display.contentHeight*0.6
			 	cat.xScale = -1	
		end
 	end

 	local function resetListener( event )
 		local soundEffect = audio.loadSound( "soundEffect/cat_meow4.wav" )
		audio.play( soundEffect )
 		cat = display.newImageRect("image/custom/cat.png", 300, 300)
 		cat.x, cat.y = display.contentWidth*0.3, display.contentHeight*0.6
 		cat.xScale = -1
 	end 

 	local function goBackToMap(event)
 		if event.phase == "began" then
 			resetText.alpha = 0 
	 		composer.removeScene("custom")
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
	
	objectGroup:insert(reset)
	objectGroup:insert(resetText)
	objectGroup:insert(map)
 	objectGroup:insert(map_text)
 	objectGroup:insert(can)
 	objectGroup:insert(can_cnt_text)

 	sceneGroup:insert(background)
 	sceneGroup:insert(objectGroup)

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