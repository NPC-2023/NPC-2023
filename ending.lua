-----------------------------------------------------------------------------------------
--
-- ending.lua
--
-----------------------------------------------------------------------------------------
local loadsave = require( "loadsave" )
local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

	local objectGroup = display.newGroup()

	local background = display.newImageRect("image/게임시작/5.png", display.contentWidth, display.contentHeight)
	background.x, background.y = display.contentWidth/2, display.contentHeight/2

	--대화창
	local section = display.newRect(display.contentWidth/2, display.contentHeight*0.8, display.contentWidth, display.contentHeight*0.3)
	section:setFillColor(0.35, 0.35, 0.35, 0.35)
	objectGroup:insert(section)

	local loadedSettings = loadsave.loadTable( "settings.json" )
	local i, j = 1, 1
	
	--가장 대화를 많이한 건물 찾는 코드
	local biggest = 1 --biggest = 0 일 경우 대화를 하나도 하지않았을때 오류발생
	for i = 1, 8 do
		if(loadedSettings.talk[i] > biggest) then
			biggest = i
		end
	end

	local ending_building = loadedSettings.buildings_index[biggest]

	--대화창
 	--대사
	local t = {}
	t[1] = display.newText("인간 세계에 내려온지 벌써 16일..", display.contentWidth * 0.5, display.contentHeight * 0.93 - 100, "font/NanumSquareRoundR.ttf", 30)
	t[2] = display.newText("그동안 여러 곳에서 수 많은 학생들을 만났지.", display.contentWidth * 0.5, display.contentHeight * 0.93 - 100, "font/NanumSquareRoundR.ttf", 30)
	t[3] = display.newText("그 결과 나," ..loadedSettings.name.. "는.. ", display.contentWidth * 0.5, display.contentHeight * 0.93 - 100, "font/NanumSquareRoundR.ttf", 30)
	t[4] = display.newText(ending_building.. "을 수호하는 고양이가 되었어.\n 특히 이 곳에서 많은 학생들을 만났었지.", display.contentWidth * 0.5, display.contentHeight * 0.93 - 100, "font/NanumSquareRoundR.ttf", 30)
	t[5] = display.newText("난 다시 왕국으로 돌아갈 시간이야. 학교는 나 덕분에 안전해졌으니 걱정말라냥!",display.contentWidth * 0.5, display.contentHeight * 0.93 - 100, "font/NanumSquareRoundR.ttf", 30)
	t[6] = display.newText("다음에 또 만나자. \n 안녕! 솜솜이들!",display.contentWidth * 0.5, display.contentHeight * 0.93 - 100, "font/NanumSquareRoundR.ttf", 30)
	t[7] = display.newText("게임이 종료되었습니다.",display.contentWidth * 0.5, display.contentHeight * 0.93 - 100, "font/NanumSquareRoundR.ttf", 30)

	loadsave.saveTable(loadedSettings,"settings.json")

	local next_text = display.newText("다음 ▶", display.contentWidth*0.8, display.contentHeight*0.9, "font/NanumSquareRoundR.ttf", 30)
	next_text:setFillColor(white)

    for i = 2, 7 do
		t[i].alpha = 0
	end

	for i = 1, 7 do
		t[i]:setFillColor(white)
		objectGroup:insert(t[i])
	end

	-- 화면전환
	local function next1()
		if j > 1 and j < 8 then
			t[j - 1].alpha = 0
			t[j].alpha = 1
		end

		j = j + 1

		if j == 9 then
			composer.removeScene("ending")
			composer.gotoScene("view01_1_start_game")
		end
	end

	objectGroup:insert(section)
	objectGroup:insert(next_text)

	sceneGroup:insert(background)
 	sceneGroup:insert(objectGroup)

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