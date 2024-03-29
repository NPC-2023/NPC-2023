--이름 또는 색상을 선택하지 않았을 시 뜨는 에러 팝업창

local loadsave = require( "loadsave" )
local composer = require( "composer" )
local scene = composer.newScene()
local json = require( "json" ) 

function scene:create( event )
	local sceneGroup = self.view

	print("title2_1")
	local background = display.newImageRect("image/게임시작/background.png", 960, 480)
	background.x = display.contentCenterX
    background.y = display.contentCenterY
	sceneGroup:insert(background)

	
	--[[--샘플 볼륨 이미지
    local volumeButton = display.newImageRect("image/설정/설정.png", 100, 100)
    volumeButton.x,volumeButton.y = display.contentWidth * 0.5, display.contentHeight * 0.5
    sceneGroup:insert(volumeButton)

 	--샘플볼륨함수--
    local function setVolume(event)
        composer.showOverlay( "volumeControl", options )
    end
    volumeButton:addEventListener("tap",setVolume)]]
    

    --[[local newgame = display.newImage("image/게임시작/새게임.png")
    newgame.x,newgame.y = display.contentWidth * 0.42, display.contentHeight * 0.9
    sceneGroup:insert(newgame)]]


	local titlePopup = display.newImageRect("image/게임시작/이름설정팝업.png", display.contentWidth*1.5, display.contentHeight*1.05)
	titlePopup.x,titlePopup.y = display.contentCenterX, display.contentCenterY*1.2
	titlePopup.alpha = 0
	sceneGroup:insert(titlePopup)

	-- 2023.06.30 edit by jiruen // bgm 추가
    local exitBgm = audio.loadStream("soundEffect/388047_설정 닫기 버튼 클릭시 나오는 효과음.wav")

	local function gohome(event)
		if event.phase == "ended" then
				-- 2023.06.30 edit by jiruen // 효과음 추가
				audio.play(exitBgm)
				composer.removeScene("view01_3_error")
				exit.alpha=0
				composer.gotoScene("view01_2_input_name")
				
		end
	end	

	newError = display.newImageRect("image/게임시작/이름설정팝업.png",  display.contentWidth*1.6, display.contentHeight*1.05)
	sceneGroup:insert(newError)
	newError.x, newError.y = display.contentWidth/2,display.contentHeight*0.6



	local text = "**이름을 입력하세요**"
	local showText = display.newText(text, display.contentWidth*0.5, display.contentHeight*0.46)
	showText:setFillColor(0)
	showText.size = 30
	--showText.alpha = 0
	sceneGroup:insert(showText)


	exit = display.newImageRect("image/설정/닫기.png", display.contentWidth/7.5, display.contentHeight/13)
	sceneGroup:insert(exit)
	exit.x, exit.y = display.contentCenterX*2.25, display.contentCenterY*0.5
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