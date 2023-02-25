-----------------------------------------------------------------------------------------
--
-- view02_lost_stuId_game.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local physics = require("physics")
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

	local gametitle = display.newImageRect("image/map/ㄱ 맵 배경.png", display.contentWidth, display.contentHeight)
	gametitle.x, gametitle.y = display.contentWidth/2, display.contentHeight/2

	local section = display.newRect(display.contentWidth/2, display.contentHeight*0.8, display.contentWidth, display.contentHeight*0.3)
	section:setFillColor(0.35, 0.35, 0.35, 0.35)
	section.alpha=0

	local script = display.newText("학교 지도야!\n건물을 클릭해보자!", section.x+30, section.y-100, native.systemFontBold)
	script.size = 30
	script:setFillColor(1)
	script.x, script.y = display.contentWidth/2, display.contentHeight*0.789
	script.alpha=0

	local background = display.newImageRect("image/map/ㄱ 맵 배경.png", display.contentWidth, display.contentHeight)
	background.x, background.y=display.contentWidth/2, display.contentHeight/2

	local buildingGroup = display.newGroup()
	local building = {}

	building[1] = display.newImageRect(buildingGroup, "image/map/ㄱ인문관.png", 512/2.3, 512/2.3)
 	building[1].x, building[1].y = display.contentWidth*0.42, display.contentHeight*0.22
 	building[1].name = "인문관"

 	building[2] = display.newImageRect(buildingGroup, "image/map/ㄱ음악관.png", 512/2.5, 512/2.5)
 	building[2].x, building[2].y = display.contentWidth*0.75, display.contentHeight*0.22
 	building[2].name = "음악관"

 	building[3] = display.newImageRect(buildingGroup, "image/map/ㄱ예지관.png", 512/2.5, 512/2.5)
 	building[3].x, building[3].y = display.contentWidth*0.84, display.contentHeight*0.44
 	building[3].name = "음악관"

 	building[4] = display.newImageRect(buildingGroup, "image/map/ㄱ대학원.png", 512/2.5, 512/2.5)
 	building[4].x, building[4].y = display.contentWidth*0.25, display.contentHeight*0.35
 	building[4].name = "대학원"

 	local function gotoChallenge(event)
 		if(buildingGroup[1].name == "인문관")then
 			print("인문관")
 			composer.removeScene("view04_map")
 			composer.gotoScene("view03_climbing_the_tree_game_final")
 			return true
 		end
 	end

 	local function gotoChallengePreCheck (event)
 		print("touch")
 		-- print(building[1].name)
 		-- print(event.name)


		local hintScript = display.newImageRect("image/map/메뉴바.png", 1024/1.5, 1024/1.5)
		hintScript.x, hintScript.y = display.contentWidth/2, display.contentHeight/2
		sceneGroup:insert(hintScript)

		local hintContentScript = display.newText("으로 이동하시겠습니까?", section.x+30, section.y-100, native.systemFontBold)
		hintContentScript.size = 30
		hintContentScript:setFillColor(0, 0, 0)
		hintContentScript.x, hintContentScript.y = display.contentWidth/2, display.contentHeight*0.4
		sceneGroup:insert(hintContentScript)

		local hintClose = display.newImageRect("image/map/확인,힌트 버튼.png", 768/4, 768/4)
		hintClose.x, hintClose.y = display.contentWidth/2, display.contentHeight*0.6
		sceneGroup:insert(hintClose)

		local hintCloseText = display.newText( "확 인", display.contentWidth/2, display.contentHeight*0.59, native.systemFont, 30 )
		hintCloseText:setFillColor( 1, 1, 1 )	-- black
		sceneGroup:insert(hintCloseText)

		hintClose:addEventListener("tap", gotoChallenge)

 	end

 


	local function scriptremove(event)
		
		section.alpha=0
		script.alpha=0

		building[1]:addEventListener("tap", gotoChallengePreCheck)
	end	

	local function titleremove(event)
		gametitle.alpha=0
		section.alpha=1
		script.alpha=1
		section:addEventListener("tap", scriptremove)
	end

	-- local function pagemove()
	-- 	display.remove(objectGroup)
	-- 	display.remove(floor)
	-- 	Runtime:removeEventListener("touch", bearmove)
	-- 	timer.cancel( timer1 )
	-- 	display.remove(cat)
	-- end	


	gametitle:addEventListener("tap", titleremove)


	sceneGroup:insert(background)
	-- sceneGroup:insert(buildingGroup)

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