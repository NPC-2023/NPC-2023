-----------------------------------------------------------------------------------------
--
-- view20_talk_moenygame.lua
-- //230312 해야될것 . 영구저장 변수 설정(호감도, 퀘스트 끝냈는지 여부(대화, 게임 나눠서))
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()
local loadsave = require( "loadsave" )

function scene:create( event )
	local sceneGroup = self.view

	local objectGroup = display.newGroup()

	local background = display.newImageRect("image/frontgate/gate.jpg", 960, 640)
	background.x = display.contentCenterX
    background.y = display.contentCenterY

 	local npc = display.newImageRect("image/frontgate/security.png", 200, 200)
	npc.x = display.contentCenterX*1.7
	npc.y = display.contentCenterY*1.2
	
	local cat = display.newImageRect("image/frontgate/cat1.png", 200, 191)
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
	t[1] = display.newText("요즘 사람이 너무 많아서 출입자 통제가 힘드네....", display.contentWidth*0.4, display.contentHeight*0.73, "font/NanumSquareRoundR.ttf", 30)
	t[2] = display.newText("내가 좀 도와줄까냥?", display.contentWidth*0.3, display.contentHeight*0.73, "font/NanumSquareRoundR.ttf", 30)
	t[3] = display.newText("음.. 그럼 정문 앞에서 \n외부인이 출입하지 못하도록 막아주겠니?!", display.contentWidth*0.4, display.contentHeight*0.73, "font/NanumSquareRoundR.ttf", 30)
	t[4] = display.newText("그럼 내가 냥냥펀치로 모조리 날려버릴게냥!", display.contentWidth*0.3, display.contentHeight*0.73, "font/NanumSquareRoundR.ttf", 30)
	t[5] = display.newText("허허...녀석 참 든든하구나.\n2000점을 획득하면 성공이란다. \n그럼 부탁하마" ..mainName.. "아~", display.contentWidth*0.4, display.contentHeight*0.73, "font/NanumSquareRoundR.ttf", 30)	
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
			composer.setVariable("talk2_status", "fin")
			composer.removeScene("view18_talk_frontgate_game")
			composer.gotoScene("view18_npc_frontgate_Game")
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