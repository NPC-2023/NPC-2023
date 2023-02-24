-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------
-- show default status bar (iOS)
--display.setStatusBar( display.DefaultStatusBar )

-- include Corona's "widget" library
--local widget = require "widget"
--local composer = require "composer"
--local physics = require "physics"
--physics.start()
-- event listeners for tab buttons:
--local function onFirstView( event )
	--composer.gotoScene( "view01" )
--end

--onFirstView()	-- invoke first tab button's onPress event manually

--붕어빵 만들기--

local background = display.newRect(display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight)

	local student = {}
 	student[1] = display.newRect(display.contentCenterX-300, display.contentCenterY, 200, 200)
 	student[1]:setFillColor(1, 0, 0)

 	student[2] = display.newRect(display.contentCenterX, display.contentCenterY, 200, 200)
 	student[2]:setFillColor(1, 0.5, 0)

 	student[3] = display.newRect(display.contentCenterX+300, display.contentCenterY, 200, 200)
 	student[3]:setFillColor(1, 1, 0)

 	
 	local stuff = {}
  	stuff[1] = display.newRect(display.contentCenterX, display.contentCenterY+200, 100, 100)
 	stuff[1]:setFillColor(1, 0, 0)

 	stuff[2] = display.newRect(display.contentCenterX, display.contentCenterY+200, 100, 100)
 	stuff[2]:setFillColor(1, 0.5, 0)

 	stuff[3] = display.newRect(display.contentCenterX, display.contentCenterY+200, 100, 100)
 	stuff[3]:setFillColor(1, 1, 0)

 	local score = display.newText(0, display.contentCenterX-500, display.contentCenterY-300)
 	score.size = 100
 	score:setFillColor(0)
 	score.alpha = 0.5

 	local count = display.newText(3, display.contentCenterX+500, display.contentCenterY-300)
 	count.size = 100
 	count:setFillColor(0)
 	count.alpha = 0.5

 	for i = 1, 10, 1 do
	 	for i = 1, 3, 1 do
	 		stuff[i].alpha = 0 
	 	end
	 	stuff[math.random(3)].alpha = 1
	 end

 	local function drag( event )
 		if( event.phase == "began" ) then
 			display.getCurrentStage():setFocus( event.target )
 			event.target.isFocus = true
 			-- 드래그 시작할 때

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
 				--stuff[1]
	 			if ( event.target == stuff[1]) then
	 				if ( event.target.x > student[1].x - 50 and event.target.x < student[1].x + 50
	 					and event.target.y > student[1].y - 50 and event.target.y < student[1].y + 50) then
	 						print("성공")
	 						score.text = score.text + 1
	 				elseif ( (event.target.x > student[2].x - 50 and event.target.x < student[2].x + 50
	 					and event.target.y > student[2].y - 50 and event.target.y < student[2].y + 50)
	 					or(event.target.x > student[3].x - 50 and event.target.x < student[3].x + 50
	 					and event.target.y > student[3].y - 50 and event.target.y < student[3].y + 50) ) then
	 						print("실패")
	 						count.text = count.text - 1
	 				end

	 			--stuff[2]
	 			elseif ( event.target == stuff[2]) then
	 				if ( event.target.x > student[2].x - 50 and event.target.x < student[2].x + 50
	 					and event.target.y > student[2].y - 50 and event.target.y < student[2].y + 50) then
	 						print("성공")
	 						score.text = score.text + 1
	 				elseif ( (event.target.x > student[1].x - 50 and event.target.x < student[1].x + 50
	 					and event.target.y > student[1].y - 50 and event.target.y < student[1].y + 50)
	 					or(event.target.x > student[3].x - 50 and event.target.x < student[3].x + 50
	 					and event.target.y > student[3].y - 50 and event.target.y < student[3].y + 50) ) then
	 						print("실패")
	 						count.text = count.text - 1
	 				end

	 			--stuff[3]
	 			elseif ( event.target == stuff[3]) then
	 				if ( event.target.x > student[3].x - 50 and event.target.x < student[3].x + 50
	 					and event.target.y > student[3].y - 50 and event.target.y < student[3].y + 50) then
	 						print("성공")
	 						score.text = score.text + 1
	 				elseif ( (event.target.x > student[1].x - 50 and event.target.x < student[1].x + 50
	 					and event.target.y > student[1].y - 50 and event.target.y < student[1].y + 50)
	 					or(event.target.x > student[2].x - 50 and event.target.x < student[2].x + 50
	 					and event.target.y > student[2].y - 50 and event.target.y < student[2].y + 50) ) then
	 						print("실패")
	 						count.text = count.text - 1
	 				end
	 			end
	 		end
 		end
 	end

 	for i = 1, 3 do
 		stuff[i]:addEventListener("touch", drag)
 	end

	

