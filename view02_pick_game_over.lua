--fallgame 통과하는 게임 종료된 화면

local composer = require( "composer" )
local scene = composer.newScene()
--local loadsave = require( "loadsave" )

function scene:create( event )
	local sceneGroup = self.view
	
	local background = display.newImageRect("image/background.png",display.contentWidth, display.contentHeight) ---배경
	background.x,background.y = display.contentWidth/2,display.contentHeight/2
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

	local score1 = composer.getVariable("score1")

	local function backtogame(event) --실패할 경우 다시 게임으로 돌아가기
		if event.phase == "began" then
			audio.pause(home)
			composer.removeScene("view02_pick_game_over")
			composer.gotoScene("view02_pick_game")
		end
	end
	--close 버튼
	local close = display.newImageRect("image/닫기.png", 80, 80)
	close.x, close.y = 1200, 80
	close.alpha = 0

	local function gomap(event) -- 게임 pass 후 map으로 넘어감
		if event.phase == "began" then--view20ring
			audio.pause(home)
			composer.removeScene("view02_pick_game_over")
			composer.gotoScene("pre_pickGame") 
		end
	end

	local backgame1 =display.newImage("image/클리어창.png") --성공할 경우
	backgame1.x, backgame1.y = display.contentWidth/2, display.contentHeight/2
	backgame1.alpha = 0
	sceneGroup:insert(backgame1)

	local backgame2 =display.newImage("image/실패창.png") --실패할 경우
	backgame2.x, backgame2.y = display.contentWidth/2, display.contentHeight/2
	backgame2.alpha = 0
	sceneGroup:insert(backgame2)

	local lastText = display.newText("게임을 다시 시작하려면 고양이를 클릭하세요!", 600, 80)
	lastText.size = 40
	lastText.alpha = 0

	if (score1 == -1) then ---score1이 -1일 때 fail
		backgame2.alpha = 1
		close.alpha = 1
		lastText.alpha = 1
		close:addEventListener("touch", gomap) --close버튼을 눌렀을 때 gomap
		backgame2:addEventListener("touch",backtogame) --우는고양이를 눌렀을 때 다시하기
	else ---score1이 5일 때 sucess
		backgame1.alpha = 1
		close.alpha = 1
		lastText.alpha = 1
		close:addEventListener("touch",gomap)
		backgame1:addEventListener("touch",backtogame) --행복한고양이 눌렀을 때 다시하기
	end
	sceneGroup:insert(close)
	sceneGroup:insert(lastText)

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
		composer.removeScene("view03_jump_game_over")
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