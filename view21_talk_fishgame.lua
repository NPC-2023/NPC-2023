-----------------------------------------------------------------------------------------
--
-- view21_talk_fishgame.lua
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
	t[1] = display.newText("못 보던 고양이 잖아! 이름이 뭐야?", display.contentWidth*0.3, display.contentHeight*0.73, "font/NanumSquareRoundR.ttf", 30)
	t[2] = display.newText(mainName .. "(이)다냥", display.contentWidth*0.3, display.contentHeight*0.73, "font/NanumSquareRoundR.ttf", 30)
	t[3] = display.newText(mainName .. "(이)? 별명으로 부르고 싶은데..\n".. mainName.." 어때? ", display.contentWidth*0.3, display.contentHeight*0.73, "font/NanumSquareRoundR.ttf", 30)
	t[4] = display.newText("(맘에 들진 않지만..) 좋다냥~", display.contentWidth*0.3, display.contentHeight*0.73, "font/NanumSquareRoundR.ttf", 30)
	t[5] = display.newText("앞으로 만나면 " ..mainName.." 라고 부를게!" ..mainName .. " 흐흐 ", display.contentWidth*0.3, display.contentHeight*0.73, "font/NanumSquareRoundR.ttf", 30)	

	local next_text = display.newText("다음 ▶", display.contentWidth*0.8, display.contentHeight*0.9, "font/NanumSquareRoundR.ttf", 30)
	
	local i, j = 1, 1
	for i = 2, 5 do
		-- b[i].alpha = 0
		t[i].alpha = 0
	end

	for i = 1, 5 do
		t[i]:setFillColor(1)
		objectGroup:insert(t[i])
	end

	-- 화면전환
	local function next1()
		if j > 1 and j < 6 then				
			t[j - 1].alpha = 0
			t[j].alpha = 1
		end

		j = j + 1

		if j == 6 then
			composer.setVariable("talk_status", "fin")
			composer.removeScene("view21_talk_fishGame")
			composer.gotoScene("view21_npc_fishGame")
		end
	end

	-- local function gossipWithNPC( event )
	-- 	--스크립트 배경(반투명)
	-- 	local section = display.newRect(display.contentWidth/2, display.contentHeight*0.8, display.contentWidth, display.contentHeight*0.3)
	-- 	section:setFillColor(0.35, 0.35, 0.35, 0.35)
		
	-- 	-- --스크립트 파일 열기
	-- 	-- local thePath = system.pathForFile("txt\\test.txt", system.DocumentsDirectory )
	-- 	-- -- if thePath then
	-- 	-- -- 	print("@@@@@@@@path is" .. thePath)
	-- 	-- -- else
	-- 	-- -- 	print("@@@@@@@@@@@@@err0or")
	-- 	-- -- end

	-- 	-- local script_file = io.open(thePath, "r")
	-- 	-- -- local lines = io.read()
	-- 	-- if script_file then
	-- 	-- 	for line in script_file:lines() do 
	-- 	-- 		print(line)
	-- 	-- 		script.alpha = 1

	--     -- 		local script = display.newText(line, section.x+30, section.y-100, "font/DOSGothic.ttf", 80)
	-- 	-- 		script.size = 30
	-- 	-- 		script:setFillColor(1)
	-- 	-- 		script.x, script.y = display.contentWidth*0.2, display.contentHeight*0.789	
	-- 	-- 		script.alpha = 0 

	-- 	-- 		objectGroup:insert(script)
	--  	-- 	end
	--  	-- else
	--  	-- 	print("file not exists")
	--  	-- end

 	-- 	objectGroup:insert(section)	
	-- end


	local function goBackToMap(event) 
		composer.gotoScene("view05_main_map")
	end

 	objectGroup:insert(npc)
 	objectGroup:insert(cat)
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