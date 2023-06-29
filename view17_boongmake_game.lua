-----------------------------------------------------------------------------------------
--
-- view1.lua
-- 230331 어느 부분이 게임 종료인지 주석 달아주기!
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

	composer.setVariable("gameName", "view17_boongmake_game")

	--게임 엔딩---
	function endingscene()
		local endingBackground = display.newRect(display.contentWidth/2, display.contentHeight/2, display.contentWidth, display.contentHeight)
		endingBackground:setFillColor(0)

		local endingText = display.newText("엔딩", display.contentWidth/2, display.contentHeight*0.4)
	 	endingText.size = 200
	 	endingText:setFillColor(1)

	 	local replay = display.newText("다시 하기", display.contentWidth/2, display.contentHeight*0.7)
		replay.size = 100
		replay:setFillColor(1)

		sceneGroup:insert(endingBackground)
		sceneGroup:insert(endingText)
		sceneGroup:insert(replay)

	 	local function touchEventListener( event )
	 		if (event.phase == "began") then 
	 			if event.target == replay then
	 				endingBackground.alpha=0
					endingText.alpha=0
					replay.alpha=0
	 				gamescene()
	 			end
	 		end
	 	end

	 	composer.setVariable("boongmake_status", "success")
	 	replay:addEventListener("touch", touchEventListener)
	 	endingText:toFront()
	 	replay:toFront()
	end

