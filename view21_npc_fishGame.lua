-----------------------------------------------------------------------------------------
--
-- pre_fishGame.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()
local loadsave = require( "loadsave" )

function scene:create( event )
	local sceneGroup = self.view

	local objectGroup = display.newGroup()

	local background = display.newImageRect("image/npc/place3.jpg", display.contentWidth, display.contentHeight)
 	background.x, background.y = display.contentWidth/2, display.contentHeight/2

 	local npc = display.newImageRect("image/npc/npc3.png", 200, 200)
	npc.x, npc.y = display.contentWidth*0.5, display.contentHeight*0.55
	npc.xScale = -1

	local cat = display.newImageRect("image/npc/cat_back.png", 200, 200)
	cat.x, cat.y = display.contentWidth*0.7, display.contentHeight*0.9
	cat.xScale = -1

	local speechbubble = display.newImageRect("image/npc/speechbubble.png", 300, 150)
	speechbubble.x, speechbubble.y = npc.x, npc.y - 170
	speechbubble.alpha = 0

	local speechbubble_exmark = display.newImageRect("image/npc/speechbubble_exmark.png", 150, 150)
	speechbubble_exmark.x, speechbubble_exmark.y = npc.x, display.contentHeight*0.35

	local speech = display.newText("", speechbubble.x, speechbubble.y-20, "font/DOSGothic.ttf")
	local accept = display.newText("", speechbubble.x, speechbubble.y - 60, "font/DOSGothic.ttf")

	local map = display.newImageRect("image/npc/map_goback.png", 150, 150)
	map.x, map.y = display.contentWidth*0.88, display.contentHeight*0.15

	local map_text = display.newText("맵 보기", map.x, map.y, "font/DOSGothic.ttf")
	map_text.size = 40

	-- local coin = display.newImageRect("image/coin.png", 100, 100)
	-- coin.alpha = 0

	local gossip_script = 'a'
	local game_script = 'a'


	local loadedSettings = loadsave.loadTable( "settings.json" )
	mainName = loadedSettings.name
	talk = loadedSettings.talk
	times = talk[3] --본관 번호는 3

	--npc와 대화한 횟수 테스트 용 코드 ( 잘뜸 )
	local text = display.newText(times, display.contentWidth*0.9, display.contentHeight*0.1, "font/DOSGothic.ttf", 80)

	local function acceptQuest( event )
		--수락시 말풍선, 대화 사라짐
		-- coin.alpha = 0
		speechbubble.alpha = 0
		speech.alpha = 0
		timer.performWithDelay( 500, function() 
			accept.alpha = 0
		end)

		--스크립트

		local section = display.newRect(display.contentWidth/2, display.contentHeight*0.8, display.contentWidth, display.contentHeight*0.3)
		section:setFillColor(0.35, 0.35, 0.35, 0.35)

		local script_can = display.newText("퀘스트를 수락했습니다", section.x+30, section.y-100, "font/DOSGothic.ttf", 80)
		script_can.size = 30
		script_can:setFillColor(1)
		script_can.x, script_can.y = display.contentWidth/2, display.contentHeight*0.789

		objectGroup:insert(section)
		objectGroup:insert(script_can) 				

		--수락(말풍선)누르면 고양이가 말함
		local speechbubble2 = display.newImageRect("image/npc/speechbubble.png", 200, 75)
		speechbubble2.x, speechbubble2.y = cat.x, cat.y-100
		local speech2 = display.newText("...물고기?!\n", 
			speechbubble2.x, speechbubble2.y, "font/DOSGothic.ttf")
		speech2.size = 20
		speech2:setFillColor(0)
		--1초뒤 고양이 대화 사라짐
		timer.performWithDelay( 1000, function() 
			speechbubble2.alpha = 0
			speech2.alpha = 0
			composer.removeScene("view21_npc_fishGame")
			composer.gotoScene("view21_fishGame")
		end)
	end

		--npc 말풍선 및 수락 텍스트
	local function talkWithNPC( event )
		speechbubble_exmark.alpha = 0
		speechbubble.alpha = 1
		speech.text = "우와 여기 물고기 엄청 많네!\n우리 냥이도 좋아하겠다"
		speech.size = 20
		speech:setFillColor(0)

		timer.performWithDelay( 1000, function() 
			-- npc가 고양이에게 물건 줄때 사용하는 코드(없는 경우도 있음)
			-- coin.alpha = 1
 			-- coin.x, coin.y = npc.x-80, npc.y-20
 			-- objectGroup:insert(coin)

 			--스크립트
			local section = display.newRect(display.contentWidth/2, display.contentHeight*0.8, display.contentWidth, display.contentHeight*0.3)
			section:setFillColor(0.35, 0.35, 0.35, 0.35)

			local script = display.newText("어떤 것을 할까?", display.contentWidth*0.2, display.contentHeight*0.7, "font/DOSGothic.ttf", 80)
			script.size = 30
			script:setFillColor(1)

			gossip_click = display.newText("▼대화", display.contentWidth*0.15, display.contentHeight*0.8, "font/DOSGothic.ttf", 80)
			gossip_click.size = 30
			gossip_click:setFillColor(1)

			game_click = display.newText("▼게임", display.contentWidth*0.15, display.contentHeight*0.88, "font/DOSGothic.ttf", 80)
			game_click.size = 30
			game_click:setFillColor(1)

			objectGroup:insert(section)
			objectGroup:insert(script)
			objectGroup:insert(gossip_click)
			objectGroup:insert(game_click)

			gossip_click:addEventListener("tap", function() --대화 클릭 시 페이지 이동
				if(composer.getVariable("talk_status") == "fin") then
					times = times + 1
					script.alpha = 0
					script = display.newText("이미 대화를 끝냈습니다.", display.contentWidth*0.2, display.contentHeight*0.7, "font/DOSGothic.ttf", 80)
					script.size = 30
					script.alpha = 1

					objectGroup:insert(script)
				else
					composer.removeScene("view21_npc_fishGame")
					composer.gotoScene("view21_talk_fishGame")
				end
			end
			)

			game_click:addEventListener("tap", acceptQuest)

			-- accept.text = "말풍선을 누르세요\n"
			-- accept.size = 20
			-- accept:setFillColor(1)
		end )
	end

	local function goBackToMap(event) 
		composer.gotoScene("view05_main_map")
	end

	if(composer.getVariable("successFishing") == "success") then
		-- local tmp = composer.getVariable("can_cnt_global")
		-- composer.setVariable("can_cnt_global", tmp + 1)
		speechbubble_exmark.alpha = 0
		-- coin.alpha = 0
		speech.alpha = 0
		accept.alpha = 0
		local speechbubble = display.newImageRect("image/npc/speechbubble.png", 250, 150)
		speechbubble.x, speechbubble.y = npc.x, display.contentHeight*0.35
		local speech2 = display.newText("이거 나 주는거야?", 
		speechbubble.x, speechbubble.y-20, "font/DOSGothic.ttf")
		speech2.size = 20
		speech2:setFillColor(0)

		objectGroup:insert(speechbubble)
		objectGroup:insert(speech2)

		local fish = display.newImageRect("image/npc/fish1.png", 100, 100)
 		fish.x, fish.y = cat.x - 80, cat.y - 80

 		local function fishTapEventListener(event)
 			fish.alpha = 0

 			speech2.text = "우리 냥이 줘야지! \n 고마워!"

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

	loadsave.saveTable(loadedSettings,"settings.json")

	speechbubble_exmark:addEventListener("tap", talkWithNPC)
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