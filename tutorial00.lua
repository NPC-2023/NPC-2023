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
	loadedEndings = loadsave.loadTable( "endings.json" )

	
	local background = display.newImage( "image/게임시작/background.png")
	background.x, background.y = display.contentWidth/2, display.contentHeight/2

	local section = display.newRect(display.contentWidth/2, display.contentHeight*0.8, display.contentWidth, display.contentHeight*0.3)
	section:setFillColor(0.8, 0.8, 0.8, 0.8)

	--local speakerImg = display.newRect(section.x, section.y - 700, 900, 900)

	

	-----음악

    -- showoverlay 함수 사용 option
    local options = {
        isModal = true
    }

    --샘플 볼륨 이미지
    local volumeButton = display.newImageRect("image/설정/설정.png", 100, 100)
    volumeButton.x,volumeButton.y = display.contentWidth * 0.91, display.contentHeight * 0.4
    sceneGroup:insert(volumeButton)

    --샘플볼륨함수--
    local function setVolume(event)
        composer.showOverlay( "volumeControl", options )
    end
    volumeButton:addEventListener("tap",setVolume)

    --local home = audio.loadStream( "music/Trust.mp3" )
    --audio.setVolume( loadedEnding.logValue )--loadedEndings.logValue
    --audio.play(home)


    -------------
	local sceneGroup = self.view
	local b = {}

	bGroup = display.newGroup()
	local loadedSettings = loadsave.loadTable( "settings.json" )
	mainName = loadedSettings.name

	-- showoverlay 함수 사용 option
    local options = {
        isModal = true
    }		

	--배경
	for i = 1, 26 do
		b[i] = display.newImage(bGroup, "이미지/오프닝/" .. i .. ".png")
	end
	bGroup.x,bGroup.y = display.contentWidth/2,display.contentHeight/2
	sceneGroup:insert(bGroup)

	composer.setVariable("find1", 0)	
	composer.setVariable("find2", 0)	
	composer.setVariable("find3", 0)	
	composer.setVariable("find4", 0)	
	composer.setVariable("find5", 0)	

	loadsave.saveTable(loadedSettings,"settings.json")

    --대화창
 	--대사
	local t = {}
	t[1] = display.newText("망망대해 같은 우주의 어느 한 구석에는 색연필 행성이 있다.", display.contentWidth * 0.5, display.contentHeight * 0.93, "font/NanumSquareRoundR.ttf", 30)
	t[2] = display.newText("색연필 행성은 5개의 마을로 이루어져 있고, 마을마다 같은 색을 가진 색연필들이 모여 사는 아름다운 별이다.", display.contentWidth * 0.5, display.contentHeight * 0.93, "font/NanumSquareRoundR.ttf", 30)
	t[3] = display.newText("우리 색연필들은 하얀색으로 태어나, 일정 나이가 되면 각각의 색과 모습을 가진다.", display.contentWidth * 0.5, display.contentHeight * 0.93, "font/NanumSquareRoundR.ttf", 30)
	t[4] = display.newText("이때 가지게 되는 색들은 각자의 성격을 많이 닯곤 한다.", display.contentWidth * 0.5, display.contentHeight * 0.93, "font/NanumSquareRoundR.ttf", 30)
	t[5] = display.newText("색연필 행성의 마을들을 소개하자면, 다음과 같다.",display.contentWidth * 0.5, display.contentHeight * 0.93, "font/NanumSquareRoundR.ttf", 30)
	t[6] = display.newText("사랑이 샘솟는 색연필들이 모여 사는 곳, 서로를 사랑하며 살아가는 빨강 마을!", display.contentWidth * 0.5, display.contentHeight * 0.93, "font/NanumSquareRoundR.ttf", 30)
	t[7] = display.newText("언제나 즐거워! 신나는 노래가 흘러나오고, 활기찬 웃음소리가 끊이지 않는 노랑 마을!", display.contentWidth * 0.5, display.contentHeight * 0.93, "font/NanumSquareRoundR.ttf", 30)
	t[8] = display.newText("친구를 생각하는 따뜻한 마음씨를 가진 색연필들이 모여 사는 곳, 초록 마을!", display.contentWidth * 0.5, display.contentHeight * 0.93, "font/NanumSquareRoundR.ttf", 30)
	t[9] = display.newText("아는 것이 힘이지! 지혜로움을 중시하는 색연필들의 파랑 마을!", display.contentWidth * 0.5, display.contentHeight * 0.93, "font/NanumSquareRoundR.ttf", 30)
	t[10] = display.newText("모든 시작의 원동력은 용감함이야! 용기 있는 색연필들이 사는 보라 마을!", display.contentWidth * 0.5, display.contentHeight * 0.93, "font/NanumSquareRoundR.ttf", 30)
	t[11] = display.newText("...와 같다.", display.contentWidth * 0.5, display.contentHeight * 0.93, "font/NanumSquareRoundR.ttf", 30)
	t[12] = display.newText("그런데 나는.....", display.contentWidth * 0.5, display.contentHeight * 0.93, "font/NanumSquareRoundR.ttf", 30)
	t[13] = display.newText("원래대로라면, 나도 내 친구들처럼 지금쯤 색을 가지고 있어야 하는데.. 왜 나는 색이 없을까?", display.contentWidth * 0.5, display.contentHeight * 0.93, "font/NanumSquareRoundR.ttf", 30)
	t[14] = display.newText("내가 부족해서 색이 안생기는 걸까? 잘하는 것도 없고 좋아하는 것도 없어서 그런 걸까?", display.contentWidth * 0.5, display.contentHeight * 0.93, "font/NanumSquareRoundR.ttf", 30)
	t[15] = display.newText("이대로 영영 하얀색 색연필이긴 싫어!", display.contentWidth * 0.5, display.contentHeight * 0.93, "font/NanumSquareRoundR.ttf", 30)
	t[16] = display.newText("나도 남들처럼 예쁜 색을 가지고 싶단 말이야!", display.contentWidth * 0.5, display.contentHeight * 0.93, "font/NanumSquareRoundR.ttf", 30)
	t[17] = display.newText("이제 나는 어떻게 해야하지···?", display.contentWidth * 0.5, display.contentHeight * 0.93, "font/NanumSquareRoundR.ttf", 30)
	t[18] = display.newText(mainName ..", 오늘따라 우울해보이네.", display.contentWidth * 0.5, display.contentHeight * 0.93, "font/NanumSquareRoundR.ttf", 30)
	t[19] = display.newText("있지 얘들아, 사실 고민이 있어. 나는 왜 너희처럼 멋진 색이 생기지 않는 걸까?", display.contentWidth * 0.5, display.contentHeight * 0.93, "font/NanumSquareRoundR.ttf", 30)
	t[20] = display.newText("헉··· 그러게. 어디 아픈거 아니야 ".. mainName .."? 괜찮아?", display.contentWidth * 0.5, display.contentHeight * 0.93, "font/NanumSquareRoundR.ttf", 30)
	t[21] = display.newText("그럼 평생 하얀색으로 살아야 하는거야? 지우개처럼? 안돼!", display.contentWidth * 0.5, display.contentHeight * 0.93, "font/NanumSquareRoundR.ttf", 30)
	t[22] = display.newText("아무래도 이걸 해결하지 않으면 큰일나겠어. 고깔모자를 쓴 아이슈타인처럼!", display.contentWidth * 0.5, display.contentHeight * 0.93, "font/NanumSquareRoundR.ttf", 30)
	t[23] = display.newText("걱정마 ".. mainName .."! 우리가 도와줄게! 분명 너처럼 멋진 색을 찾을 수 있을거야.", display.contentWidth * 0.5, display.contentHeight * 0.93, "font/NanumSquareRoundR.ttf", 30)
	t[24] = display.newText("\"맞아, 우리가 도와줄게!\"", display.contentWidth * 0.5, display.contentHeight * 0.93, "font/NanumSquareRoundB.ttf", 30)
	t[25] = display.newText("\"고마워 얘들아···!\"", display.contentWidth * 0.5, display.contentHeight * 0.93, "font/NanumSquareRoundR.ttf", 30)
	t[26] = display.newText("'열심히 노력해서 반드시 색을 되찾고 말 거야!'", display.contentWidth * 0.5, display.contentHeight * 0.93, "font/NanumSquareRoundR.ttf", 30)

    for i = 2, 26 do
		b[i].alpha = 0
		t[i].alpha = 0
	end

	for i = 1, 26 do
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
		if j > 1 and j < 26 then
			b[j - 1].alpha = 0
			
			t[j - 1].alpha = 0
			b[j].alpha = 1
			t[j].alpha = 1
		end


		j = j + 1


		if j == 28 then
			composer.removeScene("tutorial")
			composer.gotoScene("view01_month")
		end
	end

	local skipButton = display.newImage("이미지/오프닝/스킵버튼.png") -- 스킵 버튼
    skipButton.x, skipButton.y = display.contentWidth * 0.93, display.contentHeight * 0.1
    skipButton.alpha = 1
    sceneGroup:insert(skipButton)
    
	local function skip_tutorial()
		skipButton.alpha = 0
		Runtime:removeEventListener("tap", next1)
		composer.removeScene("tutorial")
		audio.pause(tutorialMusic)
		composer.gotoScene( "view01_guide(new)" )
	end

	skipButton:addEventListener("tap",skip_tutorial) 
	Runtime:addEventListener("tap", next1)


    sceneGroup:insert(background)
	sceneGroup:insert(section)
	

	sceneGroup:insert(volumeButton)
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
