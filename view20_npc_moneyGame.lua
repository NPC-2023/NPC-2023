-----------------------------------------------------------------------------------------
--
-- pre_moneyGame.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

	local objectGroup = display.newGroup()

	local background = display.newImageRect("image/npc/store_entry.png", display.contentWidth, display.contentHeight)
 	background.x, background.y = display.contentWidth/2, display.contentHeight/2

 	local npc = display.newImageRect("image/npc/npc1.png", 250, 250)
	npc.x, npc.y = display.contentWidth*0.6, display.contentHeight*0.72
	npc.xScale = -1

	local cat = display.newImageRect("image/npc/cat_back.png", 200, 180)
	cat.x, cat.y = display.contentWidth*0.4, display.contentHeight*0.88

	local speechbubble = display.newImageRect("image/npc/speechbubble.png", 250, 150)
	speechbubble.x, speechbubble.y = npc.x, npc.y-130
	speechbubble.alpha = 0

	local speechbubble_exmark = display.newImageRect("image/npc/speechbubble_exmark.png", 150, 120)
	speechbubble_exmark.x, speechbubble_exmark.y = npc.x, npc.y-130

	local speech = display.newText("", speechbubble.x, speechbubble.y-20, "font/DOSGothic.ttf")
	local accept = display.newText("", speechbubble.x, speechbubble.y - 100, "font/DOSGothic.ttf")
	local money = math.random(1, 10) * 1000 --고양이가 받을 심부름 돈

	local map = display.newImageRect("image/npc/map_goback.png", 150, 150)
	map.x, map.y = display.contentWidth*0.88, display.contentHeight*0.15

	local map_text = display.newText("맵 보기", map.x, map.y, "font/DOSGothic.ttf")
	map_text.size = 40

	local coin = display.newImageRect("image/npc/coin.png", 100, 100)
	coin.alpha = 0

	--npc 말풍선 및 수락 텍스트
	local function talkWithNPC( event )
		speechbubble_exmark.alpha = 0
		speechbubble.alpha = 1
		speech.text = money.."어치\n간식 좀 사다줄래?"
		speech.size = 20
		speech:setFillColor(0)

		composer.setVariable("money", money)

		timer.performWithDelay( 1500, function() 
			coin.alpha = 1
 			coin.x, coin.y = npc.x-120, npc.y+10
 			objectGroup:insert(coin)
			accept.text = "동전을 누르세요\n"
			accept.size = 20
			accept:setFillColor(1)
		end)
	end

	local function acceptQuest( event )
		--수락시 말풍선, 대화 사라짐
		coin.alpha = 0
		speechbubble.alpha = 0
		speech.alpha = 0
		timer.performWithDelay( 500, function() 
			accept.alpha = 0
		end)

		--스크립트

		local section = display.newRect(display.contentWidth/2, display.contentHeight*0.8, display.contentWidth, display.contentHeight*0.3)
		section:setFillColor(0.35, 0.35, 0.35, 0.35)

		local script_can = display.newText(money.."을(를) 받았습니다.", section.x+30, section.y-100, "font/DOSGothic.ttf", 80)
		script_can.size = 30
		script_can:setFillColor(1)
		script_can.x, script_can.y = display.contentWidth/2, display.contentHeight*0.789

		objectGroup:insert(section)
		objectGroup:insert(script_can) 				

		--수락(말풍선)누르면 고양이가 말함
		local speechbubble2 = display.newImageRect("image/npc/speechbubble.png", 200, 75)
		speechbubble2.x, speechbubble2.y = cat.x, cat.y-100
		local speech2 = display.newText("알았다냥!\n", 
			speechbubble2.x, speechbubble2.y, "font/DOSGothic.ttf")
		speech2.size = 20
		speech2:setFillColor(0)
		--1초뒤 고양이 대화 사라짐
		timer.performWithDelay( 1000, function() 
			speechbubble2.alpha = 0
			speech2.alpha = 0
			composer.removeScene("view20_npc_moneyGame")
			composer.gotoScene("view20_moneyGame")
		end)
	end

	local function goBackToMap(event) 
		composer.gotoScene("view05_main_map")
	end

	if(composer.getVariable("successMoney") == "success") then
		-- local tmp = composer.getVariable("can_cnt_global")
		-- composer.setVariable("can_cnt_global", tmp + 1)
		speechbubble_exmark.alpha = 0
		coin.alpha = 0
		speech.alpha = 0
		accept.alpha = 0
		local speechbubble = display.newImageRect("image/npc/speechbubble.png", 250, 150)
		speechbubble.x, speechbubble.y = npc.x, npc.y-130
		local speech2 = display.newText("고마워! 맛있겠다!\n너도 맛있는거 먹을래?", 
			speechbubble.x, speechbubble.y-20, "font/DOSGothic.ttf")
		speech2.size = 20
		speech2:setFillColor(0)

		objectGroup:insert(speechbubble)
		objectGroup:insert(speech2)

		local fish = display.newImageRect("image/npc/can.png", 100, 100)
 		fish.x, fish.y = npc.x-120, npc.y+10

 		local function fishTapEventListener(event)
 			fish.alpha = 0

			local section = display.newRect(display.contentWidth/2, display.contentHeight*0.8, display.contentWidth, display.contentHeight*0.3)
			section:setFillColor(0.35, 0.35, 0.35, 0.35)

			local script_can = display.newText("퀘스트를 완료하였습니다. \n 맵으로 돌아가세요 ", section.x+30, section.y-100, "font/DOSGothic.ttf", 80)
			script_can.size = 30
			script_can:setFillColor(1)
			script_can.x, script_can.y = display.contentWidth/2, display.contentHeight*0.789

			objectGroup:insert(section)
			objectGroup:insert(script_can)
		end

		fish:addEventListener("tap", fishTapEventListener)
		objectGroup:insert(fish)
	end

	print(composer.getVariable("success"))


	speechbubble_exmark:addEventListener("tap", talkWithNPC)
	coin:addEventListener("tap", acceptQuest)
	map:addEventListener("tap", goBackToMap)


 	objectGroup:insert(npc)
 	objectGroup:insert(cat)
 	objectGroup:insert(speechbubble)
 	objectGroup:insert(speechbubble_exmark)
 	objectGroup:insert(speech)
 	objectGroup:insert(accept)
 	objectGroup:insert(map)
 	objectGroup:insert(map_text)

 	sceneGroup:insert(background)
 	sceneGroup:insert(objectGroup)

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