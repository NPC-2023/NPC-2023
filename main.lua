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

	local object = {}
	--틀
 	object[1] = display.newRect(display.contentCenterX, display.contentCenterY, 300, 300)
 	object[1]:setFillColor(1, 0, 0)

 	--반죽1
 	object[2] = display.newRect(display.contentCenterX, display.contentCenterY, 200, 200)
 	object[2]:setFillColor(1, 0.5, 0)

 	--팥
 	object[3] = display.newRect(display.contentCenterX, display.contentCenterY, 100, 100)
 	object[3]:setFillColor(1, 1, 0)

 	--반죽2
 	object[4] = display.newRect(display.contentCenterX, display.contentCenterY, 50, 50)
 	object[4]:setFillColor(1, 0.5, 1)

 	--틀
 	object[5] = display.newRect(display.contentCenterX, display.contentCenterY, 20, 20)
 	object[5]:setFillColor(0, 1, 1)

 	--완성된 붕어빵
 	object[6] = display.newRect(display.contentCenterX, display.contentCenterY, 20, 10)
 	object[6]:setFillColor(1, 0.5, 0.5)

 	--반죽 봉투
 	object[7] = display.newRect(display.contentCenterX + 400, display.contentCenterY-100, 100, 80)
 	object[7]:setFillColor(1, 0.5, 0)

 	--팥 봉투
 	object[8] = display.newRect(display.contentCenterX + 400, display.contentCenterY+100, 100, 80)
 	object[8]:setFillColor(1, 1, 0)


	local objectGroup = display.newGroup()

 	objectGroup:insert(object[1])
 	objectGroup:insert(object[2])
 	objectGroup:insert(object[3])
 	objectGroup:insert(object[4])
	objectGroup:insert(object[5])
	objectGroup:insert(object[6])
	objectGroup:insert(object[7])
	objectGroup:insert(object[8])

	object[2].alpha = 0
	object[3].alpha = 0
	object[4].alpha = 0
	object[5].alpha = 0
	object[6].alpha = 0

	local turn = 1

	local count = display.newText(0, display.contentWidth*0.1, display.contentHeight*0.15)
 	count.size = 100
 	count:setFillColor(0)
 	count.alpha = 0.5
 
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
 				if ( event.target.x > object[1].x - 50 and event.target.x < object[1].x + 50
 					and event.target.y > object[1].y - 50 and event.target.y < object[1].y + 50) then

 					if ( event.target == object[7]) then
 						if( turn == 1) then
 							object[2].alpha = 1
 							turn = turn + 1
 						elseif (turn == 3) then
 							object[4].alpha = 1
 							turn = turn + 1
 						end
					elseif (event.target == object[8]) then
						if( turn == 2) then
							object[3].alpha = 1
							turn = turn + 1
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

 	object[7]:addEventListener("touch", drag)
 	object[8]:addEventListener("touch", drag)

 	local function touchEventListener( event )
 		if( event.phase == "began" ) then
 			if( turn == 4) then
				object[5].alpha = 1
				turn = turn + 1
 			elseif( turn == 5 ) then
 				object[6].alpha = 1
 				turn = turn + 1
 			elseif( turn == 6 ) then
 				turn = 1
 				object[6].alpha = 0
 				object[5].alpha = 0
 				object[4].alpha = 0
 				object[3].alpha = 0
 				object[2].alpha = 0
 				count.text = count.text + 1
 			end
 		end
 	end
 
 	object[1]:addEventListener("touch", touchEventListener)





	