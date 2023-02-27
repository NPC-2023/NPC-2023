-----------------------------------------------------------------------------------------
--
-- story.lua
--
-----------------------------------------------------------------------------------------
-- JSON파싱--
--[[local json = require("json")

local Data, pos, msg

local function parse()
	local filename = system.pathForFile("Content/JSON/story01.json")
	Data, pos, msg = json.decodeFile(filename)

	--디버그
	if Data then
		print(Data[1].type)
	else
		print(pos)
		print(print)
	end
	--
end
parse()]]

local composer = require( "composer" )
local scene = composer.newScene()
local loadsave = require( "loadsave" )
local json = require( "json" )

local i
local j = 1
function scene:create( event )
	local sceneGroup = self.view
	loadedEndings = loadsave.loadTable( "endings.json" )

	
	local background = display.newImage( "image/게임시작/background.png")
	background.x, background.y = display.contentWidth/2, display.contentHeight/2
	sceneGroup:insert(background)
	

	

	--[[-----음악

    -- showoverlay 함수 사용 option
    local options = {
        isModal = true
    }

    --샘플 볼륨 이미지
    local volumeButton = display.newImageRect("image/설정/설정.png", 100, 100)
    volumeButton.x,volumeButton.y = display.contentWidth * 0.91, display.contentHeight * 0.4
    




    --샘플볼륨함수--
    local function setVolume(event)
        composer.showOverlay( "volumeControl", options )
    end
    volumeButton:addEventListener("tap",setVolume)
	sceneGroup:insert(volumeButton)
    --local home = audio.loadStream( "music/Trust.mp3" )
    --audio.setVolume( loadedEnding.logValue )--loadedEndings.logValue
    --audio.play(home)


   
	--sceneGroup:insert(volumeButton)]]
    -------------
	local b = {}

	bGroup = display.newGroup()
	local loadedSettings = loadsave.loadTable( "settings.json" )
	mainName = loadedSettings.name


	--배경
	for i = 1, 5 do
		b[i] = display.newImage(bGroup, "image/게임시작/" .. i .. ".png")
	end
	bGroup.x,bGroup.y = display.contentWidth/2,display.contentHeight/2
	sceneGroup:insert(bGroup)

	composer.setVariable("find1", 0)	
	composer.setVariable("find2", 0)	
	composer.setVariable("find3", 0)	
	composer.setVariable("find4", 0)	
	composer.setVariable("find5", 0)	

	loadsave.saveTable(loadedSettings,"settings.json")


	local section = display.newRect(display.contentWidth/2, display.contentHeight*0.8, display.contentWidth, display.contentHeight*0.3)
	section:setFillColor(0.8, 0.8, 0.8, 0.8)
	sceneGroup:insert(section)
	--local speakerImg = display.newRect(section.x, section.y - 700, 900, 900)



    --대화창
 	--대사
	local t = {}
	t[1] = display.newText("나는 고양이 왕국의 일등 기사도 ".. mainName .."! 좋은 아침이다냥!\n오늘도 힘차게 왕국을 지켜볼까?", display.contentWidth * 0.5, display.contentHeight * 0.93 - 100, "font/NanumSquareRoundR.ttf", 30)
	t[2] = display.newText("어.. 그런데 여기가 어디지?\n꿈을 꾸고 있나..? 여기는 왕국이 아니잖아!", display.contentWidth * 0.5, display.contentHeight * 0.93 - 100, "font/NanumSquareRoundR.ttf", 30)
	t[3] = display.newText("예지관... A? 여기가 어디지?\n응? 그런데 이 쪽지는 뭐지?", display.contentWidth * 0.5, display.contentHeight * 0.93 - 100, "font/NanumSquareRoundR.ttf", 30)
	t[4] = display.newText("오늘부터는 왕국이 아닌 인간 세계의 학교에서 학생이라는 인간을 보필하도록 하여라.\n안전한 학교를 만드는 것이 너의 의무이니라. 16일이 지나면 좋은 결과가 있을 것이다..\n행운을 빌며.", display.contentWidth * 0.5, display.contentHeight * 0.93 - 100, "font/NanumSquareRoundR.ttf", 30)
	t[5] = display.newText("학교? 학생?\n뭐가 뭔지 모르겠지만 나는 용기있는 기사니까!\n어서 학생이라는 인간을 만나러 나가볼까냥! ",display.contentWidth * 0.5, display.contentHeight * 0.93 - 100, "font/NanumSquareRoundR.ttf", 30)
	

    for i = 2, 5 do
		b[i].alpha = 0
		t[i].alpha = 0
	end

	for i = 1, 5 do
		if i == 18 then
			t[i]:setFillColor(0, 0.4, 0)
		elseif i == 20 then
			t[i]:setFillColor(1, 0.2, 0.3)
		elseif i == 21 then --o
			t[i]:setFillColor(1, 0.4, 0.1)
		elseif i == 22 then--b
			t[i]:setFillColor(0.2, 0.4, 0.8)
		elseif i == 23 then --p
			t[i]:setFillColor(0.5, 0.2, 0.7)
		else
			t[i]:setFillColor(alpha)
		end
		sceneGroup:insert(t[i])
	end

	-- 화면전환
	local function next1()
		if j > 1 and j < 6 then
			b[j - 1].alpha = 0
			
			t[j - 1].alpha = 0
			b[j].alpha = 1
			t[j].alpha = 1
		end


		j = j + 1


		if j == 7 then
			composer.removeScene("tutorial00")
			audio.pause(tutorialMusic)
			composer.gotoScene("view05_main_map")
		end
	end

	local skipButton = display.newImageRect("image/게임시작/이름결정.png", 250, 200) -- 스킵 버튼
    skipButton.x, skipButton.y = display.contentWidth * 0.93, display.contentHeight * 0.1
    skipButton.alpha = 1
    sceneGroup:insert(skipButton)
    	

    local text = "스킵"
	local showText = display.newText(text, display.contentWidth*0.93, display.contentHeight*0.09)
	showText:setFillColor(0)
	showText.size = 30
	showText.alpha = 1
	sceneGroup:insert(showText)
	

	local function skip_tutorial()
		skipButton.alpha = 0
		Runtime:removeEventListener("tap", next1)
		composer.removeScene("tutorial00")
		audio.pause(tutorialMusic)
		composer.gotoScene( "view05_main_map" )
	end

	skipButton:addEventListener("tap",skip_tutorial) 
	Runtime:addEventListener("tap", next1)


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
		composer.removeScene("pig")
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
