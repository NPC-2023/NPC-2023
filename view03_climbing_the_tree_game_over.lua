-----------------------------------------------------------------------------------------
--
-- view03_climbing_the_tree_game_over.lua ->나무 올라타기 게임 후 종료된 화면
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()
--local loadsave = require( "loadsave" )

function scene:create( event )
	local sceneGroup = self.view
	local background = display.newImage("image/climbing_the_tree/배경.png")
	background.x, background.y=display.contentWidth/2, display.contentHeight/2
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

	local result1 = composer.getVariable("result")
	
	-- local score3 = composer.getVariable("score")

	local function backtogame(event) --실패할 경우 다시 게임으로 돌아가기
		if event.phase == "began" then 
				composer.removeScene("view03_climbing_the_tree_game_over")
				composer.gotoScene("view03_climbing_the_tree_game_final")
		end
	end

	--close 버튼
	local clear_close = display.newImageRect("image/climbing_the_tree/닫기.png", 150, 150)
	clear_close.x, clear_close.y = 950, 400
	clear_close.alpha = 0
	

	local fail_close = display.newImageRect("image/climbing_the_tree/닫기.png", 150, 150)
	fail_close.x, fail_close.y = 950, 400
	fail_close.alpha = 0
	
	
	local function gomap(event) -- 게임 pass 후 넘어감
		if event.phase == "began" then--view20ring
				composer.removeScene("view03_climbing_the_tree_game_over")
				-- composer.gotoScene( "view01" )
				composer.gotoScene( "pre_climbingTree" )
		end
	end

	local backtomap =display.newImageRect("image/climbing_the_tree/클리어창.png", 970/4, 1187/4) --성공할 경우
	backtomap.x, backtomap.y = display.contentWidth/2, display.contentHeight/2
	backtomap.alpha = 0
	sceneGroup:insert(backtomap)
	

	local backgame =display.newImage("image/climbing_the_tree/fail.png") --실패할 경우
	backgame.x, backgame.y = display.contentWidth/2, display.contentHeight/2
	backgame.alpha = 0
	sceneGroup:insert(backgame)

	print("result: ")
	print(result1)
	if result1 == 0 then
		backgame.alpha = 1
		fail_close.alpha = 1
		fail_close:addEventListener("touch",backtogame)
	else
		backtomap.alpha = 1
		clear_close.alpha = 1
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
		composer.removeScene("view03_climbing_the_tree_game_over")
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