--게임 인트로&게임 방법----------------------------------------------------------------------------------------------------------------------------------------

	function startscene()
		local gametitle = display.newImage("image/boong/title.png")
		gametitle.x, gametitle.y = display.contentWidth/2, display.contentHeight/2

		local title = display.newText("붕어빵 만들기", gametitle.x, gametitle.y+130, native.systemFontBold)
		title.size = 50
		title:setFillColor(0)

		local titleBackground = display.newImage("image/boong/view02_background.png", display.contentWidth/2, display.contentHeight/2)

		local section = display.newRect(display.contentWidth/2, display.contentHeight*0.8, display.contentWidth, display.contentHeight*0.3)
		section:setFillColor(0.35, 0.35, 0.35, 0.35)
		section.alpha=0

		local script = display.newText("게임방법\n\n50초 안에 붕어빵 8개를 만드세요! \n 반죽과 팥앙금을 순서대로 놓고 터치하세요! \n 붕어빵 8개를 완성하면 게임 클리어 입니다.", section.x+30, section.y-100, native.systemFontBold)
		script.size = 30
		script:setFillColor(1)
		script.x, script.y = display.contentWidth/2, display.contentHeight*0.789
		script.alpha=0

		sceneGroup:insert(gametitle)
		sceneGroup:insert(title)
		sceneGroup:insert(titleBackground)
		sceneGroup:insert(section)
		sceneGroup:insert(script)

		local function scriptremove(event)
			timer1=timer.performWithDelay(500, spawn, 0)
			section.alpha=0
			script.alpha=0
			gamescene()
		end

		local function titleremove(event)
			gametitle.alpha=0
			title.alpha=0
			section.alpha=1
			script.alpha=1
			section:addEventListener("tap", scriptremove)
		end
		gametitle:addEventListener("tap", titleremove)
		gametitle:toFront()
		title:toFront()
	end


	--게임 시작---------------------------------------------------------------------------------------------------------------------------------------------------
	function gamescene()
		local background = display.newImage("image/boong/view02_background.png", display.contentWidth/2, display.contentHeight/2)
		local kettlebg = display.newImage("image/boong/재료배경.png", display.contentWidth*0.9, display.contentHeight*0.75)
	 	local kettle = display.newImage("image/boong/kettle.png", display.contentWidth*0.9, display.contentHeight*0.75)
	 	local beansbg = display.newImage("image/boong/재료배경.png", display.contentWidth*0.9, display.contentHeight*0.45)
	 	local beans = display.newImage("image/boong/beans.png", display.contentWidth*0.9, display.contentHeight*0.45)
	 	local timerImage = display.newImage("image/boong/타이머.png", display.contentWidth*0.9-10, display.contentHeight*0.15-20)
	 	local scorebg = display.newImage("image/boong/스코어.png", display.contentWidth*0.1+10, display.contentHeight*0.15-20)

	 	local object = {}
		--틀
		for i = 1,19,9 do
		 	object[i] = display.newImage("image/boong/object01.png", display.contentWidth*0.2 + i*30 - 10, display.contentHeight*0.55)

		 	--반죽1
		 	object[i+1] = display.newImage("image/boong/object02.png", display.contentWidth*0.2 + i*30 - 10, display.contentHeight*0.55)

		 	--팥
		 	object[i+2] = display.newImage("image/boong/object03.png", display.contentWidth*0.2 + i*30 - 10, display.contentHeight*0.55)

		 	--반죽2
		 	object[i+3] = display.newImage("image/boong/object04.png", display.contentWidth*0.2 + i*30 - 10, display.contentHeight*0.55)

		 	--틀
		 	object[i+4] = display.newImage("image/boong/object05.png", display.contentWidth*0.2 + i*30 - 10, display.contentHeight*0.55)

		 	--연기
		 	object[i+5] = display.newImage("image/boong/object06.png", display.contentWidth*0.2 + i*30 - 10, display.contentHeight*0.55)

		 	--완성된 붕어빵
		 	object[i+6] = display.newImage("image/boong/object07.png", display.contentWidth*0.2 + i*30 - 10, display.contentHeight*0.55)

		 	--탄 연기
		 	object[i+7] = display.newImage("image/boong/object08.png", display.contentWidth*0.2 + i*30 - 10, display.contentHeight*0.55)

		 	--탄 붕어빵
		 	object[i+8] = display.newImage("image/boong/object09.png", display.contentWidth*0.2 + i*30 - 10, display.contentHeight*0.55)
		end

		sceneGroup:insert(background)
		for i = 1, 27, 1 do
			sceneGroup:insert(object[i])
		end

		local volumeButton = display.newImageRect("image/설정/설정.png", 100, 100)
    	volumeButton.x,volumeButton.y = display.contentWidth * 0.98, display.contentHeight * 0.1
		
   	
   		local options = {
        	isModal = true
    	}
    	--샘플볼륨함수--
    	local function setVolume(event)
    		--audio.pause(bgm_play)
        	composer.showOverlay( "StopGame", options )
    	end
    	volumeButton:addEventListener("tap", setVolume)

		sceneGroup:insert(kettle)
		sceneGroup:insert(beans)
		sceneGroup:insert(kettlebg)
		sceneGroup:insert(beansbg)
		sceneGroup:insert(timerImage)
		sceneGroup:insert(scorebg)
		sceneGroup:insert(volumeButton)
	 	for i = 1,27,1 do
	 		object[i]:scale(0.6,0.6)
	 	end

	 	kettle:scale(0.3,0.3)
	 	beans:scale(0.35,0.35)
	 	kettlebg:scale(0.9,0.9)
	 	beansbg:scale(0.9,0.9)
	 	timerImage:scale(0.8,0.8)
	 	scorebg:scale(0.8,0.8)

		for i = 1, 27, 1 do
			object[i].alpha = 0
		end
		for i = 1, 27, 9 do
			object[i].alpha = 1
		end

	 	kettlebg:toFront()
	 	beansbg:toFront()
		kettle:toFront()
	 	beans:toFront()

	 	for i = 1, 19, 9 do
	 		object[i+5]:toFront()
	 	end

		local score = display.newText(0, display.contentWidth*0.1+10, display.contentHeight*0.15-20)
	 	score.size = 50
	 	score:setFillColor(0)
	 	local time= display.newText(50, display.contentWidth*0.9-10, display.contentHeight*0.15-10)
	 	time.size = 40
	 	time:setFillColor(0)

	 	local home = audio.loadStream( "music/music3.ogg" )
    	audio.setVolume( loadedEndings.logValue )--loadedEndings.logValue

    	local musicOption = { 
    		loops = -1
		}
		audio.play(home, musicOption)
	 	local tapSound = audio.loadSound("music/tapSound.wav")
	 	local success = audio.loadSound("music/success.wav")
	 	local fail = audio.loadSound("music/fail.mp3")

	 	----------------------코드 시작------------------------------------------

	 	--붕어빵만드는 순서
	 	local turn = {}
	 	for i = 1, 19, 9 do
			turn[i] = 1
		end
		local count = 0

		local function drag( event )
	 		if( event.phase == "began" ) then
	 			display.getCurrentStage():setFocus( event.target )
	 			event.target.isFocus = true
	 			-- 드래그 시작할 때
	 			event.target.initX = event.target.x
	 			event.target.initY = event.target.y

	 		elseif( event.phase == "moved" ) then

	 			if ( event.target.isFocus ) then
	 				-- 드래그 중일 때
	 				event.target.x = event.xStart + event.xDelta
	 				event.target.y = event.yStart + event.yDelta
	 			end

	 		elseif ( event.phase == "ended" or event.phase == "cancelled") then
	 			if ( event.target.isFocus ) then
	 				display.getCurrentStage():setFocus( nil )
	 				event.target.isFocus = false
	 				--반죽부터 반죽까지
	 				for j = 1, 19, 9 do
	 					if ( event.target.x > object[j].x - 100 and event.target.x < object[j].x + 100
	 						and event.target.y > object[j].y - 200 and event.target.y < object[j].y + 200) then
	 						if ( event.target == kettle) then
	 							if( turn[j] == 1) then
	 								object[j+1].alpha = 1
	 								turn[j] = turn[j] + 1
	 								
	 							elseif (turn[j] == 3) then
	 								object[j+3].alpha = 1
	 								turn[j] = turn[j] + 1
	 							end
							elseif (event.target == beans) then
								if( turn[j] == 2) then
									object[j+2].alpha = 1
									turn[j] = turn[j] + 1
									audio.play( tapSound )
								end
	 						end
	 						audio.play( tapSound )
	 					end
	 				end
	 				event.target.x = event.target.initX
	 				event.target.y = event.target.initY
	 			else
	 				display.getCurrentStage():setFocus( nil )
	 				event.target.isFocus = false
	 			end
	 		end
	 	end

	 	kettle:addEventListener("touch", drag)
	 	beans:addEventListener("touch", drag)

	 	local function touchEventListener( event )
	 		if( event.phase == "began" ) then
	 			for j = 1, 19, 9 do
	 				if( turn[j] == 4 and event.target == object[j+3]) then
	 					transition.to( object[j+5], { time=500, alpha=1, delay=3000 } )
						object[j+4].alpha = 1
						turn[j] = turn[j] + 1
						audio.play( tapSound )
					--object[j+5]가 나오고 6초 안에 터치를 하면 turnj = 5로, 터치를 안하면 turnj = 6으
					--완성한 붕어빵
						local clicked = false
						-- 3초 후에 object8이 나타나도록 타이머 생성
						local timer = timer.performWithDelay(6000, function()
						    -- object7이 클릭되지 않았으면 object8 생성
						    if not clicked then
						    	transition.to( object[j+7], { time=500, alpha=1 } )
						        print("넘어감")
						        turn[j] = 6
						    end
						end)
						-- object7 클릭 시 clicked 변수를 true로 변경하고 타이머 중지
						object[j+5]:addEventListener("tap", function()
						    clicked = true
						end)
			 		elseif( turn[j] == 5 and event.target == object[j+5]) then
				 		object[j+6].alpha = 1
				 		turn[j] = turn[j] + 2
				 		audio.play( tapSound )
				 	--탄 붕어빵
				 	elseif( turn[j] == 6 and event.target == object[j+7]) then
				 		object[j+8].alpha = 1
				 		turn[j] = turn[j] + 1
				 		audio.play( tapSound )
				 	--완성해서 초기화
				 	elseif( turn[j] == 7 and (event.target == object[j+8] or event.target == object[j+6]))then
				 		turn[j] = 1
				 		transition.cancel(object[j+5])
				 		transition.cancel(object[j+7])
						for i = j+1,j+8,1 do
		 					object[i].alpha = 0
						end
						if(event.target == object[j+6]) then
				 			score.text = score.text + 1
				 			count = count + 1
				 			audio.play(success)
				 		else
				 			audio.play(fail)
				 		end
				 		print(count)
				 		--score.text대신 붕어빵 개수 삽입--
				 	--게임 성공 판별 기준 score.text == '8'이되면 ending으로 이동------------------------------------------------------------------------
				 		if( score.text == '8') then
							 time.alpha = 0
							 score.alpha = 0
							 score.text = '성공'
							 endingscene()
				 		end
				 	end
	 			end
	 		end
	 	end
	 	
		for i = 1, 27, 1 do
			object[i]:addEventListener("touch", touchEventListener)
		end	 

	 	--time
	 	local function counter( event )
		 	time.text = time.text - 1

		 	if( time.text == '5' ) then
		 		time:setFillColor(1, 0, 0)
		 	end
		 	if( time.text == '-1') then
		 		time.alpha = 0
		 		score.alpha = 0
		 		score.text = '실패'
		 	--게임 실패 판별 기준 time.text == '-1'이되면 ending으로 이동------------------------------------------------------------------------
				endingscene()
			end
		 end

		 local timeAttack = timer.performWithDelay(1000, counter, 51, "gameTime")
	
	 	--코드 끝
	end

	startscene()

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