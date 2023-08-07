-----------------------------------------------------------------------------------------
--
-- view1.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

	composer.setVariable("gameName", "view24_performance_game")
	local background = display.newImageRect("image/performance/background.png", display.contentWidth*3, display.contentHeight)
	background.x = display.contentCenterX
    background.y = display.contentCenterY

	local section = display.newRect(display.contentWidth/2, display.contentHeight*0.8, display.contentWidth*3, display.contentHeight)
	section:setFillColor(0.35, 0.35, 0.35, 0.35)
	section.alpha=0.8
	
	local buildingFileNames = { "피아노", "바이올린", "플루트", "하프", "팀파니" }
	--램덤 구현 
    local order = {}

 	for i = 1, 5 do
 		order[i] = buildingFileNames[math.random(5)]
 	end

	local script = display.newText(order[1].."-"..order[2].."-"..order[3].."-"..order[4].."-"..order[5].." ".."\n순서대로 지휘를 해보자!", section.x+30, section.y-100,native.systemFontBold)
	script.size = 30
	script:setFillColor(1)
	script.x, script.y = display.contentWidth/2, display.contentHeight*0.789
	script.alpha=1

	-- 건물 배치 코드
	--local buildingFileNames = { "피아노", "바이올린", "플루트", "하프", "팀파니" }--"piano", "violin", "flute", "harp", "timpani" 
	local buildingNames = { "piano", "violin", "flute", "harp", "timpani"}
	local building_x = {(-0.6), 1.7, 0, 1.23, 0.65}
	local building_y = {0.6, 0.6, 0.6, 0.6, 0.6}
	local building_size = {2.3, 2.5, 2.5, 2.5, 2.3}

	local buildingGroup = display.newGroup()
	local building = {}

	for i = 1, 5 do 
		local size = building_size[i]
		building[i] = display.newImageRect(buildingGroup, "image/performance/".. buildingFileNames[i] ..".png", 512/size, 512/size)
 		building[i].x, building[i].y = display.contentWidth*building_x[i], display.contentHeight*building_y[i]
 		building[i].name = buildingNames[i]
	end

	local target

	local cat = display.newImageRect("image/performance/cat1.png", 250, 250)
 	cat.x, cat.y = display.contentWidth/2, display.contentHeight*0.8

 	--점수 
 	local score1 = display.newText(0, display.contentWidth*(-0.8), display.contentHeight*0.1)
 	score1.size = 80

 	score1:setFillColor(0)
 	score1.alpha = 0.5
--음표 객체 
	-- local musicNote = display.newImageRect("image/music_note.png", 100, 100)
 -- 	musicNote.x, musicNote.y = display.contentWidth/2, display.contentHeight*0.8

-- 마을 맵 마을 객체 생성.
	local click1 = audio.loadStream( "music/스침.wav" )

--효과음 생성
local soundTable = {
 
    timpani = audio.loadSound( "soundEffect/s5.mp3" ),
    harp = audio.loadSound( "soundEffect/s4.mp3" ),
    flute = audio.loadSound( "soundEffect/s3.mp3" ),
    violin = audio.loadSound( "soundEffect/s2.wav" ),
    piano = audio.loadSound( "soundEffect/s1.mp3" )
} 

	
-- 마을 객체 커서 범위 설정. 범위 밖으로 나가면 마을 크기 작아지고 안으로 들어가면 마을 크기 커짐.
	local i = 0
	local function bigbig (event)
		
		if (event.target.x-event.x)^2 + (event.target.y-event.y)^2 < 110^2 then
			-- i값을 지정해 놓는 이유는 범위 안에서는 크기가 더 늘어나거나 줄어들지 않고, 소리가 연이어 나오지 않음.
			if i == 0 then
				local backgroundMusicChannel = audio.play(click1)
				event.target.width = event.target.width*1.1
				event.target.height = event.target.height*1.1
				i = i + 1
			end
		
		elseif (event.target.x-event.x)^2 + (event.target.y-event.y)^2 > 110^2 then
			if i == 1 then
				event.target.width =event.target.width/11*10
				event.target.height =event.target.height/11*10
				i = i - 1 
			end
			
		end
	end

	local name = 0

	local options = {
        	isModal = true,
        	params = { targetName = name }
	    	}
--성공실패 구현 
	local count = 1
