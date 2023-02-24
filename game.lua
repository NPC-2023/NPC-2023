-----------------------------------------------------------------------------------------
--
-- view2.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view
	
	local gametitle = display.newText("게임 시작\n\n", display.contentWidth/2, display.contentHeight/2, native.systemFontBold)
	gametitle.size=80
	--local gametitle = display.newImageRect("image/carrot.png", display.contentWidth, display.contentHeight)
	gametitle.x, gametitle.y = display.contentWidth/2, display.contentHeight/2
	
	local section = display.newRect(display.contentWidth/2, display.contentHeight*0.8, display.contentWidth, display.contentHeight*0.3)
	section:setFillColor(0.35, 0.35, 0.35, 0.35)
	section.alpha=0
	
	local script = display.newText("                      게임방법\n\n물건을 줍자\n\n*쓰레기:-1  생선뼈:GameOver  나머지 물건:+1", section.x+30, section.y-100, native.systemFontBold)
	script.size = 30
	script:setFillColor(1)
	script.x, script.y = display.contentWidth/2, display.contentHeight*0.789
	script.alpha=0

	local background = display.newImageRect("image/background.png", display.contentWidth, display.contentHeight)
	background.x, background.y = display.contentWidth/2, display.contentHeight/2
	--배경이미지:newImageRect()
	
	local physics = require("physics")
	physics.start()
	physics.setDrawMode("hybrid")

	local setting = display.newImageRect("image/setting.png", 100, 100)
	setting.x, setting.y = display.contentWidth*0.9 + 0.5, display.contentHeight*0.4
	setting.alpha = 0

	--땅 객체 생성(나뭇잎)--
	local tree = display.newImageRect("image/carrot.png", 200, 1000)
	tree.x, tree.y = display.contentCenterX, 500

	-- Create player
	local cat = display.newImageRect("image/cat.png", 150, 120 )
	--local cat_outline = graphics.newOutline(1, "image/cat.png")
	cat.name="cat"

	physics.addBody(cat, "dynamic", {friction=1, outline=cat_outline})
	cat.isFixedRotation = true 
	
	---버튼---
	local arrow = {}
	local arrowGroup = display.newGroup()
	arrow[1] = display.newImageRect("image/obj2.png", 100, 100)
	arrow[1].x, arrow[1].y = 900, 625
	arrow[1].name = "left"
	arrow[2] = display.newImageRect("image/obj3.png", 100, 100)
	arrow[2].x, arrow[2].y = arrow[1].x+100, 625
	arrow[2].name = "right"


	arrowGroup:insert(arrow[1])
	arrowGroup:insert(arrow[2])

	local wall = {}
	wall[1] = display.newRect(0, background.y, 30, background.height)
	wall[2] = display.newRect(background.width, background.y, 30, background.height)
	wall[3] = display.newRect(background.x, 0, background.width, 30)
	wall[4] = display.newRect(background.x, background.height, background.width, 30)

	for i = 1, #wall do
		physics.addBody(wall[i], "static")
		sceneGroup:insert(wall[i])
		wall[i].name = "wall"
	end

	---버튼---
	local arrow = {}
	local arrowGroup = display.newGroup()
	arrow[1] = display.newImageRect("image/obj2.png", 100, 100)
	arrow[1].x, arrow[1].y = 900, 625
	arrow[1].name = "left"
	arrow[2] = display.newImageRect("image/obj3.png", 100, 100)
	arrow[2].x, arrow[2].y = arrow[1].x+100, 625
	arrow[2].name = "right"


	arrowGroup:insert(arrow[1])
	arrowGroup:insert(arrow[2])


	local objectGroup = display.newGroup()
	local object = {}
	local objects = {"1", "2"}
	local i = 1
	local num = 100
	local function generate1()
		object[1] = display.newImageRect(objectGroup,"image/bough.png", 130, 30)
		object[1].x, object[1].y = 470, 600  --왼
		object[2] = display.newImageRect(objectGroup,"image/bough.png", 130, 30)
		object[2].x, object[2].y = 780, object[1].y-100  --오
		object[3] = display.newImageRect(objectGroup,"image/bough.png", 130, 30)
		object[3].x, object[3].y = 470, object[2].y-100  --왼
		object[4] = display.newImageRect(objectGroup,"image/bough.png", 130, 30)
		object[4].x, object[4].y = 470, object[3].y-100  --왼
		object[5] = display.newImageRect(objectGroup,"image/bough.png", 130, 30)
		object[5].x, object[5].y = 780, object[4].y-100  --오
		object[6] = display.newImageRect(objectGroup,"image/bough.png", 130, 30)
		object[6].x, object[6].y = 780, object[5].y-100  --오
		
		cat.x, cat.y = object[1].x, object[1].y -30
		arrow[3] = "left"

		for i=1,6 do
			physics.addBody(object[i], "static")
			sceneGroup:insert(object[i])
			object[i].name = "object"
		end
	end

	local function generate2()
		object[1] = display.newImageRect(objectGroup,"image/bough.png", 130, 30)
		object[1].x, object[1].y = 780, 600  --오
		object[2] = display.newImageRect(objectGroup,"image/bough.png", 130, 30)
		object[2].x, object[2].y = 780, object[1].y-100  --오
		object[3] = display.newImageRect(objectGroup,"image/bough.png", 130, 30)
		object[3].x, object[3].y = 470, object[2].y-100  --왼
		object[4] = display.newImageRect(objectGroup,"image/bough.png", 130, 30)
		object[4].x, object[4].y = 780, object[3].y-100  --오
		object[5] = display.newImageRect(objectGroup,"image/bough.png", 130, 30)
		object[5].x, object[5].y = 470, object[4].y-10000  --왼
		object[6] = display.newImageRect(objectGroup,"image/bough.png", 130, 30)
		object[6].x, object[6].y = 780, object[5].y-100  --오
		
		cat.x, cat.y = object[1].x, object[1].y -30
		arrow[3] = "right"

		for i=1,6 do
			physics.addBody(object[i], "static")
			sceneGroup:insert(object[i])
			object[i].name = "object"
		end
	end
	--local bough_outline = graphics.newOutline(1, "image/bough.png")


	function arrowTab(event)
		x = cat.x
		y = cat.y
		if (event.target.name == "left") then
			if (event.target.name == arrow[3]) then
				transition.to(cat, {time=10, y=(y-50)})--게임오버
		    else
		    	transition.to(cat, {time=10, x=(x-300), y=(y-50)})
		    	arrow[3] = "left"
		    end
		else --오른쪽 버튼 클릭
		   	if (event.target.name == arrow[3]) then
				transition.to(cat, {time=10, y=(y-50)})
		    else
		    	transition.to(cat, {time=10, x=(x+300), y=(y-50)})
		    	arrow[3] = "right"
		    end
		end
		physics.addBody(cat,{friction=1, outline=cat_outline})
		cat.isFixedRotation = true 
	end

	for i = 1, 2 do
		arrow[i]:addEventListener("tap", arrowTab)
		sceneGroup:insert(arrow[i])
	end


