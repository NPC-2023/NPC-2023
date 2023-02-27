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


	local function backtogame(event) --실패할 경우 다시 게임으로 돌아가기
		if event.phase == "began" then 
				composer.removeScene("view02_over")
				composer.gotoScene("game")
		end
	end
	--close 버튼
	local clear_close = display.newImageRect("image/carrot.png", 150, 150)
	clear_close.x, clear_close.y = 950, 400
	clear_close.alpha = 0

	local fail_close = display.newImageRect("image/carrot.png", 150, 150)
	fail_close.x, fail_close.y = 950, 400
	fail_close.alpha = 0

	local function gomap(event) -- 게임 pass 후 넘어감
			if event.phase == "began" then--view20ring
					composer.removeScene("view02_fall_game_over")
					composer.gotoScene( "view01" )
			end
	end
	local backtomap =display.newImageRect("image/carrot.png",display.contentWidth/5,display.contentHeight/5) --성공할 경우
	backtomap.x, backtomap.y = display.contentWidth/2, display.contentHeight/2
	backtomap.alpha = 0
	sceneGroup:insert(backtomap)

	local backgame =display.newImage("image/carrot.png") --실패할 경우
	backgame.x, backgame.y = display.contentWidth/2, display.contentHeight/2
	backgame.alpha = 0
	sceneGroup:insert(backgame)


	--if문

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
		composer.removeScene("view02_over")
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