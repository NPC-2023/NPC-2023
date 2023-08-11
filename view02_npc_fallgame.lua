-----------------------------------------------------------------------------------------
--
-- 
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local physics = require("physics")
local scene = composer.newScene()
local loadsave = require( "loadsave" )
local json = require( "json" )

function scene:create( event )
	local sceneGroup = self.view

	local objectGroup = display.newGroup()
	local scriptGroup = display.newGroup()


	local background = display.newImageRect("image/npc/place2.jpg", display.contentWidth*3, display.contentHeight)
	background.x = display.contentCenterX
    background.y = display.contentCenterY

 	local npc = display.newImageRect("image/npc/npc3.png", display.contentWidth/1.5, display.contentHeight/3)
	npc.x, npc.y = display.contentWidth*0.9, display.contentHeight*0.75
	npc.xScale = -1

	local cat = display.newImageRect("image/npc/cat_back.png", display.contentWidth/2, display.contentHeight/2.5)
	cat.x, cat.y = display.contentWidth*0.5, display.contentHeight*0.88
	objectGroup:insert(cat)

	local speechbubble = display.newImageRect("image/npc/speechbubble.png", display.contentWidth/1.3, display.contentHeight/3.5)
	speechbubble.x, speechbubble.y = npc.x, npc.y - 150
	speechbubble.alpha = 0

	local speechbubble_exmark = display.newImageRect("image/npc/speechbubble_exmark.png", display.contentWidth/2.5, display.contentHeight/3.5)
	speechbubble_exmark.x, speechbubble_exmark.y = npc.x, npc.y-140

	local speech = display.newText("", speechbubble.x, speechbubble.y-20, "font/DOSGothic.ttf")
	speech.size = 20
	speech:setFillColor(0)
	local accept = display.newText("", speechbubble.x, speechbubble.y - 60, "font/DOSGothic.ttf")

	local map = display.newImageRect("image/npc/map_goback.png",display.contentWidth/2.5, display.contentHeight/4)
	map.x, map.y = display.contentWidth*1.6, display.contentHeight*0.15

	local map_text = display.newText("맵 보기", map.x, map.y, "font/DOSGothic.ttf")
	map_text.size = 30

	--스크립트
	local section = display.newRect(display.contentWidth/2, display.contentHeight*0.9, display.contentWidth*3, display.contentWidth*0.9)
	section:setFillColor(0.35, 0.35, 0.35, 0.35)
	section.alpha = 0

	local script = display.newText("", display.contentWidth*0.1, display.contentHeight*0.73, "font/DOSGothic.ttf", 80)
	script.size = 30
	script:setFillColor(1)
	script.alpha = 0

	objectGroup:insert(section)
	objectGroup:insert(script) 

	--스크립트 속 선택지
	local gossip_click = display.newText("▶대화", display.contentWidth*0.6*2, display.contentHeight*0.9, "font/DOSGothic.ttf", 80)
	gossip_click.size = 30
	gossip_click:setFillColor(1)
	gossip_click.alpha = 0

	local game_click = display.newText("▶게임", display.contentWidth*0.8*2, display.contentHeight*0.9, "font/DOSGothic.ttf", 80)
	game_click.size = 30
	game_click:setFillColor(1)
	game_click.alpha = 0


	--게임 전체 변수(저장됨)
	local loadedSettings = loadsave.loadTable( "settings.json" )
	mainName = loadedSettings.name
	times = loadedSettings.talk[6]

	if(composer.getVariable("talk6_status") == "fin") then
		loadedSettings.talk[6] = 0 --0으로 초기화하기 위한 임시 코드
		loadedSettings.talk[6] = loadedSettings.talk[6] + 1
	end

	-- mainmap1의 77번째 코드로 대체
	-- --오늘 완수한 게임 개수가 4면 성공플래그 리셋
	-- if(loadedSettings.total_success % 4 == 0 and loadedSettings.total_success ~= 0) then
	-- 	composer.setVariable("fallgame_status", "renew")
	-- 	composer.setVariable("talk6_status", "renew")
	-- end

	--오늘 완수한 게임 개수(4면 히든게임 등장)
	if(composer.getVariable("fallgame_status") == "success") then
		loadedSettings.today_success = loadedSettings.today_success + 1
	end

	local function acceptQuest( event )
		--수락시 말풍선, 대화 사라짐
		-- coin.alpha = 0
		scriptGroup.alpha = 0
		speechbubble.alpha = 0
		speech.alpha = 0
		accept.alpha = 0

		section.alpha = 1
		script.text = "퀘스트를 수락했습니다."
		script.alpha = 1			

		--수락(말풍선)누르면 고양이가 말함
		local speechbubble = display.newImageRect("image/npc/speechbubble.png",  display.contentWidth/2.5, display.contentHeight/7)
		speechbubble.x, speechbubble.y = cat.x, cat.y-100
		local speech = display.newText("뭐다냥?\n", speechbubble.x, speechbubble.y, "font/DOSGothic.ttf")
		speech.size = 15
		speech:setFillColor(0)

		objectGroup:insert(script)
		objectGroup:insert(speechbubble)
		objectGroup:insert(speech)

		--1초뒤 고양이 대화 사라짐
		timer.performWithDelay( 1000, function() 
			speechbubble.alpha = 0
			speech.alpha = 0
			composer.removeScene("view02_npc_fallgame")
			composer.gotoScene("view02_fall_game")
		end)
	end


	local function gossipOrGame(event)
		timer.performWithDelay( 1500, function() 
			scriptGroup.alpha = 1
			--스크립트
			local section = display.newRect(display.contentWidth/2, display.contentHeight*0.9, display.contentWidth*3, display.contentWidth*0.9)
			section:setFillColor(0.35, 0.35, 0.35, 0.35)

			local script = display.newText("어떤 것을 할까?", display.contentWidth*0.1, display.contentHeight*0.73, "font/DOSGothic.ttf", 80)
			script.size = 30
			script:setFillColor(1)

			gossip_click.alpha = 1
			game_click.alpha = 1

			objectGroup:insert(section)
			scriptGroup:insert(script)
			scriptGroup:insert(gossip_click)
			scriptGroup:insert(game_click)
			objectGroup:insert(scriptGroup)

			gossip_click:addEventListener("tap", function() --대화 클릭 시 페이지 이동
				if(composer.getVariable("talk6_status") == "fin") then
					script.text = "이미 대화를 끝냈습니다."
				else
					composer.removeScene("view02_npc_fallgame")
					composer.gotoScene("view02_talk_fallgame")
				end
			end)

			game_click:addEventListener("tap", function() 
				if(composer.getVariable("fallgame_status") == "success") then
					script.text = "이미 게임을 끝냈습니다."
				else 
					acceptQuest()
				end
			end)
		end) --가상함수
	end 

	--npc 말풍선 및 수락 텍스트
	local function talkWithNPC( event )
		if(composer.getVariable("fallgame_status") == "success" and composer.getVariable("talk6_status") == "fin") then
			local section = display.newRect(display.contentWidth/2, display.contentHeight*0.9, display.contentWidth*3, display.contentWidth*0.9)
				section:setFillColor(0.35, 0.35, 0.35, 0.35)

			local script = display.newText("퀘스트를 완료하였습니다. ", display.contentWidth*0.1, display.contentHeight*0.73, "font/DOSGothic.ttf", 80)
				script.size = 30
				script:setFillColor(1)
			local scriptGroup = display.newGroup()

			scriptGroup:insert(section)
			scriptGroup:insert(script)
			objectGroup:insert(scriptGroup)

			section:addEventListener("tap", function() scriptGroup.alpha = 0 gossipOrGame() end)
		end

		speechbubble_exmark.alpha = 0
		speechbubble.alpha = 1
		speech.alpha = 1
		scriptGroup.alpha = 1

		if(composer.getVariable("fallgame_status") ~= "success") then			
			speech.text = "인문관 꼭대기에서\n뭐가 떨어진다는데..?"
		else
			speech.text = "너 정말 날쌔다!"
		end
		speech.size = 20
		speech:setFillColor(0)

		if(composer.getVariable("fallgame_status") ~= "success" or composer.getVariable("talk6_status") ~= "fin") then
			gossipOrGame()
		end
	end


	local function goBackToMap(event) 
		composer.gotoScene("view05_main_map")
	end

	loadsave.saveTable(loadedSettings,"settings.json")

	speechbubble_exmark:addEventListener("tap", talkWithNPC)
	map:addEventListener("tap", goBackToMap)


 	objectGroup:insert(npc)
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