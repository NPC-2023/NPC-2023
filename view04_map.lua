-----------------------------------------------------------------------------------------
--
-- view04.lua
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

 	building[5] = display.newImageRect(buildingGroup, "image/map/ㄱ 본관.png", 512/2.5, 512/2.5)
 	building[5].x, building[5].y = display.contentWidth*0.35, display.contentHeight*0.52
 	building[5].name = "본관"

 	building[6] = display.newImageRect(buildingGroup, "image/map/ㄱ정문.png", 512/3, 512/3)
 	building[6].x, building[6].y = display.contentWidth*0.3, display.contentHeight*0.85
 	building[6].name = "정문"

 	building[7] = display.newImageRect(buildingGroup, "image/map/ㄱ백주년.png", 512/3, 512/3)
 	building[7].x, building[7].y = display.contentWidth*0.09, display.contentHeight*0.87
 	building[7].name = "백주년"

 	-- building[8] = display.newImageRect(buildingGroup, "image/map/ㄱ학생관.png", 512/3, 512/3)
 	-- building[8].x, building[8].y = display.contentWidth*0.09, display.contentHeight*0.87
 	-- building[8].name = "학생관"

 	local targetName

 	local function gotoChallenge(event)
 		print("targetName", targetName)
 		
 		if(targetName == "인문관")then
 			print("인문관")
 			composer.removeScene("view04_map")
 			composer.gotoScene("view03_climbing_the_tree_game_final")
 			return true
 		elseif(targetName == "음악관") then
 			composer.removeScene("view04_map")
 			composer.gotoScene("view01")
 			return true
 		elseif(targetName == "대학원")then
 			composer.removeScene("view04_map")
 			composer.gotoScene("view03_climbing_the_tree_game_final")
 			return true
 		elseif(targetName.name == "본관")then
 			composer.removeScene("view04_map")
 			composer.gotoScene("view03_climbing_the_tree_game_final")
 			return true
 		elseif(buildingGroup[i].name == "정문")then
 			composer.removeScene("view04_map")
 			composer.gotoScene("view03_climbing_the_tree_game_final")
 			return true
 		elseif(buildingGroup[i].name == "백주년")then
 			composer.removeScene("view04_map")
 			composer.gotoScene("view03_climbing_the_tree_game_final")
 			return true
 		end
 	end

 	local gotoScript
 	local gotoContentScript
 	local gotoButton
 	local gotoCancelButton
 	local gotoButtonText

 	local listenerActive = 0


 	
 	local function gotoCancel (event)
 		display.remove(gotoScript)
 		display.remove(gotoContentScript)
 		display.remove(gotoButton)
 		display.remove(gotoCancelButton)
 		display.remove(gotoButtonText)

 		-- if(listenerActive == 0 ) then
 		-- for i = 1, 7 do
 		-- 	building[i]:addEventListener("tap", gotoChallengePreCheck)
 		-- end

 	end

 	local function gotoChallengePreCheck (event)


 		print("touch")
 		print(event.target.name)

 		targetName = event.target.name
 		print("targetName", targetName)

		gotoScript = display.newImageRect("image/map/메뉴바.png", 1024/1.5, 1024/1.5)
		gotoScript.x, gotoScript.y = display.contentWidth/2, display.contentHeight/2
		sceneGroup:insert(gotoScript)

		gotoContentScript = display.newText(""..event.target.name .."으로 이동하시겠습니까?", section.x+30, section.y-100, native.systemFontBold)
		gotoContentScript.size = 30
		gotoContentScript:setFillColor(0, 0, 0)
		gotoContentScript.x, gotoContentScript.y = display.contentWidth/2, display.contentHeight*0.4
		sceneGroup:insert(gotoContentScript)

		gotoButton = display.newImageRect("image/map/확인,힌트 버튼.png", 768/4, 768/4)
		gotoButton.x, gotoButton.y = display.contentWidth/2, display.contentHeight*0.6
		sceneGroup:insert(gotoButton)

		gotoCancelButton = display.newImageRect("image/map/취소버튼.png", 768/6, 768/6)
		gotoCancelButton.x, gotoCancelButton.y = display.contentWidth*0.7, display.contentHeight*0.3
		sceneGroup:insert(gotoCancelButton)

		gotoButtonText = display.newText( "확 인", display.contentWidth/2, display.contentHeight*0.59, native.systemFont, 30 )
		gotoButtonText:setFillColor( 1, 1, 1 )	-- black
		sceneGroup:insert(gotoButtonText)

		-- display.getCurrentStage():setFocus( gotoCancelButton )

		gotoCancelButton:addEventListener("tap", gotoCancel)
		gotoButton:addEventListener("tap", gotoChallenge)

 	end


	local function scriptremove(event)
		
		section.alpha=0
		script.alpha=0

		for i = 1, 7 do 
			building[i]:addEventListener("tap", gotoChallengePreCheck)
		end

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
	sceneGroup:insert(buildingGroup)

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