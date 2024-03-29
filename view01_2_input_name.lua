-----------------------------------------------------------------------------------------
--
-- view1.lua
--
-----------------------------------------------------------------------------------------
local loadsave = require( "loadsave" )
local composer = require( "composer" )
local physics = require("physics")
local scene = composer.newScene()
local json = require( "json" ) 


--게임 시작 화면

function scene:create( event )
	local sceneGroup = self.view
	local widget = require ("widget")

	local loadedEndings = loadsave.loadTable( "endings.json" )


	local background = display.newImageRect("image/게임시작/background.png", display.contentWidth*3, display.contentHeight)
	background.x = display.contentCenterX
    background.y = display.contentCenterY
	sceneGroup:insert(background)


--[[
	--샘플 볼륨 이미지
    local volumeButton = display.newImageRect("image/설정/설정.png", 100, 100)
    volumeButton.x,volumeButton.y = display.contentCenterX * 0.5, display.contentCenterY * 0.5
    sceneGroup:insert(volumeButton)

 	--샘플볼륨함수--
    local function setVolume(event)
        composer.showOverlay( "volumeControl", options )
    end
    volumeButton:addEventListener("tap",setVolume)]]




	local titlePopup = display.newImageRect("image/게임시작/이름설정팝업.png", display.contentWidth*1.6, display.contentHeight*1.05)
	titlePopup.x,titlePopup.y = display.contentCenterX, display.contentCenterY*1.2
	titlePopup.alpha = 0
	sceneGroup:insert(titlePopup)



    local text = "입장하기 전, 이름을 입력해 주세요."
	local showText = display.newText(text, display.contentCenterX*1.03, display.contentCenterY*0.9)
	showText:setFillColor(0)
	showText.size = 27
	--showText.alpha = 0
	sceneGroup:insert(showText)



	local titleButton = display.newImageRect("image/게임시작/이름결정.png", display.contentWidth/2, display.contentHeight/2.8)
	titleButton.x,titleButton.y = display.contentCenterX, display.contentCenterY+95
	titleButton.alpha = 0
	sceneGroup:insert(titleButton)


	local text1 = "확인"
	local showText1 = display.newText(text1, titleButton.x, titleButton.y-5)
	showText1:setFillColor(0)
	showText1.size = 25
	showText1.alpha = 1
	sceneGroup:insert(showText1)


    local musicOption = { 
    	loops = -1
	}

	--이름 입력을 위한 텍스트상자 생성--
	local defaultField
	local function textListener( event )
 
    	if ( event.phase == "began" ) then
        	-- User begins editing "defaultField"
 
    	elseif ( event.phase == "ended" or event.phase == "submitted" ) then
        	-- Output resulting text from "defaultField"
        	print( event.target.text )
 
    	elseif ( event.phase == "editing" ) then
        	print( event.newCharacters )
        	print( event.oldText )
        	print( event.startPosition )
        	print( event.text )
    	end
	end

	titlePopup.alpha = 1
	titleButton.alpha = 1
	showText.alpha = 1

		-- Create text field

	local function make_text()
		defaultField = native.newTextField( display.contentCenterX,display.contentCenterY+30, display.contentWidth, display.contentHeight/13)
		defaultField:addEventListener( "userInput", textListener )
		defaultField.font = native.newFont( "font/font.ttf", 40)
		defaultFied = ""
		defaultField.align = "center"
		sceneGroup:insert(defaultField)
	end
	make_text()


	-- 검은 화면
	local back = display.newRect(display.contentCenterX/2,display.contentCenterY/2, display.contentCenterX,display.contentCenterY)
	back:setFillColor(0)
	sceneGroup:insert(back)
	back.alpha = 0

	-- 화면전환 이펙트
	local options={
		effect = "fade",
		time = 2000
	}

	-- 2023.06.30 edit by jiruen // bgm 추가
    local exitBgm = audio.loadStream("soundEffect/388047_설정 닫기 버튼 클릭시 나오는 효과음.wav")

	local function gotomap(event)
		if event.phase == "began" then 
			--event.target.width,event.target.height = 68.82,68.82
			-- 2023.06.30 edit by jiruen // 효과음 추가
			audio.play(exitBgm)
		elseif event.phase == "cancelled" then 
			event.target.width,event.target.height = 68.82,68.82
		elseif event.phase == "ended" then
			event.target.width,event.target.height = 68.82,68.82
			
			defaultField:removeSelf()
			defaultField = nil
			composer.removeScene("view01_2_input_name")
			composer.gotoScene("view01_1_start_game")

		end
	end

	local exit1 = display.newImageRect("image/설정/닫기.png", display.contentWidth/7.5, display.contentHeight/13)
	sceneGroup:insert(exit1)
	exit1.x, exit1.y = display.contentCenterX*2.25, display.contentCenterY*0.5
	exit1:addEventListener("touch",gotomap)

	local can = 20
	
	-- 2023.06.30 edit by jiruen // 확인 버튼 bgm 추가
    local startNewBgm = audio.loadStream("soundEffect/263126_설정 클릭시 나오는 효과음(2).wav")

	local function startNew(event)
		--색깔 또는 이름을 선택하지 않았을 시 에러 팝업창으로 넘어간다

		if defaultField.text == "" then
			-- 2023.06.30 edit by jiruen // 효과음 추가
			audio.play(startNewBgm)

			defaultField:removeSelf()
			defaultField = 'nil'
			composer.removeScene("view01_2_input_name")
			composer.gotoScene("view01_3_error")
		else
				--게임 진행을 위한 저장 데이터들 생성				
				loadedEndings = loadsave.loadTable( "endings.json" )
				loadsave.saveTable(loadedEndings,"endings.json")

				-- 각 건물 당 npc와 얼마나 대화를 했는지 나타내는 리스트.
				-- 각 건물의 위치를 숫자로 나타냄. ex)백주년은 1, 예지관은 8
				local talk = {} 
				for i = 1, 8 do
					talk[i] = 0
				end

				local gameSettings = {
    				money = 0,
    				can = 33, 
    				hobby = 20,
    				study = 0,
    				-- friendship = 20,
    				tutorial = 0,			
    				next1 = "",
    				next2 = "",
    				name = defaultField.text,
  					-- 게임 진행도
  					talk = talk,
  					total_success = 0, -- 총 성공한 게임 갯수
  					total_success_names = {}, -- 총 성공한 게임 이름 {}, 
  					today_success = 0, --오늘 성공한 게임 갯수
  					today_talk = 0, --오늘 대화한 횟수
  					buildings_index = { "인문관", "음악관", "예지관", "대학원", "본관", "정문", "백주년", "학생관"},
  					date = os.date( "*t" ),
  					days = 0,
  					--커스텀
  					closed = {true, true, true, true, true, true, true, true, true, true, true, true, true, true, true},
  					clothes = {false, false, false, false, false, false},
  					get_clothes = {false, false, false, false, false, false},
  					clothesCount = 3,
  					custom1 = "image/custom/cat.png",
    				custom2 = "image/custom/투명.png",
    				clothesFlag = 0,
    				--히든퀘스트
       				openHiddenQuest = false,
       				hidden_index = 0,
       				hiddenQuest_flag = true
				}
				loadsave.saveTable( gameSettings, "settings.json" )
				




				local itme = {
						--itemCount = 0,
						item1 = 0,
						item2 = 0,
						item3 = 0,
						item4 = 0,
						item5 = 0,
						item6 = 0,
						item7 = 0,
						item8 = 0,
						item9 = 0,
					}

		
				local serializedJSON = json.encode(itme)
				--loadsave.saveTable(custumeBuy, "items.json")

				loadsave.saveTable( itmes ,"items.json" )
				composer.setVariable("name",defaultField.text)
				defaultField:removeSelf()
				defaultField = nil
				
				titleButton.alpha = 0
				titlePopup.alpha = 0
				exit1.alpha = 0
				showText.alpha = 0
				showText1.alpha = 0
				--volumeButton.alpha = 0

				composer.removeScene("view01_2_input_name")
				--composer.gotoScene( "tutorial00",options)
				audio.pause( titleMusic )

				tutorialMusic = audio.loadStream( "music/music4_1.wav" )
	    		audio.play(tutorialMusic, musicOption)
	    		--audio.setVolume( loadedEndings.logValue )
				composer.gotoScene( "tutorial00" ,options)
			end
	end
	titleButton:addEventListener("tap",startNew)

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