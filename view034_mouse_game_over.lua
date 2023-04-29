-- 두더지 게임 점수

local composer = require( "composer" )
local physics = require("physics")
local scene = composer.newScene()
local loadsave = require( "loadsave" )
local json = require( "json" )

function scene:create( event )
	local sceneGroup = self.view
	
	loadedEndings = loadsave.loadTable( "endings.json" )
	loadedSettings = loadsave.loadTable( "settings.json" )

	local background = display.newImageRect("image/mouse/background.png",display.contentWidth, display.contentHeight) ---배경
	background.x,background.y = display.contentWidth/2,display.contentHeight/2
	sceneGroup:insert(background)

	local background1 = display.newRect(display.contentWidth/2, display.contentHeight/2, display.contentWidth, display.contentHeight)
	
	background1:setFillColor(0)
	transition.to(background1,{alpha=0.5,time=1000}) -- 배경 어둡게
	sceneGroup:insert(background1)

	
-- 배경 어둡게
	
	local background1 = display.newRect(display.contentWidth/2, display.contentHeight/2, display.contentWidth, display.contentHeight)
	
	background1:setFillColor(0)
	transition.to(background1,{alpha=0.5,time=1000})
	sceneGroup:insert(background1)

	--[[local board =display.newImageRect("이미지/미니게임/미니게임_게임완료창.png",display.contentWidth/3.6294896, display.contentHeight/2.83122739)
	board.x , board.y = display.contentWidth/2, display.contentHeight/2
	board.alpha = 0.5
	transition.to(board,{alpha=1,time=1000})
	sceneGroup:insert(board)]]
	
	local score3 = composer.getVariable("score2")

	local function backtogame(event) --실패할 경우 다시 게임으로 돌아가기
		if event.phase == "began" then 
				audio.pause(home)
				composer.removeScene("view034_mouse_game_over")
				composer.gotoScene("view03_mouse_game")
		end
	end

	--close 버튼
	local clear_close = display.newImageRect("image/설정/닫기.png", 150, 150)
	clear_close.x, clear_close.y = 950, 400
	clear_close.alpha = 0
	

	local fail_close = display.newImageRect("image/설정/닫기.png", 150, 150)
	fail_close.x, fail_close.y = 950, 400
	fail_close.alpha = 0
	
	
	local function gomap(event) -- 게임 pass 후 넘어감
		if event.phase == "began" then--view20ring
				audio.pause(home)

				-- 퀘스트 완료 목록에 저장
				loadedSettings.total_success = loadedSettings.total_success + 1
				loadedSettings.total_success_names[loadedSettings.total_success] = "쥐 잡기"
				loadsave.saveTable(loadedSettings,"settings.json")

				composer.setVariable("mousegame_status", "success")
				composer.removeScene("view034_mouse_game_over")
				composer.gotoScene( "view05_main_map" )
		end
	end

	local backtomap =display.newImageRect("image/mouse/클리어창.png",display.contentWidth/5,display.contentHeight/5) --성공할 경우
	backtomap.x, backtomap.y = display.contentWidth/2, display.contentHeight/2
	backtomap.alpha = 0
	sceneGroup:insert(backtomap)

	local backtomap1 =display.newImageRect("image/mouse/미니게임_지도로 돌아가기 버튼.png",display.contentWidth/6.112,display.contentHeight/17.3050)
	backtomap1.x, backtomap1.y = display.contentWidth/2, display.contentHeight/1.65466
	sceneGroup:insert(backtomap1)
	backtomap1.alpha = 0
	backtomap1:addEventListener("touch",gomap)
	


	local backgame =display.newImage("image/mouse/fail.png") --실패할 경우
	backgame.x, backgame.y = display.contentWidth/2, display.contentHeight/2
	backgame.alpha = 0
	sceneGroup:insert(backgame)

	if score3 < 15 then
		backgame.alpha = 1
		fail_close.alpha = 1
		fail_close:addEventListener("touch",backtogame)
	else
		backtomap.alpha = 1
		backtomap1.alpha = 1
		clear_close.alpha = 1
		clear_close:addEventListener("touch",gomap)
	end
	sceneGroup:insert(fail_close)
	sceneGroup:insert(clear_close)

	
-- map으로 돌아가기

	local function gomap(event)
		if event.phase == "began" then
				audio.pause(home)
				composer.removeScene("view034_mouse_game_over")
				composer.gotoScene( "view05_main_map" )
		end
	end


	
-- 점수에 따라 돈 획득/db에 저장
	local loadedSettings = loadsave.loadTable( "settings.json" ) 
	loadedSettings.money = loadedSettings.money + score3
	loadsave.saveTable(loadedSettings, "settings.json")

	
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
