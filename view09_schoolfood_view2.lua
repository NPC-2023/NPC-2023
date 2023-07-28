-----------------------------------------------------------------------------------------
--
-- view2.lua--game over창
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local physics = require("physics")
local scene = composer.newScene()
local loadsave = require( "loadsave" )
local json = require( "json" )

function scene:create( event )
	local sceneGroup = self.view

	local loadedEndings = loadsave.loadTable( "endings.json" )
	local loadedSettings = loadsave.loadTable( "settings.json" )

	-- 2023.07.04 edit by jiruen // 게임 성공 & 실패 bgm 추가
	local clearBgm = audio.loadStream("soundEffect/242855_게임 성공 시 효과음.ogg")
	local failBgm = audio.loadStream("soundEffect/253886_게임 실패 시 나오는 효과음.wav")


	local background = display.newImageRect("image/schoolfood/cafeteria.png", 960, 640)
	background.x = display.contentCenterX
    background.y = display.contentCenterY
	sceneGroup:insert(background)

	local background1 = display.newRect(display.contentWidth/2, display.contentHeight/2, display.contentWidth, display.contentHeight)
	
	background1:setFillColor(0)
	transition.to(background1,{alpha=0.5,time=1000}) -- 배경 어둡게
	sceneGroup:insert(background1)

	--[[local board =display.newImageRect("이미지/미니게임/미니게임_게임완료창.png",display.contentWidth/3.6294896, display.contentHeight/2.83122739)
	board.x , board.y = display.contentWidth/2, display.contentHeight/2
	board.alpha = 0.5
	transition.to(board,{alpha=1,time=1000})
	sceneGroup:insert(board)]]

	local score3 = composer.getVariable("score")

	local function backtogame(event) --실패할 경우 다시 게임으로 돌아가기
		if event.phase == "began" then 
				composer.removeScene("view09_schoolfood_view2")
				composer.gotoScene("view07_schoolfood_game")
		end
	end

	--close 버튼
	local clear_close = display.newImageRect("image/schoolfood/exit.png", 150, 150)
	clear_close.x, clear_close.y = 950, 400
	clear_close.alpha = 0
	

	local fail_close = display.newImageRect("image/schoolfood/retry.png", 150, 150)
	fail_close.x, fail_close.y = 950, 400
	fail_close.alpha = 0
	
	
	local function gomap(event) -- 게임 pass 후 넘어감
		if event.phase == "began" then--view20ring
			composer.setVariable("successSchoolFood", "success")

			loadedSettings.money = loadedSettings.money + 3

			loadedSettings.total_success = loadedSettings.total_success + 1
			loadedSettings.total_success_names[loadedSettings.total_success] = "대신 학식 받아주기"
			loadsave.saveTable(loadedSettings,"settings.json")

			composer.setVariable("food_status", "success")
			composer.removeScene("view09_schoolfood_view2")
			composer.gotoScene( "view07_npc_schoolfood_game" )
		end
	end

	local backtomap = display.newImage("image/schoolfood/클리어창.png") --성공할 경우, 원래 코드 : display.newImageRect("image/클리어창.png", display.contentWidth/5, display.contentHeight/5 )
	backtomap.x, backtomap.y = display.contentWidth/2, display.contentHeight/2
	backtomap.alpha = 0
	sceneGroup:insert(backtomap)
	

	local backgame = display.newImage("image/schoolfood/fail.png") --실패할 경우
	backgame.x, backgame.y = display.contentWidth/2, display.contentHeight/2
	backgame.alpha = 0
	sceneGroup:insert(backgame)

	if score3 < 0 then
		backgame.alpha = 1
		fail_close.alpha = 1
		-- 2023.07.04 edit by jiruen // 게임 실패 bgm 추가
		audio.play(failBgm) 
		fail_close:addEventListener("touch",backtogame)
	else
		backtomap.alpha = 1
		clear_close.alpha = 1
		-- 2023.07.04 edit by jiruen // 게임 성공 bgm 추가
		audio.play(clearBgm)
		clear_close:addEventListener("touch",gomap)
	end
	sceneGroup:insert(fail_close)
	sceneGroup:insert(clear_close)

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