--	timer1 = timer.performWithDelay(500, arrowTab, 0)

	local function pagemove()
		display.remove(objectGroup)
		display.remove(tree)
		display.remove(arrow)
		--timer.cancel(timer1)
		display.remove(cat)
	end
	local function onCollision(event)
	   if(event.target.name == "wall") then
	   	print("어쩔~")
	   		for i=1,6 do
		   		local obj = object[i] 
		   		obj.alpha = 0
	   		end
	   		generate2()
		end
	end

 	local function startGame(event)
 		background.alpha = 1
 		setting.alpha = 1
		section.alpha = 0
		script.alpha = 0
		generate1()
	end

	--처음 실행
	local function titleremove(event)
		gametitle.alpha = 0
		section.alpha = 1
		script.alpha = 1
		section:addEventListener("tap", startGame)
	end

	gametitle:addEventListener("tap", titleremove)
	--timer1 = timer.performWithDelay(1000, generate, 10)
	
	cat:addEventListener("collision", onCollision)
	sceneGroup:insert(background)
	sceneGroup:insert(objectGroup)
	sceneGroup:insert(cat)
	sceneGroup:insert(arrowGroup)

	--local function pagemove()

	--	timer.cancel( timer1 )
	--	display.remove(cat)
	--end
	-----게임 종료---
	--local function onCollision(event)
	--	if event.other.name == "wall" then		
	--		pagemove()
	--		audio.pause(explosionSound)
		--	
		--	
		--else
		--	pagemove()
		--	audio.pause(explosionSound)
	--		composer.removeScene("game")
		--	composer.gotoScene( "view02_over" )
	--	end
	--end

	--local function onCollision2(e)
	--	if e.other.name == "wall" then
	--		display.remove(e.other)
	--	end
	--end
--	display.remove(cat)
--	cat:addEventListener("collision", onCollision)


--	for i = 1,119 do
--		if(i % 30 == 0) then
--			m = m + 0.08
--			num = 1
--		end
		--cup[i] = display.newImageRect(leafGroup, "image/leaf" .. math.random(1,3) .. ".png", 150, 150)
		--cup[i].x, leaf[i].y = display.contentWidth*0.15 + 30*num, display.contentHeight * (0.8 - m)
		--num = num + 1
--	end
	--local score = display.newText(0, display.contentWidth*0.1, display.contentWidth*0.15)
	--score.size = 100 --글씨 사이즈--
	--score:setFillColor(0)
	--score.alpha = 0.5

	----레이어정리----




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
