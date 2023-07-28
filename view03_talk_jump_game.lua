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

	
	local background = display.newImageRect("image/npc/place4.jpg", 960, 640)
	background.x = display.contentCenterX
    background.y = display.contentCenterY

 	local npc = display.newImageRect("image/npc/npc1.png", 200, 200)
	npc.x, npc.y = display.contentWidth*0.7, display.contentHeight*0.6
	npc.xScale = -1

	local cat = display.newImageRect("image/npc/cat_back.png", 200, 200)
	cat.x, cat.y = display.contentWidth*0.5, display.contentHeight*0.88
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
	t[1] = display.newText("여기서 뭐하고 있냥?", display.contentWidth*0.3, display.contentHeight*0.73, "font/NanumSquareRoundR.ttf", 30)
	t[2] = display.newText("풀숲에 뭐가 떨어져 있어서 보고 있었어.", display.contentWidth*0.3, display.contentHeight*0.73, "font/NanumSquareRoundR.ttf", 30)
	t[3] = display.newText("흠.. 잘 안 보이네? 저게 뭘까? ", display.contentWidth*0.3, display.contentHeight*0.73, "font/NanumSquareRoundR.ttf", 30)
	t[4] = display.newText("우와 저건 내가 좋아하는 츄르다냥!", display.contentWidth*0.3, display.contentHeight*0.73, "font/NanumSquareRoundR.ttf", 30)
	t[5] = display.newText("정말? 원한다면 네가 가져도 돼!", display.contentWidth*0.3, display.contentHeight*0.73, "font/NanumSquareRoundR.ttf", 30)	
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
			composer.setVariable("talk5_status", "fin")
			composer.removeScene("view03_talk_jump_game")
			composer.gotoScene("view03_npc_jump_game")
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