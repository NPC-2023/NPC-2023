
local composer = require( "composer" )
local physics = require("physics")
local scene = composer.newScene()
local loadsave = require( "loadsave" )
local json = require( "json" )

function scene:create( event )
	local sceneGroup = self.view

	physics.start()

	local loadedEndings = loadsave.loadTable( "endings.json" )
	local loadedSettings = loadsave.loadTable( "settings.json" )

	
	local background = display.newImageRect("image/pick/background.png",display.contentWidth, display.contentHeight) ---배경
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
		composer.removeScene("view02_pick_game_over")
		composer.gotoScene("view02_pick_game")
	end
	--close 버튼
	local close = display.newImageRect("image/pick/닫기.png", 80, 80)
	-- close.x, close.y = 1200, 80 -> 맵보기 아이콘이랑 겹쳐있어 닫기 버튼을 누르면 맵보기 아이콘도 같이 눌러짐
	close.x, close.y = 1200, 30
	close.alpha = 0

	local function gomap1(event) -- 게임 pass 후 map으로 넘어감
		composer.setVariable("successPickGame", "success")
		loadedSettings.toal_success = loadedSettings.toal_success + 1
		-- 로드세이브에 저장될 이름 수정
		--loadedSettings.toal_success_names[loadedSettings.toal_success] = "학생증 찾기"
		loadedSettings.toal_success_names[loadedSettings.toal_success] = "Pick Game"
		loadsave.saveTable(loadedSettings,"Pick Game")
		loadsave.saveTable(loadedSettings,"settings.json")
		composer.removeScene("view02_pick_game_over")
		composer.gotoScene("view02_npc_pickGame") 
	end

	local function gomap2(event) -- 게임 fail 후 map으로 넘어감
		composer.removeScene("view02_pick_game_over")
		composer.gotoScene("view05_main_map") 
	end

	local backgame1 =display.newImage("image/pick/클리어창.png") --성공할 경우
	backgame1.x, backgame1.y = display.contentWidth/2, display.contentHeight/2
	backgame1.alpha = 0
	sceneGroup:insert(backgame1)

	local backgame2 =display.newImage("image/pick/실패창.png") --실패할 경우
	backgame2.x, backgame2.y = display.contentWidth/2, display.contentHeight/2
	backgame2.alpha = 0
	sceneGroup:insert(backgame2)

	local lastText = display.newText("게임을 다시 시작하려면 고양이를 클릭하세요!", 600, 80)
	lastText.size = 40
	lastText.alpha = 0


	--[[-----음악

    -- showoverlay 함수 사용 option
    local options = {
        isModal = true
    }

    --샘플 볼륨 이미지
    local volumeButton = display.newImageRect("image/설정/설정.png", 100, 100)
    volumeButton.x,volumeButton.y = display.contentWidth * 0.95, display.contentHeight * 0.12
    sceneGroup:insert(volumeButton)


    --샘플볼륨함수--
    local function setVolume(event)
        composer.showOverlay( "volumeControl", options )
    end
    volumeButton:addEventListener("tap",setVolume)

    local home = audio.loadStream( "music/music3.mp3" )
    audio.setVolume( loadedEndings.logValue )--loadedEndings.logValue
    audio.play(home)


    -------------]]


	if (score1 == -1) then ---score1이 -1일 때 fail
		backgame2.alpha = 1
		close.alpha = 1
		lastText.alpha = 1
		close:addEventListener("tap", gomap2) --close버튼을 눌렀을 때 gomap
		backgame2:addEventListener("tap",backtogame) --우는고양이를 눌렀을 때 다시하기
	elseif (score1 == 5) then---score1이 5일 때 sucess
		backgame1.alpha = 1
		close.alpha = 1
		close:addEventListener("tap",gomap1)
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