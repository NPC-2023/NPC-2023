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
	loadedEndings = loadsave.loadTable( "endings.json" )

	physics.start()
	--physics.setDrawMode( "hybrid" )

	local background = display.newImageRect("image/background_water.png", display.contentWidth, display.contentHeight)
	background.x, background.y = display.contentWidth/2, display.contentHeight/2
	background.alpha = 0.5
	
	local section = display.newRect(display.contentWidth/2, display.contentHeight*0.8, display.contentWidth, display.contentHeight*0.3)
	section:setFillColor(0.35, 0.35, 0.35, 0.35)
	section.alpha=0
	
	local score1 = 0

	local script = display.newText("게임방법\n방향키와 점프키를 이용해 고양이이에게 츄르를 주세요!\n\n고양이가 왼쪽, 오른쪽, 아래 벽면에 닿으면 GAMEOVER!", section.x+30, section.y-100, native.systemFontBold)
	script.size = 30
	script:setFillColor(1)
	script.x, script.y = display.contentWidth/2, display.contentHeight*0.789
	script.alpha=0

	local bRock_outline = graphics.newOutline(1, "image/bigRock.png")
	local leaf_outline = graphics.newOutline(1, "image/leaf.png")
	local sRock_outline = graphics.newOutline(1, "image/smallRock.png")
	local plant1_outline = graphics.newOutline(1, "image/plant1.png")
	local plant2_outline = graphics.newOutline(1, "image/plant2.png")
	local rock_outline = graphics.newOutline(1, "image/rock.png")

	local objectGroup = display.newGroup()
	local leaf = {}
	leaf[1] = display.newImageRect(objectGroup, "image/leaf.png", 250, 150)
	leaf[1].x, leaf[1].y = 1150, 480
	leaf[2] = display.newImageRect(objectGroup, "image/leaf.png", 300, 180)
	leaf[2].x, leaf[2].y = 630, 120

	local plant1 = {}
	plant1[1] = display.newImageRect(objectGroup, "image/plant1.png", 150, 100)
	plant1[1].x, plant1[1].y = 640, 610
	plant1[2] = display.newImageRect(objectGroup, "image/plant1.png", 200, 80)
	plant1[2].x, plant1[2].y = 150, 300

	local plant2 = {}
	plant2[1] = display.newImageRect(objectGroup, "image/plant2.png", 130, 90)
	plant2[1].x, plant2[1].y = 240, 550
	
	local bRock = {}
	bRock[1] = display.newImageRect(objectGroup, "image/bigRock.png", 130, 96)
	bRock[1].x, bRock[1].y = 800, 640
	bRock[2] = display.newImageRect(objectGroup, "image/bigRock.png", bRock[1].width+100, bRock[1].height+50)
	bRock[2].xScale = -1
	bRock[2].x, bRock[2].y = 710, 330

	local rock = {}
	rock[1] = display.newImageRect(objectGroup, "image/rock.png", 130, 96)
	rock[1].x, rock[1].y = 110, 610
	rock[2] = display.newImageRect(objectGroup, "image/rock.png", rock[1].width, rock[1].height)
	rock[2].x, rock[2].y = 330, 640
	rock[3] = display.newImageRect(objectGroup, "image/rock.png", 80, 60)
	rock[3].x, rock[3].y = 900, 580
	rock[4] = display.newImageRect(objectGroup, "image/rock.png", 260, 90)
	rock[4].x, rock[4].y = 1150, 200 --1번 goal
	rock[5] = display.newImageRect(objectGroup, "image/rock.png", 80, 60)
	rock[5].x, rock[5].y = 900, 340 
	rock[6] = display.newImageRect(objectGroup, "image/rock.png", 80, 60)
	rock[6].x, rock[6].y = 300, 210
	rock[7] = display.newImageRect(objectGroup, "image/rock.png", 80, 60)
	rock[7].x, rock[7].y = 1000, 400

	local sRock = {}
	sRock[1] = display.newImageRect(objectGroup, "image/smallRock.png", 130, 96)
	sRock[1].x, sRock[1].y = 460, 580
	sRock[2] = display.newImageRect(objectGroup, "image/smallRock.png", 130, 96)
	sRock[2].x, sRock[2].y =  980, 540
	sRock[3] = display.newImageRect(objectGroup, "image/smallRock.png", 130, 96)
	sRock[3].x, sRock[3].y = 390, 300
	sRock[4] = display.newImageRect(objectGroup, "image/smallRock.png", 130, 96)
	sRock[4].x, sRock[4].y = 430, 170
	sRock[5] = display.newImageRect(objectGroup, "image/smallRock.png", 130, 96)
	sRock[5].x, sRock[5].y = 500, 350

	sRock[6] = display.newImageRect(objectGroup, "image/smallRock.png", 130, 96)
	sRock[6].x, sRock[6].y = 970, 250

	local wall = {}
	local wallGroup = display.newGroup()
	wall[1] = display.newRect(wallGroup, 0, background.y, 30, background.height) --왼
	wall[2] = display.newRect(wallGroup, background.width, background.y, 30, background.height) --오
	wall[3] = display.newRect(wallGroup, background.x, 0, background.width, 30) --위
	wall[4] = display.newRect(wallGroup, background.x, background.height, background.width, 30)--아래

	for i = 1, #bRock do 
		physics.addBody(bRock[i], "static", {outline=bRock_outline})
	end
	for i = 1, #rock do 
		physics.addBody(rock[i], "static", {outline=rock_outline})
	end
	for i = 1, #sRock do 
		physics.addBody(sRock[i], "static", {outline=sRock_outline})

	end
	for i = 1, #wall do
		physics.addBody(wall[i], "static")
		wall[i].name = "wall"
		wall[i].alpha = 0
	end
	for i = 1, #leaf do
		physics.addBody(leaf[i], "static", {outline=leaf_outline})
	end

	for i = 1, #plant1 do 
		physics.addBody(plant1[i], "static", {outline=plant1_outline})
	end
		for i = 1, #plant2 do 
		physics.addBody(plant2[i], "static", {outline=plant2_outline})
	end
	
	local arrow = {}
	local arrowGroup = display.newGroup()
	arrow[1] = display.newImageRect(arrowGroup, "image/arrow.png", 70, 70)
	arrow[1].x, arrow[1].y = 1010, 630
	arrow[1].xScale = -1
	arrow[1].name = "left"

	arrow[2] = display.newImageRect(arrowGroup, "image/jump.png", 80, 80)
	arrow[2].x, arrow[2].y = arrow[1].x+86, 630
	arrow[2].name = "center"

	arrow[3] = display.newImageRect(arrowGroup, "image/arrow.png", 70, 70)
	arrow[3].x, arrow[3].y = arrow[2].x+86, 630
	arrow[3].name = "right"

	arrow[4] = "left"

	local cat = display.newImageRect("image/cat.png", 65, 50)
	local cat_outline_none = graphics.newOutline(1, "image/cat.png")
	local cat_outline_flip = graphics.newOutline(1, "image/cat_flip.png")

	cat.x, cat.y = 110, 550
	cat.name = "cat"

	physics.addBody(cat, {friction=1, outline = cat_outline_none})
	cat.isFixedRotation = true 

	function arrowTab(event)
		x = cat.x
		y = cat.y
		if (event.target.name == "center") then
			if (arrow[4] == "left") then
				transition.to(cat, {time=100, x=(x-80), y=(y-100)})
			else
			    transition.to(cat, {time=100, x=(x+80), y=(y-100)})
			end
		else
			if (event.target.name == arrow[4]) then --왼쪽 클
			    if (event.target.name == "left") then
			       transition.to(cat, {time=100, x=(x-30)})
			    else
			       transition.to(cat, {time=100, x=(x+30)})
			    end
			 else
			    arrow[4] = event.target.name
			    cat:scale(-1, 1)
			    physics.removeBody(cat)

			    if (event.target.name == "left") then
			       physics.addBody(cat, {friction=1, outline=cat_outline_flip})
			       transition.to(cat, {time=100, x=(x-10)})
			    else
			       physics.addBody(cat, {friction=1, outline=cat_outline_flip})
			       transition.to(cat, {time=100, x=(x+10)})
			    end
			    cat.isFixedRotation = true
				end
		end
	end

	for i = 1, 3 do
		arrow[i]:addEventListener("tap", arrowTab)
	end

	local goal = display.newImageRect("image/goal.png", 80, 80)
	local goal_outline = graphics.newOutline(1, "image/goal.png")
	goal.alpha = 0

	local num = math.random(1,3)
	if(num == 1) then
		goal.x, goal.y = 1200, 170
	elseif(num == 2) then
		goal.x, goal.y = 120, 270
	else
		goal.x, goal.y = 650, 90
	end
	goal.name="goal"
	physics.addBody(goal, "static", {outline=goal_outline})
	sceneGroup:insert(goal)

	local function pagemove()
		display.remove(objectGroup)
		display.remove(arrowGroup)
		display.remove(cat)
		display.remove(goal)
		display.remove(showScore)
	end
	function onCollision(event)
		if(event.other.name == "goal") then
			pagemove()
			composer.setVariable("score1", 1)
			composer.removeScene("view03_jump_game")
			composer.gotoScene("view03_jump_game_over")
		end
	end

	local flag = false
	function gameOver(self, event)
		if(event.phase == "ended" and flag == false) then
			flag = true

			timer.performWithDelay(10, function()
				pagemove()
				composer.removeScene("view03_jump_game")
				composer.setVariable("score1", -1)
				composer.gotoScene("view03_jump_game_over")
					flag = false
				end )
		end
	end
	local jumpSound = audio.loadSound("music/bounce.mp3")
	function soundEffect(event)	
    	audio.play(jumpSound)
    	audio.setVolume(0.2)
	end
	local function scriptremove(event)
		objectGroup.alpha = 1
		background.alpha = 1
		arrowGroup.alpha = 1
		cat.alpha = 1
		section.alpha = 0
		goal.alpha = 1
		script.alpha = 0
	end

	--처음 실행
	local function titleremove(event)
		section.alpha = 1
		script.alpha = 1
		section:addEventListener("tap", scriptremove)
	end
	titleremove()
	arrow[2]:addEventListener("tap", soundEffect)
	wall[1].collision = gameOver
	wall[1]:addEventListener("collision")
	wall[2].collision = gameOver
	wall[2]:addEventListener("collision")
	wall[4].collision = gameOver
	wall[4]:addEventListener("collision")
	cat:addEventListener("collision", onCollision)
	
	sceneGroup:insert(background)
	sceneGroup:insert(wallGroup)
	sceneGroup:insert(cat)
	sceneGroup:insert(arrowGroup)
	sceneGroup:insert(objectGroup)
	sceneGroup:insert(goal)
	sceneGroup:insert(section)
	sceneGroup:insert(script)
	objectGroup.alpha = 0
	arrowGroup.alpha = 0
	cat.alpha = 0
	goal.alpha = 0



	-----음악

    -- showoverlay 함수 사용 option
    local options = {
        isModal = true
    }

    --샘플 볼륨 이미지
    local volumeButton = display.newImageRect("image/설정/설정.png", 100, 100)
    volumeButton.x,volumeButton.y = display.contentWidth * 0.95, display.contentHeight * 0.12
    sceneGroup:insert(volumeButton)


    --샘플볼륨함수--
    local function setVolume(event)
        composer.showOverlay( "volumeControl", options )
    end
    volumeButton:addEventListener("tap",setVolume)

    local home = audio.loadStream( "music/music3.mp3" )
    audio.setVolume( loadedEndings.logValue )--loadedEndings.logValue
    audio.play(home)


    -------------
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
