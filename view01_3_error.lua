--이름 또는 색상을 선택하지 않았을 시 뜨는 에러 팝업창

local loadsave = require( "loadsave" )
local composer = require( "composer" )
local scene = composer.newScene()
local json = require( "json" ) 

function scene:create( event )
	local sceneGroup = self.view

	print("title2_1")
	local background = display.newImageRect("image/게임시작/background.png",display.contentWidth, display.contentHeight)
	background.x,background.y = display.contentWidth/2,display.contentHeight/2
	sceneGroup:insert(background)

	
	--샘플 볼륨 이미지
    local volumeButton = display.newImageRect("image/설정/설정.png", 100, 100)
    volumeButton.x,volumeButton.y = display.contentWidth * 0.5, display.contentHeight * 0.5
    sceneGroup:insert(volumeButton)

 	--샘플볼륨함수--
    local function setVolume(event)
        composer.showOverlay( "volumeControl", options )
    end
    volumeButton:addEventListener("tap",setVolume)
    

    local newgame = display.newImage("image/게임시작/새게임.png")
    newgame.x,newgame.y = display.contentWidth * 0.42, display.contentHeight * 0.9
    sceneGroup:insert(newgame)


	local titlePopup = display.newImage("image/게임시작/이름설정팝업.png")
	titlePopup.x,titlePopup.y = display.contentWidth/2,display.contentHeight * 0.8
	titlePopup.alpha = 0
	sceneGroup:insert(titlePopup)

	local titleButton = display.newImage("image/게임시작/이름결정.png")
	titleButton.x,titleButton.y = display.contentWidth/2,display.contentHeight * 0.65
	titleButton.alpha = 0
	sceneGroup:insert(titleButton)


	local function gohome(event)
		if event.phase == "began" then
				composer.removeScene("view01_3_error")
				exit.alpha=0
				composer.gotoScene("view01_2_input_name")
				
		end
	end	

	newError = display.newImage("image/게임시작/이름입력.png")
	sceneGroup:insert(newError)
	newError.x, newError.y = display.contentWidth/2,display.contentHeight/2
	exit = display.newImage("image/설정/닫기.png")
	sceneGroup:insert(exit)
	exit.x, exit.y = display.contentWidth*0.645, display.contentHeight*0.375
	exit:addEventListener("touch",gohome)
	

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