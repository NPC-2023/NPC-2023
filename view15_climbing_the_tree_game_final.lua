-----------------------------------------------------------------------------------------
--
-- view03_climbing_the_tree_game_final.lua -> 나무 올라가기 게임 화면
--
-- ## 변경 사항
-- (1) 15번째 줄 게임 타이틀 이미지 변경 및 gameName 추가
-- (2) 327번째 줄 titleremove 함수를 아래로 이동 및  
--     hint:addEventListener("tap", hintShow), display.remove(gameName)를 titleremove 함수로 이동
--
-- ## 게임 성공 시 
-- 244번째 줄 (result: 1)를 view03_climbing_the_tree_game_over로 전달
--
-- ## 게임 실패 시 
-- 142번째 줄 (result: 0)를 view03_climbing_the_tree_game_over로 전달
-----------------------------------------------------------------------------------------
local composer = require( "composer" )
local physics = require("physics")
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view
	physics.start()

	local gametitle = display.newImageRect("image/climbing_the_tree/미니게임 타이틀.png", 687/1.2, 604/1.2)
	gametitle.x, gametitle.y = display.contentWidth/2, display.contentHeight/2

	local gameName = display.newText("나무 올라가기", 0, 0, "ttf/Galmuri7.ttf", 45)
	gameName:setFillColor(0)
	gameName.x, gameName.y=display.contentWidth/2, display.contentHeight*0.65

	local section = display.newRect(display.contentWidth/2, display.contentHeight*0.8, display.contentWidth, display.contentHeight*0.3)
	section:setFillColor(0.35, 0.35, 0.35, 0.35)
	section.alpha=0

	local script = display.newText("게임방법\n\n방향키를 눌러\n나무를 올라가 꽃을 모두 획득하세요!", section.x+30, section.y-100, native.systemFontBold)
	script.size = 30
	script:setFillColor(1)
	script.x, script.y = display.contentWidth/2, display.contentHeight*0.789
	script.alpha=0

	local background = display.newImage("image/climbing_the_tree/배경.png")
	background.x, background.y=display.contentWidth/2, display.contentHeight/2


	-- 힌트 버튼
	local hint = display.newImageRect("image/climbing_the_tree/확인,힌트 버튼.png", 768/3, 768/3)
	hint.x, hint.y = display.contentWidth*0.1, display.contentHeight*0.1

	-- 힌트 글자

	local hintTextScript = display.newText( "HINT",  display.contentWidth*0.1, display.contentHeight*0.09, native.systemFont, 30 )
	hintTextScript:setFillColor( 1, 1, 1 )


	local itemGroup = display.newGroup()
	local item = {}

	item[1] = display.newImageRect(itemGroup, "image/climbing_the_tree/꽃.png", 512/4, 512/4)
 	item[1].x, item[1].y = display.contentWidth*0.15, display.contentHeight*0.7
 	item[1].name = "item1"

 	item[2] = display.newImageRect(itemGroup, "image/climbing_the_tree/꽃.png", 512/4, 512/4)
 	item[2].x, item[2].y = display.contentWidth*0.45, display.contentHeight*0.42
 	item[2].name = "item2"

 	item[3] = display.newImageRect(itemGroup, "image/climbing_the_tree/꽃.png", 512/4, 512/4)
 	item[3].x, item[3].y = display.contentWidth*0.8, display.contentHeight*0.25
 	item[3].name = "item3"

 	item[4] = display.newImageRect(itemGroup, "image/climbing_the_tree/꽃.png", 512/4, 512/4)
 	item[4].x, item[4].y = display.contentWidth*0.25, display.contentHeight*0.25
 	item[4].name = "item4"



 	local cat = display.newImageRect("image/climbing_the_tree/나무타는고앵.png", 768/4, 768/4)
	cat.x, cat.y = display.contentWidth*0.47, display.contentHeight*0.9
	physics.addBody(cat, 'static')
	cat.name = 'cat'

	local keyGroup = display.newGroup()
 	local key = {}
 	-- 왼쪽
 	key[1] = display.newImageRect(keyGroup, "image/climbing_the_tree/좌우상하버튼.png", 111/1.5, 115/1.5)
	key[1].xScale = -1
	key[1].x, key[1].y = display.contentWidth*0.81, display.contentHeight*0.9
	key[1].name ="left"

	-- 아래
	key[2] = display.newImageRect(keyGroup, "image/climbing_the_tree/좌우상하버튼.png", 111/1.5, 115/1.5)
	key[2].rotation = 90
	key[2].x, key[2].y = display.contentWidth*0.88, display.contentHeight*0.9
	key[2].name ="down"

	-- 오른쪽
	key[3] = display.newImageRect(keyGroup, "image/climbing_the_tree/좌우상하버튼.png", 111/1.5, 115/1.5)
	key[3].x, key[3].y = display.contentWidth*0.95, display.contentHeight*0.9
	key[3].name ="right"

	-- 위
	key[4] = display.newImageRect(keyGroup, "image/climbing_the_tree/좌우상하버튼.png", 111/1.5, 115/1.5)
	key[4].rotation = -90
	key[4].x, key[4].y = display.contentWidth*0.88, display.contentHeight*0.78
	key[4].name ="top"

	local itemFindGroup = display.newGroup()
 	local itemFind = {}
 	for i = 1, 4 do
 		itemFind[i] = display.newImageRect(itemFindGroup, "image/climbing_the_tree/물음표.png", 518/7, 518/7)
 		itemFind[i].x, itemFind[i].y = display.contentWidth*0.26 + 60*(i-1), display.contentHeight*0.1
 	end

 	local floor = display.newImage("image/climbing_the_tree/invisible.png")
	floor.x, floor.y = display.contentWidth/2, display.contentHeight*0.95
	floor.name = 'floor'
	floor.alpha=0
	physics.addBody(floor, 'static')

	local objects = {"1", "2", "3"}
	local i=1
	local objectGroup = display.newGroup()
	local object = { }	

	local function spawn()
		local objIdx = math.random(#objects)
		print(objIdx)
		local objName = objects[objIdx]
		
		object[i]= display.newImageRect(objectGroup,"image/climbing_the_tree/장애물(" .. objName .. ").png", 768/7, 768/7)
		object[i].x = display.contentWidth*0.5 + math.random(-490, 490)
		object[i].y = 0

		object[i].type="obstacle"
		
		physics.addBody(object[i])
		object[i].name='object'
		i = i+1
	end

	local result = 0

	local function onCollision(e)
		if e.other.name == 'object' then
			if e.other.type == 'obstacle' then
				print("실패!")
				timer.cancelAll()
				display.remove(cat)
				display.remove(objectGroup)
				composer.removeScene("view15_climbing_the_tree_game_final")
 				composer.setVariable("result", 0)
 				composer.gotoScene("view16_climbing_the_tree_game_over")
			end
		end
	end

	local function onCollision2(e)
		if e.other.name == 'object' then
			display.remove(e.other)
		end
	end


 	local score = 0


	function arrowTab( event )
		x_max = 950
		x_min = 370
		y_max = 640
		y_min = 100
		x = cat.x
		y = cat.y

		print(cat.x)

		if(event.target.name == "left") then
			if(x > x_min) then
				cat.x = x-350
			end

		end

		if(event.target.name == "right") then
			if(x < x_max) then
				cat.x = x+350
			end
		end

		if(event.target.name == "top") then
			if(y > y_min) then
				cat.y = y-20
			end

		end

		if(event.target.name == "down") then
			if(y < y_max) then
				cat.y = y+20
			end
		end


		for i = 1, 4 do

			if (item[i].x ~= nil and item[i].y ~= nil) then


			if ( (item[i] ~= nil ) and cat.x > (item[i].x - 110) and (cat.x < item[i].x + 110)
 					and (cat.y > item[i].y - 25) and cat.y < (item[i].y + 25)) then
				display.remove(item[i]) -- 당근 삭제하기

				score = score + 1

				if (score == 1) then
					display.remove(itemFind[1])
					itemFind[1] = display.newImageRect(itemFindGroup, "image/climbing_the_tree/꽃.png", 512/6, 512/6)
					itemFind[1].x, itemFind[1].y = display.contentWidth*0.26, display.contentHeight*0.1
					itemFindGroup:insert(itemFind[1])
				end

				
				if(score == 2) then
					display.remove(itemFind[2])
					itemFind[2] = display.newImageRect(itemFindGroup, "image/climbing_the_tree/꽃.png", 512/6, 512/6)
					itemFind[2].x, itemFind[2].y = display.contentWidth*0.26 + 60, display.contentHeight*0.1
					itemFindGroup:insert(itemFind[2])
				end

				if(score == 3) then
					display.remove(itemFind[3])
					itemFind[3] = display.newImageRect(itemFindGroup, "image/climbing_the_tree/꽃.png", 512/6, 512/6)
					itemFind[3].x, itemFind[3].y = display.contentWidth*0.26 + 120, display.contentHeight*0.1
					itemFindGroup:insert(itemFind[3])
				end

				if (score == 4) then
					display.remove(itemFind[4])
					itemFind[4] = display.newImageRect(itemFindGroup, "image/climbing_the_tree/꽃.png", 512/6, 512/6)
					itemFind[4].x, itemFind[4].y = display.contentWidth*0.26 + 180, display.contentHeight*0.1
					itemFindGroup:insert(itemFind[4])

					timer.cancelAll()
					display.remove(objectGroup)
					display.remove(cat)
					composer.removeScene("view15_climbing_the_tree_game_final")
 					composer.setVariable("result", 1)
 					composer.gotoScene("view16_climbing_the_tree_game_over")
				end
			end
 		end
 	end
	end

	-- 스크립트 제거하지않고 힌트 버튼을 누른 경우 : 0 / 아닌 경우 : 1
	local pagecheck


	local function scriptremove(event)
		timer1=timer.performWithDelay(3500, spawn, 0)
		section.alpha=0
		script.alpha=0
		pagecheck = 1
		print("scriptremove", pagecheck)
		for i = 1, 4 do
			key[i]:addEventListener("tap", arrowTab)
		end
	end	


	local function pagemove()
		display.remove(objectGroup)
		display.remove(floor)
		display.remove(cat)
	end	


	local hintClose
	local hintScript
	local hintCloseText
	local hintContentScript


	local function hintHide(event)
		display.remove(hintScript)
		display.remove(hintClose)
		display.remove(hintCloseText)
		display.remove(hintContentScript)
		timer.resumeAll()

		print("hide", pagecheck)
	
		if(pagecheck == 1) then
			timer1=timer.performWithDelay(3500, spawn, 0)
			i=1
			objectGroup = display.newGroup()
			object = { }	
		end
		
	end

	local function hintShow(event)
		print("hintShow", pagecheck)
		if(pagecheck == 1) then
			print("hintShow", pagecheck)
			timer.pauseAll()
			display.remove(objectGroup)
		end
		hintScript = display.newImageRect("image/lost_stuId/메뉴바.png", 1024/1.5, 1024/1.5)
		hintScript.x, hintScript.y = display.contentWidth/2, display.contentHeight/2
		sceneGroup:insert(hintScript)

		hintContentScript = display.newText("힌트\n1. 방향키를 클릭해서 나무를 올라가봐!\n2. 내려오는 새와 구름, 나뭇잎을 피해야 해!", section.x+30, section.y-100, native.systemFontBold)
		hintContentScript.size = 30
		hintContentScript:setFillColor(0, 0, 0)
		hintContentScript.x, hintContentScript.y = display.contentWidth/2, display.contentHeight*0.4
		sceneGroup:insert(hintContentScript)

		hintClose = display.newImageRect("image/lost_stuId/확인,힌트 버튼.png", 768/4, 768/4)
		hintClose.x, hintClose.y = display.contentWidth/2, display.contentHeight*0.6
		sceneGroup:insert(hintClose)

		hintCloseText = display.newText( "확 인", display.contentWidth/2, display.contentHeight*0.59, native.systemFont, 30 )
		hintCloseText:setFillColor( 1, 1, 1 )	-- black
		sceneGroup:insert(hintCloseText)

		hintClose:addEventListener("tap", hintHide)

	end

	local function titleremove(event)
		gametitle.alpha=0
		section.alpha=1
		script.alpha=1
		section:addEventListener("tap", scriptremove)
		hint:addEventListener("tap", hintShow)
		display.remove(gameName)
		pagecheck=0
	end

	gametitle:addEventListener("tap", titleremove)
	cat:addEventListener("collision", onCollision)
	floor:addEventListener("collision", onCollision2)

	sceneGroup:insert(background)
	sceneGroup:insert(floor)
	sceneGroup:insert(cat)
	for i = 1, 4 do
		-- key[i]:addEventListener("tap", arrowTab)
		sceneGroup:insert(key[i])
	end
	sceneGroup:insert(itemGroup)

	sceneGroup:insert(hint)
	sceneGroup:insert(hintTextScript)
	sceneGroup:insert(itemFindGroup)
	sceneGroup:insert(itemGroup)
	

	

	sceneGroup:insert(section)
	sceneGroup:insert(script)

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