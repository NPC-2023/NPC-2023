-----------------------------------------------------------------------------------------
--
-- game.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view
	
	---------1차시-------------
	local background = display.newImageRect("image/cafeteria.png", 1280, 720)--배경이미지
	background.x, background.y = display.contentWidth/2, display.contentHeight/2

	local pan = display.newImageRect("image/pan.png", 900, 900)--식판 이미지 
 	pan.x, pan.y = display.contentWidth/2, display.contentHeight/2

 	local foodGroup = display.newGroup()--음식이미지 
 	local food = {}

 	for i = 1, 10 do
 		food[i] = display.newImageRect(foodGroup, "image/f (" .. i .. ").png", 135, 135)
 	end

 	for i = 1, 5 do--음식 위치 
 		food[i].x, food[i].y = display.contentWidth*0.1, display.contentHeight*0.005 + 130*i
 	end

 	for i = 6, 10 do
 		food[i].x, food[i].y = display.contentWidth*0.9, display.contentHeight*0.005 + 130*(i - 5)
 	end

 	local score = display.newText(0, display.contentWidth*0.2, display.contentHeight*0.14)--점수 입력 
 	score.size = 87

 	score:setFillColor(0)
 	score.alpha = 0.5

 	local time= display.newText(10, display.contentWidth*0.8, display.contentHeight*0.14)--0.8, 0.1
 	time.size = 87
 	time:setFillColor(0)
 	time.alpha = 0.5

    ----힌트 버튼 
    local hintBbg = display.newImageRect("image/hintButton.png", 250, 250)--힌트버튼 배경  
 	hintBbg.x, hintBbg.y = display.contentWidth*0.07, display.contentHeight*0.05 
 	local hintButton = display.newText("hint", display.contentWidth*0.07, display.contentHeight*0.045)
 	hintButton.size = 50
 	hintButton:setFillColor(0.3)


 	function hintBbg:tap( event )
 		composer.showOverlay('setting')
 	end
 	hintBbg:addEventListener("tap", hintBbg)

 		--timer 객체 
 	local timerbg = display.newImageRect("image/timer.png", 230, 230)
 	timerbg.x, timerbg.y = display.contentWidth*0.79, display.contentHeight*0.1

 		-- 고양이 손 객체   
	local h1 = display.newImageRect("image/punch.png",150, 150)
	h1.anchorX,h1.anchorY=0.3,0.3
	h1.x,h1.y = 640,360

		-- 클릭 시 고양이 손 기울어짐
	function move(event)
		if (event.phase == "began") then
			transition.to(h1,{rotation=-45,time=200})
		end

		if (event.phase == "ended") then
			transition.to(h1,{rotation=0,time=200})
		end
	end

	function move1(event)
		h1.x,h1.y = event.x,event.y
	end

	Runtime:addEventListener("mouse",move1)
	h1:addEventListener("touch",move)

local pick
local correct
local incorrect

 	-----레이어 정리--깔리는 것부터 차례대로 
 	sceneGroup:insert(background)
 	sceneGroup:insert(pan)
 	sceneGroup:insert(timerbg)--추가 
 	sceneGroup:insert(score)
 	sceneGroup:insert(time)
 	sceneGroup:insert(foodGroup)
 	sceneGroup:insert(hintBbg)
 	sceneGroup:insert(hintButton)
 	sceneGroup:insert(h1)


 	----------2차시 event-------- 

  	local function dragCarrot( event )
 		if( event.phase == "began" ) then
 			display.getCurrentStage():setFocus( event.target )
 			event.target.isFocus = true
 			-- 드래그 시작할 때
 			audio.play( pick )----------ㅅㅈ 
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

 				-- 드래그 끝났을 때
 				if ( event.target.x > pan.x - 300 and event.target.x < pan.x + 300 
 					and event.target.y > pan.y - 300 and event.target.y < pan.y + 300) then
 						if (event.target == food[1] or event.target == food[2] or event.target == food[5] or event.target == food[6] or event.target == food[9]) then
 							audio.play( correct )-----------ㅅㅈ 
 							display.remove(event.target) 
 							score.text = score.text + 1 

 							if(score.text == '5') then --- !성공!했을 때 
 								score.text = '성공!'
 								time.alpha = 0
								composer.removeScene("game")
								composer.setVariable("score", 5)
								composer.gotoScene( "view2" )---veiw2가 엔딩화면 
 							end
 						else --싫어하는 음식일때는 제자리로 
 							audio.play( incorrect )-----ㅅㅈ
 							event.target.x = event.target.initX
 							event.target.y = event.target.initY
 						end
 				else
 					event.target.x = event.target.initX
 					event.target.y = event.target.initY
 				end

 			else
 				display.getCurrentStage():setFocus( nil )
 				event.target.isFocus = false
 			end
 		end
 	end

 	for i = 1, 10 do
 		food[i]:addEventListener("touch", dragCarrot)
 	end --여기까지 

 	local function counter( event )
 		time.text = time.text - 1

 		if( time.text == '5' ) then
 			time:setFillColor(1, 0, 0)
 		end

 		if( time.text == '-1') then
 			time.alpha = 0

 			if( score.text ~= '성공!' ) then --- !실패!했을 때 
 				score.text = '실패!'
 				composer.removeScene("game") 
				composer.setVariable("score", -1) 
				composer.gotoScene("view2")
 			
 				for i = 1, 10 do
 					if (food[i]) then
 						Runtime:removeEventListener("touch", dragCarrot)--오류해결 
 					end
 				end
 			end
 		end
	end

 	local timeAttack = timer.performWithDelay(1000, counter, 11)

 	pick = audio.loadSound( "audio/pick.mp3" )--음식집을때  
    correct = audio.loadSound( "audio/correct.mp3" )--좋아하는 음식 잘 집어넣었을때 
    incorrect = audio.loadSound("audio/error.mp3") --싫어하는 음식 넣었을때 

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
	
	audio.dispose( pick )
    audio.dispose( correct)
    audio.dispose( incorrect )
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