-- 리스너 함수 생성
	local function touch_ui (event)
		if event.phase == "began" then--누르면 악기소리가 난다.
			if (event.target == building[1]) then
 				audio.play( soundTable["piano"] , { onComplete=touch_ui } )
 			elseif (event.target == building[2]) then
 				audio.play( soundTable["violin"] , { onComplete=touch_ui } )
 			elseif (event.target == building[3]) then
 				audio.play( soundTable["flute"] , { onComplete=touch_ui } )
 			elseif (event.target == building[4]) then
 				audio.play( soundTable["harp"] , { onComplete=touch_ui } )
 			elseif (event.target == building[5]) then
 				audio.play( soundTable["timpani"] , { onComplete=touch_ui } )
 			end
	    elseif ( event.phase == "ended") then
			if (event.target == building[1]) then
				if( buildingFileNames[1] == order[count])then
					count = count + 1
 					score1.text = score1.text + 1
 					if(score1.text == '5') then --- !성공!했을 때 
 						score1.text = '성공!'
 						for	i = 1, 5 do
						    audio.stop ( i )
						end
						composer.removeScene("view24_performance_game")
						composer.setVariable("score", 5)
						composer.gotoScene( "view24_performance_game_over" )---veiw2가 엔딩화면 
 					end
 				else
 					for	i = 1, 5 do
						audio.stop ( i )
					end
 					composer.removeScene("view24_performance_game") 
					composer.setVariable("score", -1) 
					composer.gotoScene("view24_performance_game_over")
 				end
 			elseif (event.target == building[2]) then
				if( buildingFileNames[2] == order[count])then
					count = count + 1
 					score1.text = score1.text + 1
 					if(score1.text == '5') then --- !성공!했을 때 
 						score1.text = '성공!'
 						for	i = 1, 5 do
						    audio.stop ( i )
						end
						composer.removeScene("view24_performance_game")
						composer.setVariable("score", 5)
						composer.gotoScene( "view24_performance_game_over" )---veiw2가 엔딩화면 
 					end
 				else
 					for	i = 1, 5 do
						audio.stop ( i )
					end
 					composer.removeScene("view24_performance_game") 
					composer.setVariable("score", -1) 
					composer.gotoScene("view24_performance_game_over")
 				end
 			elseif (event.target == building[3]) then
				if( buildingFileNames[3] == order[count])then
					count = count + 1
 					score1.text = score1.text + 1
 					if(score1.text == '5') then --- !성공!했을 때 
 						score1.text = '성공!'
 						for	i = 1, 5 do
						    audio.stop ( i )
						end
						composer.removeScene("view24_performance_game")
						composer.setVariable("score", 5)
						composer.gotoScene( "view24_performance_game_over" )---veiw2가 엔딩화면 
 					end
 				else
 					for	i = 1, 5 do
						audio.stop ( i )
					end					
 					composer.removeScene("view24_performance_game") 
					composer.setVariable("score", -1) 
					composer.gotoScene("view24_performance_game_over")
 				end
 			elseif (event.target == building[4]) then
				if( buildingFileNames[4] == order[count])then
					count = count + 1
 					score1.text = score1.text + 1
 					if(score1.text == '5') then --- !성공!했을 때 
 						score1.text = '성공!'
 						for	i = 1, 5 do
						    audio.stop ( i )
						end
						composer.removeScene("view24_performance_game")
						composer.setVariable("score", 5)
						composer.gotoScene( "view24_performance_game_over" )---veiw2가 엔딩화면 
 					end
 				else
 					for	i = 1, 5 do
						audio.stop ( i )
					end
 					composer.removeScene("view24_performance_game") 
					composer.setVariable("score", -1) 
					composer.gotoScene("view24_performance_game_over")
 				end			
 			elseif (event.target == building[5]) then
				if( buildingFileNames[5] == order[count])then
 					count = count + 1
 					score1.text = score1.text + 1
 					if(score1.text == '5') then --- !성공!했을 때 
 						score1.text = '성공!'
 						for	i = 1, 5 do
						    audio.stop ( i )
						end
						composer.removeScene("view24_performance_game")
						composer.setVariable("score", 5)
						composer.gotoScene( "view24_performance_game_over" )---veiw2가 엔딩화면 
 					end
 				else
 					for	i = 1, 5 do
						audio.stop ( i )
					end
 					composer.removeScene("view24_performance_game") 
					composer.setVariable("score", -1) 
					composer.gotoScene("view24_performance_game_over")
 				end
			end
		end
	end

		--대사 제어 (클릭하면 없어짐)
	local function scriptremove(event)
		timer1=timer.performWithDelay(3000, touch_ui, 0)
		section.alpha=0
		script.alpha=0

		--스크립트 없어지면 객체 누를 수 있게됨 
		for i=1, 5 do
		building[i]:addEventListener("mouse",bigbig)
		building[i]:addEventListener("touch",touch_ui)
		--building[i]:addEventListener("tap", gotoCheckMsg)
		end
	end	
	   local options = {
        isModal = true
    }

    -- 2023.07.04 edit by jiruen // 샘플 볼륨 bgm
    local volumeBgm = audio.loadStream("soundEffect/263126_설정 클릭시 나오는 효과음(2).wav")

    local volumeButton = display.newImageRect("image/설정/설정.png", display.contentWidth/6.5, display.contentHeight/9.5)
    volumeButton.x,volumeButton.y = display.contentCenterX * 3.6, display.contentCenterY * 0.15
	
   	
    --샘플볼륨함수--
    local function setVolume(event)
    	--audio.pause(bgm_play)
    	-- mainGroup = display.newGroup()
    	-- asteroidsTable = {}
    	--timer.cancel(gameLoopTimer)
    	--physics.pause()
    	audio.play(volumeBgm)
        composer.showOverlay( "StopGame", options )
    end
    volumeButton:addEventListener("tap", setVolume)
	section:addEventListener("tap", scriptremove)

	--깔리는 것부터 차례대로
	sceneGroup:insert(background)
	sceneGroup:insert(score1)
	sceneGroup:insert(buildingGroup)
	--sceneGroup:insert(musicNote)
	sceneGroup:insert(cat)
	sceneGroup:insert(section)
	sceneGroup:insert(script)
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

	end
end

function scene:destroy( event )
	local sceneGroup = self.view
	
	-- audio.dispose( soundTable["timpani"] )
	-- audio.dispose( soundTable["harp"] )
	-- audio.dispose( soundTable["flute"] )
	-- audio.dispose( soundTable["violin"] )
	-- audio.dispose( soundTable["piano"] )

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
