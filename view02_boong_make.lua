-----------------------------------------------------------------------------------------
--
-- view1.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

	--게임 방법
	local gametitle = display.newImage("H_image/title.png")
	gametitle.x, gametitle.y = display.contentWidth/2, display.contentHeight/2

	local title = display.newText("붕어빵 만들기", gametitle.x, gametitle.y+130, native.systemFontBold)
	title.size = 50
	title:setFillColor(0)

	local section = display.newRect(display.contentWidth/2, display.contentHeight*0.8, display.contentWidth, display.contentHeight*0.3)
	section:setFillColor(0.35, 0.35, 0.35, 0.35)
	section.alpha=0

	local script = display.newText("게임방법\n\n40초 안에 붕어빵 8개를 만드세요! \n 반죽과 팥앙금을 순서대로 놓고 터치하세요! \n 붕어빵 8개를 완성하면 게임 클리어 입니다.", section.x+30, section.y-100, native.systemFontBold)
	script.size = 30
	script:setFillColor(1)
	script.x, script.y = display.contentWidth/2, display.contentHeight*0.789
	script.alpha=0

	--붕어빵 만들기--
	local background = display.newImage("H_image/view02_background.png")
	background.x, background.y = display.contentWidth/2, display.contentHeight/2

	local object = {}
	--반죽 봉투
 	local kettle = display.newImage("H_image/kettle.png")
 	kettle.x, kettle.y = display.contentWidth*0.9, display.contentHeight*0.7

 	--팥 봉투
 	local beans = display.newImage("H_image/beans.png")
 	beans.x, beans.y = display.contentWidth*0.9, display.contentHeight*0.3

	--틀
	for i = 1,18,6 do
	 	object[i] = display.newImage("H_image/object01.png")
	 	object[i].x, object[i].y = display.contentWidth*0.1 + i*50, display.contentHeight*0.6

	 	--반죽1
	 	object[i+1] = display.newImage("H_image/object02.png")
	 	object[i+1].x, object[i+1].y = display.contentWidth*0.1 + i*50, display.contentHeight*0.6

	 	--팥
	 	object[i+2] = display.newImage("H_image/object03.png")
	 	object[i+2].x, object[i+2].y = display.contentWidth*0.1 + i*50, display.contentHeight*0.6

	 	--반죽2
	 	object[i+3] = display.newImage("H_image/object04.png")
	 	object[i+3].x, object[i+3].y = display.contentWidth*0.1 + i*50, display.contentHeight*0.6

	 	--틀
	 	object[i+4] = display.newImage("H_image/object05.png")
	 	object[i+4].x, object[i+4].y = display.contentWidth*0.1 + i*50, display.contentHeight*0.6

	 	--완성된 붕어빵
	 	object[i+5] = display.newImage("H_image/object06.png")
	 	object[i+5].x, object[i+5].y = display.contentWidth*0.1 + i*50, display.contentHeight*0.6
	 end

	sceneGroup:insert(background)
	for i = 1, 18, 1 do
		sceneGroup:insert(object[i])
	end
	sceneGroup:insert(kettle)
	sceneGroup:insert(beans)
	sceneGroup:insert(beans)
	sceneGroup:insert(section)
	sceneGroup:insert(script)

	print(object)


 	for i = 1,18,1 do
 		object[i]:scale(0.6,0.6)
 	end

 	kettle:scale(0.4,0.4)
 	beans:scale(0.4,0.4)

 	for i = 1, 18, 6 do
		object[i+1].alpha = 0
		object[i+2].alpha = 0
		object[i+3].alpha = 0
		object[i+4].alpha = 0
		object[i+5].alpha = 0
	end

	kettle:toFront()
 	beans:toFront()
 	section:toFront()
 	script:toFront()

	local turn1 = 1
	local turn2 = 1
	local turn3 = 1

	local function scriptremove(event)
		timer1=timer.performWithDelay(500, spawn, 0)
		section.alpha=0
		script.alpha=0
	end	

	local function titleremove(event)
		gametitle.alpha=0
		title.alpha=0
		section.alpha=1
		script.alpha=1
		section:addEventListener("tap", scriptremove)
	end


	local score = display.newText(0, display.contentWidth*0.1, display.contentHeight*0.15)
 	score.size = 100
 	score:setFillColor(0)
 	score.alpha = 0.5

 	local time= display.newText(40, display.contentWidth*0.9, display.contentHeight*0.15)
 	time.size = 100
 	time:setFillColor(0)
 	time.alpha = 0.5

 	sceneGroup:insert(score)
 	sceneGroup:insert(time)
 
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
 				-- 드래그 끝났을 때
 				--turn1
 				if ( event.target.x > object[1].x - 50 and event.target.x < object[1].x + 50
 					and event.target.y > object[1].y - 100 and event.target.y < object[1].y + 100) then

 					if ( event.target == kettle) then
 						if( turn1 == 1) then
 							object[2].alpha = 1
 							turn1 = turn1 + 1
 						elseif (turn1 == 3) then
 							object[4].alpha = 1
 							turn1 = turn1 + 1
 						end
					elseif (event.target == beans) then
						if( turn1 == 2) then
							object[3].alpha = 1
							turn1 = turn1 + 1
						end
 					end
 				end
 				--turn2
 				if ( event.target.x > object[7].x - 50 and event.target.x < object[7].x + 50
 					and event.target.y > object[7].y - 100 and event.target.y < object[7].y + 100) then

 					if ( event.target == kettle) then
 						if( turn2 == 1) then
 							object[8].alpha = 1
 							turn2 = turn2 + 1
 						elseif (turn2 == 3) then
 							object[10].alpha = 1
 							turn2 = turn2 + 1
 						end
					elseif (event.target == beans) then
						if( turn2 == 2) then
							object[9].alpha = 1
							turn2 = turn2 + 1
						end
 					end
 				end
 				--turn3
 				if ( event.target.x > object[13].x - 50 and event.target.x < object[13].x + 50
 					and event.target.y > object[13].y - 100 and event.target.y < object[13].y + 100) then

 					if ( event.target == kettle) then
 						if( turn3 == 1) then
 							object[14].alpha = 1
 							turn3 = turn3 + 1
 						elseif (turn3 == 3) then
 							object[16].alpha = 1
 							turn3 = turn3 + 1
 						end
					elseif (event.target == beans) then
						if( turn3 == 2) then
							object[15].alpha = 1
							turn3 = turn3 + 1
						end
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

 	local function sleep(sec)
	    local t = os.clock()
	    while os.clock() - t <= sec do
	    end
	end


 	local function touchEventListener1( event )
 		--turn1
 		if( event.phase == "began" ) then
 			if( turn1 == 4) then
				object[5].alpha = 1
				turn1 = turn1 + 1
 			elseif( turn1 == 5 ) then
 				object[6].alpha = 1
 				turn1 = turn1 + 1
 			elseif( turn1 == 6 ) then
 				turn1 = 1
 				for i = 2,6,1 do
 					object[i].alpha = 0
				end
 				score.text = score.text + 1
 	--게임 성공 판별 기준 score.text == '8'이되면 ending으로 이동------------------------------------------------------------------------
 				if( score.text == '8') then
			 		time.alpha = 0
			 		score.text = '성공'
			 		composer.gotoScene("view02_ending")
			 	end
 			end
 		end
 	end
 	local function touchEventListener2( event )
 		--turn2
 		if( event.phase == "began" ) then
 			if( turn2 == 4) then
				object[11].alpha = 1
				turn2 = turn2 + 1
 			elseif( turn2 == 5 ) then
 				object[12].alpha = 1
 				turn2 = turn2 + 1
 			elseif( turn2 == 6 ) then
 				turn2 = 1
 				for i = 8,12,1 do
 					object[i].alpha = 0
				end
 				score.text = score.text + 1
 	--게임 성공 판별 기준 score.text == '8'이되면 ending으로 이동------------------------------------------------------------------------
 				if( score.text == '8') then
			 		time.alpha = 0
			 		score.text = '성공'
			 		composer.gotoScene("view02_ending")
			 	end
 			end
 		end
 	end
 	local function touchEventListener3( event )
 		--turn3
 		if( event.phase == "began" ) then
 			if( turn3 == 4) then
				object[17].alpha = 1
				turn3 = turn3 + 1
 			elseif( turn3 == 5 ) then
 				object[18].alpha = 1
 				turn3 = turn3 + 1
 			elseif( turn3 == 6 ) then
 				turn3 = 1
 				for i = 14,18,1 do
 					object[i].alpha = 0
				end
 				score.text = score.text + 1
 	--게임 성공 판별 기준 score.text == '8'이되면 ending으로 이동------------------------------------------------------------------------
 				if( score.text == '8') then
			 		time.alpha = 0
			 		score.text = '성공'
			 		composer.gotoScene("view02_ending")
			 	end
 			end
 		end
 	end

 	--time
 	local function counter( event )
	 	time.text = time.text - 1

	 	if( time.text == '5' ) then
	 		time:setFillColor(1, 0, 0)
	 	end
	 	if( time.text == '-1') then
	 		time.alpha = 0
	 		score.text = '실패'
	 	--게임 실패 판별 기준 time.text == '-1'이되면 ending으로 이동------------------------------------------------------------------------
			composer.gotoScene("view02_ending") -- 추가
		end
	 end

	 local timeAttack = timer.performWithDelay(1000, counter, 41)


 	object[1]:addEventListener("touch", touchEventListener1)
 	object[7]:addEventListener("touch", touchEventListener2)
 	object[13]:addEventListener("touch", touchEventListener3)
 	gametitle:addEventListener("tap", titleremove)

 	--코드 끝

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
		
		composer.removeScene('view02_boong_make') -- 추가

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