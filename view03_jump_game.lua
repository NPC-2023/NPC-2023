-----------------------------------------------------------------------------------------
--
-- view2.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local physics = require("physics")
local scene = composer.newScene()
local loadsave = require( "loadsave" )
local json = require( "json" )


function scene:create( event )
	local sceneGroup = self.view
	
	composer.setVariable("gameName", "view03_jump_game")
	physics.start()
	--physics.setDrawMode( "hybrid" )

	local background = display.newImageRect("image/jump/background_water.png", display.contentWidth*3, display.contentHeight)
	background.x = display.contentCenterX
    background.y = display.contentCenterY
	background.alpha = 0.5
	
	local section = display.newRect(display.contentCenterX, display.contentCenterY*1.5, background.width, background.y*0.8)
	section:setFillColor(0.35, 0.35, 0.35, 0.35)

	local script = display.newText("게임방법\n\n방향키와 점프키를 이용해 고양이이에게 츄르를 가져다주세요!\n\n고양이가 벽면에 닿으면 GAMEOVER!", section.x+30, section.y-100, native.systemFontBold)
	script.size = 20
	script:setFillColor(1)
	script.x, script.y = section.x-200, section.y

	local bRock_outline = graphics.newOutline(1, "image/jump/bigRock.png")
	local leaf1_outline = graphics.newOutline(1, "image/jump/leaf1.png")
	local leaf2_outline = graphics.newOutline(1, "image/jump/leaf2.png")
	local sRock_outline = graphics.newOutline(1, "image/jump/smallRock.png")
	local plant1_outline = graphics.newOutline(1, "image/jump/plant1.png")
	local plant2_outline = graphics.newOutline(1, "image/jump/plant2.png")
	local rock_outline = graphics.newOutline(1, "image/jump/rock.png")

	local objectGroup = display.newGroup()
	local leaf1 = {}
	leaf1[1] = display.newImageRect(objectGroup, "image/jump/leaf1.png", display.contentWidth/1.5, display.contentHeight/4.5)
	leaf1[1].x, leaf1[1].y = display.contentCenterX-380, display.contentCenterY*0.3
	leaf1[2] = display.newImageRect(objectGroup, "image/jump/leaf1.png", display.contentWidth/1.7, display.contentHeight/4.8)
	leaf1[2].x, leaf1[2].y = display.contentCenterX-50, display.contentCenterY*1.8

	local leaf2 = {}
	leaf2[1] = display.newImageRect(objectGroup, "image/jump/leaf2.png", display.contentWidth/1.7, display.contentHeight/5)
	leaf2[1].x, leaf2[1].y = display.contentCenterX*3.4, display.contentCenterY-100

	local plant1 = {}
	plant1[1] = display.newImageRect(objectGroup, "image/jump/plant1.png", display.contentWidth/3.5, display.contentHeight/8.5)
	plant1[1].x, plant1[1].y = display.contentCenterX-400, display.contentCenterY*1.8
	plant1[2] = display.newImageRect(objectGroup, "image/jump/plant1.png", display.contentWidth/5, display.contentHeight/10)
	plant1[2].x, plant1[2].y = display.contentCenterX*2, display.contentCenterY-20

	local plant2 = {}
	plant2[1] = display.newImageRect(objectGroup, "image/jump/plant2.png", display.contentWidth/3.5, display.contentHeight/12)
	plant2[1].x, plant2[1].y = display.contentCenterX*3, display.contentCenterY*1.55
	plant2[2] = display.newImageRect(objectGroup, "image/jump/plant2.png", display.contentWidth/5, display.contentHeight/11)
	plant2[2].x, plant2[2].y = display.contentCenterX-310, display.contentCenterY+35
	
	local bRock = {}
	bRock[1] = display.newImageRect(objectGroup, "image/jump/bigRock.png", display.contentWidth/2.3, display.contentHeight/6)
	bRock[1].x, bRock[1].y = display.contentCenterX, display.contentCenterY

	local sRock = {}
	sRock[1] = display.newImageRect(objectGroup, "image/jump/smallRock.png", display.contentWidth/3.5, display.contentHeight/6)
	sRock[1].x, sRock[1].y = display.contentCenterX-320, display.contentCenterY*1.6
	sRock[2] = display.newImageRect(objectGroup, "image/jump/smallRock2.png", display.contentWidth/3.5, display.contentHeight/6)
	sRock[2].x, sRock[2].y = sRock[1].x+150, sRock[1].y+10
	sRock[3] = display.newImageRect(objectGroup, "image/jump/smallRock.png", display.contentWidth/3.3, display.contentHeight/5.5)
	sRock[3].x, sRock[3].y = display.contentCenterX*1.5, display.contentCenterY*1.8
	sRock[4] = display.newImageRect(objectGroup, "image/jump/smallRock.png", display.contentWidth/3.5, display.contentHeight/6)
	sRock[4].x, sRock[4].y = sRock[3].x+70, display.contentCenterY*1.65
	sRock[5] = display.newImageRect(objectGroup, "image/jump/smallRock2.png", display.contentWidth/3.3, display.contentHeight/5.5)
	sRock[5].x, sRock[5].y = sRock[3].x+150, display.contentCenterY*1.8
	sRock[6] = display.newImageRect(objectGroup, "image/jump/smallRock2.png", display.contentWidth/3.5, display.contentHeight/6)
	sRock[6].x, sRock[6].y = display.contentCenterX*3.1, display.contentCenterY+50
	sRock[7] = display.newImageRect(objectGroup, "image/jump/smallRock.png", display.contentWidth/3.5, display.contentHeight/6)
	sRock[7].x, sRock[7].y = display.contentCenterX*2.6, display.contentCenterY-55
	sRock[8] = display.newImageRect(objectGroup, "image/jump/smallRock.png", display.contentWidth/3.3, display.contentHeight/5.5)
	sRock[8].x, sRock[8].y = display.contentCenterX-130, display.contentCenterY-20
	sRock[9] = display.newImageRect(objectGroup, "image/jump/smallRock2.png", display.contentWidth/3.8, display.contentHeight/6.3)
	sRock[9].x, sRock[9].y = display.contentCenterX-220, display.contentCenterY+5
	sRock[10] = display.newImageRect(objectGroup, "image/jump/smallRock2.png", display.contentWidth/3.8, display.contentHeight/6.3)
	sRock[10].x, sRock[10].y = display.contentCenterX-390, display.contentCenterY+5
	sRock[11] = display.newImageRect(objectGroup, "image/jump/smallRock.png", display.contentWidth/3.8, display.contentHeight/6.3)
	sRock[11].x, sRock[11].y = display.contentCenterX-440, display.contentCenterY-40
	sRock[12] = display.newImageRect(objectGroup, "image/jump/smallRock2.png", display.contentWidth/3.8, display.contentHeight/6.3)
	sRock[12].x, sRock[12].y = display.contentCenterX-250, display.contentCenterY-110

	local rock = {}
	rock[1] = display.newImageRect(objectGroup, "image/jump/rock2.png", display.contentWidth/4.5, display.contentHeight/8.5)
	rock[1].x, rock[1].y = display.contentCenterX-250, display.contentCenterY*1.75
	rock[2] = display.newImageRect(objectGroup, "image/jump/rock.png", display.contentWidth/4, display.contentHeight/9)
	rock[2].x, rock[2].y = display.contentCenterX*3.7, display.contentCenterY*1.4
	rock[3] = display.newImageRect(objectGroup, "image/jump/rock2.png", display.contentWidth/4, display.contentHeight/12)
	rock[3].x, rock[3].y = display.contentCenterX*2.5, display.contentCenterY*1.1
	rock[4] = display.newImageRect(objectGroup, "image/jump/rock2.png", display.contentWidth/5, display.contentHeight/12)
	rock[4].x, rock[4].y = display.contentCenterX-150, display.contentCenterY-130
	rock[5] = display.newImageRect(objectGroup, "image/jump/rock.png", display.contentWidth/2.5, display.contentHeight/10)
	rock[5].x, rock[5].y =  display.contentCenterX, display.contentCenterY-130
	rock[6] = display.newImageRect(objectGroup, "image/jump/rock.png", display.contentWidth/5, display.contentHeight/12)
	rock[6].x, rock[6].y = display.contentCenterX-340, display.contentCenterY-80

	
	objectGroup.alpha = 0

	local wall = {}
	local wallGroup = display.newGroup()
	wall[1] = display.newRect(wallGroup, background.x-480, background.y, display.contentWidth/30, background.height) --왼
	wall[2] = display.newRect(wallGroup, background.x*4, background.y, display.contentWidth/30, background.height) --오
	wall[3] = display.newRect(wallGroup, background.x, 0, background.width, display.contentWidth/40) --위
	wall[4] = display.newRect(wallGroup, background.x, background.y*2, background.width, display.contentWidth/30)--아래

	wallGroup.alpha = 0

	for i = 1, #bRock do 
		physics.addBody(bRock[i], "static", {outline=bRock_outline})
		bRock[i].name = "ground"
	end
	for i = 1, #rock do 
		physics.addBody(rock[i], "static", {outline=rock_outline})
		rock[i].name = "ground"
	end
	for i = 1, #sRock do 
		physics.addBody(sRock[i], "static", {outline=sRock_outline})
		sRock[i].name = "ground"
	end
	for i = 1, #wall do
		physics.addBody(wall[i], "static")
		wall[i].name = "wall"
	end
	for i = 1, #leaf1 do
		physics.addBody(leaf1[i], "static", {outline=leaf1_outline})
		leaf1[i].name = "ground"
	end
	for i = 1, #leaf2 do
		physics.addBody(leaf2[i], "static", {outline=leaf2_outline})
		leaf2[i].name = "ground"
	end
	for i = 1, #plant1 do 
		physics.addBody(plant1[i], "static", {outline=plant1_outline})
		plant1[i].name = "ground"
	end
		for i = 1, #plant2 do 
		physics.addBody(plant2[i], "static", {outline=plant2_outline})
		plant2[i].name = "ground"
	end
	

	local arrow = {}
	local arrowGroup = display.newGroup()
	arrow[1] = display.newImageRect(arrowGroup, "image/jump/arrow.png", display.contentWidth/6.3, display.contentHeight/10)
	arrow[1].x, arrow[1].y = display.contentCenterX*2.9, display.contentCenterY*1.8
	arrow[1].xScale = -1
	arrow[1].name = "left"
	arrow[2] = display.newImageRect(arrowGroup, "image/jump/jump.png", display.contentWidth/6.3, display.contentHeight/10)
	arrow[2].x, arrow[2].y = arrow[1].x+65, arrow[1].y
	arrow[2].name = "center"
	arrow[3] = display.newImageRect(arrowGroup, "image/jump/arrow.png", display.contentWidth/6.3, display.contentHeight/10)
	arrow[3].x, arrow[3].y = arrow[2].x+65, arrow[1].y
	arrow[3].name = "right"
	arrow[4] = "right"

	arrowGroup.alpha = 0

	local cat = display.newImageRect("image/jump/cat.png", display.contentWidth/6.5, display.contentHeight/10.5)
	local cat_outline_none = graphics.newOutline(1, "image/jump/cat.png")
	local cat_outline_flip = graphics.newOutline(1, "image/jump/cat_flip.png")
	cat.x, cat.y = plant1[1].x, plant1[1].y-50
	--cat.x, cat.y = plant1[1].x, plant1[1].y-80
	cat.name = "cat"

	physics.addBody(cat, {friction=1, outline = cat_outline_none})
	cat.isFixedRotation = true 
	cat.alpha = 0

	local jumpSound = audio.loadSound("soundEffect/jump.wav")
	audio.setVolume(0.1)

	local musicOption = { 
    	loops = -1
	}


	local home = audio.loadStream( "music/music5.mp3" )
    audio.setVolume( loadedEndings.logValue )--loadedEndings.logValue
    audio.play(home, musicOption)

    local volumeButton = display.newImageRect("image/설정/설정.png", display.contentWidth/5, display.contentHeight/8)
    volumeButton.x,volumeButton.y = display.contentCenterX*3.6, display.contentCenterY*0.25

	local isJumping = false
	function arrowTab(event)
		x = cat.x
		y = cat.y
		if (event.target.name == "center") then
			if(isJumping == false) then	
				isJumping = true
				if (arrow[4] == "left") then
					transition.to(cat, {time=100, x=(x-50), y=(y-50)})
				else
				    transition.to(cat, {time=100, x=(x+50), y=(y-50)})
				end
				audio.play(jumpSound)
		    end
		else
			if (event.target.name == arrow[4]) then --왼쪽 클
			    if (event.target.name == "left") then
			       transition.to(cat, {time=100, x=(x-20)})
			    else
			       transition.to(cat, {time=100, x=(x+20)})
			    end
			 else
			    arrow[4] = event.target.name
			    cat:scale(-1, 1)
			    physics.removeBody(cat)

			    if (event.target.name == "left") then
			       physics.addBody(cat, {friction=1, outline=cat_outline_flip})
			       transition.to(cat, {time=100, x=(x-20)})
			    else
			       physics.addBody(cat, {friction=1, outline=cat_outline_flip})
			       transition.to(cat, {time=100, x=(x+20)})
			    end
			    cat.isFixedRotation = true
			end
		end
	end

	local goal = display.newImageRect("image/jump/goal.png", 50, 50)
	local goal_outline = graphics.newOutline(1, "image/jump/goal.png")
	goal.alpha = 0

	local num = math.random(1,3)
	if(num == 1) then
		goal.x, goal.y = leaf2[1].x, leaf2[1].y-10
	elseif(num == 2) then
		goal.x, goal.y = leaf1[1].x-10, leaf1[1].y-15
	else
		goal.x, goal.y = rock[5].x+10, rock[5].y-15
	end
	goal.name="goal"
	physics.addBody(goal, "static", {outline=goal_outline})
	sceneGroup:insert(goal)

	function pagemove() 
		audio.pause(home)
		objectGroup.alpha = 0
		arrowGroup.alpha = 0
		cat.alpha = 0
		goal.alpha = 0
		volumeButton.alpha = 0
	end

	local flag = true
	function onCollision(event)
		if(event.other.name == "goal" and flag == true) then
			flag = false
			pagemove()
			composer.setVariable("score1", 1)
			composer.removeScene("view03_jump_game")
			composer.gotoScene("view03_jump_game_over")
		end
	end

	local flag = true
	function onCollision1(event)	
		if(isJumping == true and event.other.name == "ground") then
			--print("땅이야")
			if(flag == true) then
				flag = false
				timer.performWithDelay(700, function () isJumping = false flag = true end)
			end
		end
	end

	local flag1 = false
	function gameOver(self, event)
		if(event.phase == "ended" and flag1 == false) then
			flag1 = true
			print(event.name)
			timer.performWithDelay(10, function()
				pagemove()
				composer.setVariable("score1", -1)
				composer.removeScene("view03_jump_game")
				composer.gotoScene("view03_jump_game_over")
				end )
		end
	end

	-- 2023.07.04 edit by jiruen // 샘플 볼륨 bgm
    local volumeBgm = audio.loadStream("soundEffect/263126_설정 클릭시 나오는 효과음(2).wav")

    --샘플볼륨함수--
    local function setVolume(event)
    	audio.play(volumeBgm)
        composer.showOverlay( "StopGame", options )
    end
    volumeButton:addEventListener("tap",setVolume)

	local function playGame(event)
		objectGroup.alpha = 1
		background.alpha = 1
		arrowGroup.alpha = 1
		cat.alpha = 1
		section.alpha = 0
		script.alpha = 0
		goal.alpha = 1
		volumeButton.alpha = 1
	end

	--처음 실행
	section:addEventListener("tap", playGame)
	for i=1,3 do 
		arrow[i]:addEventListener("tap", arrowTab)
	end
	for i=1,4 do 
		wall[i].collision = gameOver
		wall[i]:addEventListener("collision")
	end
	cat:addEventListener("collision", onCollision)
	cat:addEventListener("collision", onCollision1)
	
	sceneGroup:insert(background)
	sceneGroup:insert(wallGroup)
	sceneGroup:insert(cat)
	sceneGroup:insert(volumeButton)
	sceneGroup:insert(arrowGroup)
	sceneGroup:insert(objectGroup)
	sceneGroup:insert(goal)
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
