-- 두더지 게임 점수

local composer = require( "composer" )
local scene = composer.newScene()
local loadsave = require( "loadsave" )

function scene:create( event )
	local sceneGroup = self.view
	
	-- 배경객체
	local background = display.newImageRect("이미지/미니게임/미니게임_빨강마을/미니게임_두더지게임 배경(빨강마을).png",display.contentWidth, display.contentHeight)
	background.x,background.y = display.contentWidth/2,display.contentHeight/2
	sceneGroup:insert(background)

-- 배경 어둡게
	
	local background1 = display.newRect(display.contentWidth/2, display.contentHeight/2, display.contentWidth, display.contentHeight)
	
	background1:setFillColor(0)
	transition.to(background1,{alpha=0.5,time=1000})
	sceneGroup:insert(background1)
	
-- map으로 돌아가기

	local function gomap(event)
		if event.phase == "began" then
				composer.removeScene("view06Dudu")
				composer.gotoScene( "view01Map" )
		end
	end

-- 점수판
	local board =display.newImageRect("이미지/미니게임/미니게임_게임완료창.png",display.contentWidth/3.6294896, display.contentHeight/2.83122739)
	board.x , board.y = display.contentWidth/2, display.contentHeight/2
	board.alpha = 0.5
	transition.to(board,{alpha=1,time=1000})
	sceneGroup:insert(board)

	score3 = composer.getVariable("score2")
	local showScore1 = display.newText(score3,display.contentWidth/2, display.contentHeight/1.9,"font/잘풀리는오늘 Medium.ttf") 
	showScore1:setFillColor(1,0,0)
	showScore1.size = 60
	sceneGroup:insert(showScore1)
	
-- 점수에 따라 돈 획득/db에 저장
	local loadedSettings = loadsave.loadTable( "settings.json" ) 
	loadedSettings.money = loadedSettings.money + score3
	loadsave.saveTable(loadedSettings, "settings.json")

	local backtomap =display.newImageRect("이미지/미니게임/미니게임_지도로 돌아가기 버튼.png",display.contentWidth/6.112,display.contentHeight/17.3050)
	backtomap.x, backtomap.y = display.contentWidth/2, display.contentHeight/1.65466
	sceneGroup:insert(backtomap)
	backtomap:addEventListener("touch",gomap)
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
