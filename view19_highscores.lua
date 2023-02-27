
local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

-- highscores.lua 엔딩화면 (성공하거나 실패했을때 나오는 화면 ) 성공일경우 버튼누르면 -> 메인화면으로 이동, 실패하면 -> 첫 play 화면으로 이동  

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen

    -- Load the previous scores

	local background = display.newImageRect("image/frontgate/gate.jpg",1280, 720) --엔딩화면 배경
	background.x,background.y = display.contentWidth/2,display.contentHeight/2
	sceneGroup:insert(background)

	local background1 = display.newRect(display.contentWidth/2, display.contentHeight/2, 1280, 720) --display.contentWidth, display.contentHeight
	
	background1:setFillColor(0)
	transition.to(background1,{alpha=0.5,time=1000}) --배경 어둡게
	sceneGroup:insert(background1)

	local score3 = composer.getVariable("score")

	local function backtogame(event) --실패할 경우 다시 게임으로 돌아가기
		if event.phase == "began" then 
				composer.removeScene("highscores")
				composer.gotoScene("view17_menu")--시작화면으로 
		end
	end

	--close 버튼
	local clear_close = display.newImageRect("image/frontgate/exit.png", 150, 150)--나가기 버튼 
	clear_close.x, clear_close.y = 500, 500  
	clear_close.alpha = 0
	

	local fail_close = display.newImageRect("image/frontgate/retry.png", 150, 150)--다시하기 버튼 
	fail_close.x, fail_close.y = 500, 500 
	fail_close.alpha = 0
	
	
	local function gomap(event) -- 게임 pass 후 메인화면(맵)으로 넘어가기 
		if event.phase == "began" then
				composer.removeScene("highscores")
				composer.gotoScene( "view18_npc_frontgate_game" )
		end
	end

	local backtomap = display.newImage("image/frontgate/clear.png") --성공할 경우
	backtomap.x, backtomap.y = display.contentWidth/2, display.contentHeight/2
	backtomap.alpha = 0
	sceneGroup:insert(backtomap)
	

	local backgame = display.newImage("image/frontgate/fail.png") --실패할 경우
	backgame.x, backgame.y = display.contentWidth/2, display.contentHeight/2
	backgame.alpha = 0
	sceneGroup:insert(backgame)

	if score3 < 0 then
		backgame.alpha = 1
		fail_close.alpha = 1
		fail_close:addEventListener("touch",backtogame)--실패 
	else
		backtomap.alpha = 1
		clear_close.alpha = 1
		clear_close:addEventListener("touch",gomap)--성공 
	end
	sceneGroup:insert(fail_close)
	sceneGroup:insert(clear_close)

end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen

	end
end


-- hide()
function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is on screen (but is about to go off screen)

	elseif ( phase == "did" ) then
		-- Code here runs immediately after the scene goes entirely off screen
		composer.removeScene( "highscores" )
	end
end


-- destroy()
function scene:destroy( event )

	local sceneGroup = self.view
	-- Code here runs prior to the removal of scene's view

end


-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene
