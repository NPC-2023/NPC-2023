-----------------------------------------------------------------------------------------
--
-- View01_bear.lua
--
-----------------------------------------------------------------------------------------
local loadsave = require( "loadsave" )
local composer = require( "composer" )
local physics = require("physics")
local scene = composer.newScene()
local json = require( "json" ) 


function scene:create( event )
	local sceneGroup = self.view
	
	local loadedSettings = loadsave.loadTable( "settings.json" )
    local loadedEndings = loadsave.loadTable( "endings.json" )

	local gametitle = display.newImageRect("image/map/background.png", display.contentWidth, display.contentHeight)
	gametitle.x, gametitle.y = display.contentWidth/2, display.contentHeight/2
	sceneGroup:insert(gametitle)


	local section = display.newRect(display.contentWidth/2, display.contentHeight*0.8, display.contentWidth, display.contentHeight*0.3)
	section:setFillColor(0.35, 0.35, 0.35, 0.35)
	section.alpha=0
	sceneGroup:insert(section)


	local script = display.newText("학교 지도야!\n건물을 클릭해보자!", section.x+30, section.y-100, native.systemFontBold)
	script.size = 30
	script:setFillColor(1)
	script.x, script.y = display.contentWidth/2, display.contentHeight*0.789
	script.alpha=0
	sceneGroup:insert(script)


	local background = display.newImageRect("image/map/background.png", display.contentWidth, display.contentHeight)
	background.x, background.y=display.contentWidth/2, display.contentHeight/2
	sceneGroup:insert(background)



	local buildingGroup = display.newGroup()
	local building = {}

	building[1] = display.newImageRect(buildingGroup, "image/map/인문관.png", 512/2.3, 512/2.3)
 	building[1].x, building[1].y = display.contentWidth*0.42, display.contentHeight*0.22
 	building[1].name = "인문관"

 	building[2] = display.newImageRect(buildingGroup, "image/map/음악관.png", 512/2.5, 512/2.5)
 	building[2].x, building[2].y = display.contentWidth*0.75, display.contentHeight*0.22
 	building[2].name = "음악관"

 	building[3] = display.newImageRect(buildingGroup, "image/map/예지관.png", 512/2.5, 512/2.5)
 	building[3].x, building[3].y = display.contentWidth*0.84, display.contentHeight*0.44
 	building[3].name = "음악관"

 	building[4] = display.newImageRect(buildingGroup, "image/map/대학원.png", 512/2.5, 512/2.5)
 	building[4].x, building[4].y = display.contentWidth*0.25, display.contentHeight*0.35
 	building[4].name = "대학원"

 	building[5] = display.newImageRect(buildingGroup, "image/map/본관.png", 512/2.5, 512/2.5)
 	building[5].x, building[5].y = display.contentWidth*0.35, display.contentHeight*0.52
 	building[5].name = "본관"

 	building[6] = display.newImageRect(buildingGroup, "image/map/정문.png", 512/3, 512/3)
 	building[6].x, building[6].y = display.contentWidth*0.3, display.contentHeight*0.85
 	building[6].name = "정문"

 	building[7] = display.newImageRect(buildingGroup, "image/map/백주년.png", 512/3, 512/3)
 	building[7].x, building[7].y = display.contentWidth*0.09, display.contentHeight*0.87
 	building[7].name = "백주년"

 	-- building[8] = display.newImageRect(buildingGroup, "image/map/ㄱ학생관.png", 512/3, 512/3)
 	-- building[8].x, building[8].y = display.contentWidth*0.09, display.contentHeight*0.87
 	-- building[8].name = "학생관"

 	--sceneGroup:insert(building)




	
	


-- 마을 맵 마을 객체 생성.
	local click1 = audio.loadStream( "music/스침.wav" )
	
-- 마을 객체 커서 범위 설정. 범위 밖으로 나가면 마을 크기 작아지고 안으로 들어가면 마을 크기 커짐.
	local i = 0
	local function bigbig (event)
		
		if (event.target.x-event.x)^2 + (event.target.y-event.y)^2 < 110^2 then
			-- i값을 지정해 놓는 이유는 범위 안에서는 크기가 더 늘어나거나 줄어들지 않고, 소리가 연이어 나오지 않음.
			if i == 0 then
				local backgroundMusicChannel = audio.play(click1)
				event.target.width = event.target.width*1.1
				event.target.height = event.target.height*1.1
				i = i + 1
			end
		
		elseif (event.target.x-event.x)^2 + (event.target.y-event.y)^2 > 110^2 then
			if i == 1 then
				event.target.width =event.target.width/11*10
				event.target.height =event.target.height/11*10
				i = i - 1 
			end
			
		end
	end

	local color = 0

	
-- 리스너 함수 생성
	local function touch_ui (event)
		if event.phase == "began" then
			color = event.target.name

			if color == "1" then
				local click01 = audio.play(click1)
				local home = audio.loadStream( "music/Trust.mp3" )
				audio.setVolume( loadedEndings.logValue )
				audio.play(home)
				loadedEndings.bgMusic = "music/Trust.mp3"
        		loadsave.saveTable(loadedEndings,"endings.json")
				composer.removeScene("view05_main_map")
				composer.gotoScene( "view02_fall_game" )

			elseif color == "2" then
				local click01 = audio.play(click1)
				local storeMusic = audio.loadStream( "music/Trust.mp3" )
				audio.setVolume( loadedEndings.logValue )
				audio.play(storeMusic);
				loadedEndings.bgMusic = "music/Trust.mp3"
        		loadsave.saveTable(loadedEndings,"endings.json")
				composer.removeScene("view05_main_map")
				composer.gotoScene( "view03_mouse_game" )

			elseif color == "8" then
				local click01 = audio.play(click1)
				local storeMusic = audio.loadStream( "music/Trust.mp3" )
				audio.setVolume( loadedEndings.logValue )
				audio.play(storeMusic);
				loadedEndings.bgMusic = "music/Trust.mp3"
        		loadsave.saveTable(loadedEndings,"endings.json")
				composer.removeScene("view1Map")
				composer.gotoScene( "view04Deco" )

			else
				local click01 = audio.play(click1)
				composer.setVariable("color", color)
				composer.removeScene("view1Map")
				composer.gotoScene("view02Map")

			end
		end
	end

-- 리스너 추가
	for i=1, 7 do
		building[i]:addEventListener("mouse",bigbig)
		building[i]:addEventListener("touch",touch_ui)
	end








    
	--샘플 볼륨 이미지
    -----음악

    -- showoverlay 함수 사용 option
    local options = {
        isModal = true
    }

    --샘플 볼륨 이미지
    local volumeButton = display.newImageRect("image/설정/설정.png", 100, 100)
    volumeButton.x,volumeButton.y = display.contentWidth * 0.91, display.contentHeight * 0.4
    
    sceneGroup:insert(volumeButton)


    --샘플볼륨함수--
    local function setVolume(event)
        composer.showOverlay( "volumeControl", options )
    end
    volumeButton:addEventListener("tap",setVolume)

    --[[local home = audio.loadStream( "음악/음악샘플.mp3" )
    audio.setVolume( loadedEnding.logValue )--loadedEndings.logValue
    audio.play(home)
]]



 

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
		composer.removeScene("stage01")
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