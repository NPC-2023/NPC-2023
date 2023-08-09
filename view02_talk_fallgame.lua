-----------------------------------------------------------------------------------------
--
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()
local loadsave = require( "loadsave" )

function scene:create( event )
	local sceneGroup = self.view

	local objectGroup = display.newGroup()

	
	local background = display.newImageRect("image/npc/place2.jpg", display.contentWidth*3, display.contentHeight)
	background.x = display.contentCenterX
    background.y = display.contentCenterY

 	local npc = display.newImageRect("image/npc/npc3.png", display.contentWidth/1.5, display.contentHeight/3)
	npc.x, npc.y = display.contentWidth*0.9, display.contentHeight*0.75
	npc.xScale = -1
	objectGroup:insert(npc)

	local cat = display.newImageRect("image/npc/cat_back.png",  display.contentWidth/2, display.contentHeight/2.5)
	cat.x, cat.y = display.contentWidth*0.5, display.contentHeight*0.88
	objectGroup:insert(cat)

	local map = display.newImageRect("image/npc/map_goback.png", display.contentWidth/2.5, display.contentHeight/4)
	map.x, map.y = display.contentWidth*1.6, display.contentHeight*0.15

	local map_text = display.newText("맵 보기", map.x, map.y, "font/DOSGothic.ttf")
	map_text.size = 30

	local gossip_script = 'a'
	local game_script = 'a'

	local loadedSettings = loadsave.loadTable( "settings.json" )
	mainName = loadedSettings.name
	loadsave.saveTable(loadedSettings,"settings.json")

	--대화창
		--스크립트
	local section = display.newRect(display.contentWidth/2, display.contentHeight*0.9, display.contentWidth*3, display.contentWidth*0.9)
	section:setFillColor(0.35, 0.35, 0.35, 0.35)
	objectGroup:insert(section)

	--대사
	local t = {}
	t[1] = display.newText("(처음 보는 고양이 인데..?)", display.contentWidth*0.1, display.contentHeight*0.73, "font/NanumSquareRoundR.ttf", 25)
	t[2] = display.newText("뭘 그렇게 빤히 보는거냥?! 나는 "..mainName.."이다냥!", display.contentWidth*0.1, display.contentHeight*0.73, "font/NanumSquareRoundR.ttf", 25)
	t[3] = display.newText("우리 대화한 횟수가.. " ..loadedSettings.talk[6].."번 이구나!", display.contentWidth*0.1, display.contentHeight*0.73, "font/NanumSquareRoundR.ttf", 25)
	t[4] = display.newText("응! 앞으로 더 친해지자냥!", display.contentWidth*0.1, display.contentHeight*0.73, "font/NanumSquareRoundR.ttf", 25)	
	t[5] = display.newText("인문관 자주 놀러와~", display.contentWidth*0.1, display.contentHeight*0.73, "font/NanumSquareRoundR.ttf", 25)	
	t[6] = display.newText("호감도가 1 상승 했습니다.", display.contentWidth*0.1, display.contentHeight*0.73, "font/NanumSquareRoundR.ttf", 25)

	local next_text = display.newText("다음 ▶", display.contentWidth*1.5, display.contentHeight*0.9, "font/NanumSquareRoundR.ttf", 25)
	
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
			composer.setVariable("talk6_status", "fin")
			composer.removeScene("view02_talk_fallgame")
			composer.gotoScene("view02_npc_fallgame")
		end
	end

	local function goBackToMap(event) 
		composer.gotoScene("view05_main_map")
	end

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