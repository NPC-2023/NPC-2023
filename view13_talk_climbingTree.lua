-----------------------------------------------------------------------------------------
--
-- view17_talk_boongmake_game.lua
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()
local loadsave = require( "loadsave" )

function scene:create( event )
	local sceneGroup = self.view

	local objectGroup = display.newGroup()

	local background = display.newImageRect("image/frontgate/gate.jpg", 1280, 720 )--배경이미지 
	background.x = display.contentCenterX
	background.y = display.contentCenterY

	local npc = display.newImageRect("image/frontgate/security.png", 200, 200)--경비원 이미지 
	npc.x = display.contentCenterX*1.7
	npc.y = display.contentCenterY*1.2
	
	local cat = display.newImageRect("image/frontgate/cat1.png", 200, 191)--고양이 이미지 108 99
	cat.x = display.contentCenterX
	cat.y = display.contentHeight - 100
	objectGroup:insert(cat)

	local map = display.newImageRect("image/npc/map_goback.png", 150, 150)
	map.x, map.y = display.contentWidth*0.88, display.contentHeight*0.15

	local map_text = display.newText("맵 보기", map.x, map.y, "font/DOSGothic.ttf")
	map_text.size = 40

	local gossip_script = 'a'
	local game_script = 'a'

	local loadedSettings = loadsave.loadTable( "settings.json" )
	mainName = loadedSettings.name
	loadsave.saveTable(loadedSettings,"settings.json")

	--대화창
	local section = display.newRect(display.contentWidth/2, display.contentHeight*0.8, display.contentWidth, display.contentHeight*0.3)
	section:setFillColor(0.35, 0.35, 0.35, 0.35)
	objectGroup:insert(section)

	--대사
	local t = {}
	t[1] = display.newText("흐음... 목화솜으로 무얼 만들까...?", display.contentWidth*0.3, display.contentHeight*0.73, "font/NanumSquareRoundR.ttf", 30)
	t[2] = display.newText("으아... 인간 세상은 너무 춥다냥...", display.contentWidth*0.3, display.contentHeight*0.73, "font/NanumSquareRoundR.ttf", 30)
	t[3] = display.newText(mainName.. "아! 많이 추워?\n 그럼 과제 하고 남은 목화솜으로 고양이 옷을 만들어줄게", display.contentWidth*0.4, display.contentHeight*0.73, "font/NanumSquareRoundR.ttf", 30)
	t[4] = display.newText("감동이다냥! \n 내가 나무를 잘 타니 나무 위에 있는 목화솜을 전부 가져올게냥.", display.contentWidth*0.4, display.contentHeight*0.73, "font/NanumSquareRoundR.ttf", 30)
	t[5] = display.newText("나무가 높으니 조심해서 갔다와 " ..mainName.. "아!", display.contentWidth*0.3, display.contentHeight*0.73, "font/NanumSquareRoundR.ttf", 30)	
	t[6] = display.newText("호감도가 1 상승 했습니다.", display.contentWidth*0.3, display.contentHeight*0.73, "font/NanumSquareRoundR.ttf", 30)

	local next_text = display.newText("다음 ▶", display.contentWidth*0.8, display.contentHeight*0.9, "font/NanumSquareRoundR.ttf", 30)
	
	local i, j = 1, 1
	for i = 2, 6 do
		-- b[i].alpha = 0
		t[i].alpha = 0
	end

	for i = 1, 6 do
		t[i]:setFillColor(1)
		objectGroup:insert(t[i])
	end

	-- 화면전환
	local function next1()
		if j > 1 and j < 7 then				
			t[j - 1].alpha = 0
			t[j].alpha = 1
		end

		j = j + 1

		if j == 7 then
			composer.setVariable("talk1_status", "fin")
			composer.removeScene("view13_talk_climbingTree")
			composer.gotoScene("view13_npc_climbingTree")
		end
	end

	local function goBackToMap(event) 
		composer.gotoScene("view05_main_map")
	end

 	objectGroup:insert(npc)
 	objectGroup:insert(map)
 	objectGroup:insert(map_text)
 	objectGroup:insert(next_text)

 	sceneGroup:insert(background)
 	sceneGroup:insert(objectGroup)

 	map:addEventListener("tap", goBackToMap)
 	next_text:addEventListener("tap", next1)

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