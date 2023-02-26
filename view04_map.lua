-----------------------------------------------------------------------------------------
--
-- view04.lua 맵 화면
--
-----------------------------------------------------------------------------------------

-- local loadsave = require( "loadsave" )
local composer = require( "composer" )
local physics = require("physics")
local scene = composer.newScene()
local json = require( "json" ) 


function scene:create( event )
	local sceneGroup = self.view
	
	local background = display.newImageRect("image/map/ㄱ 맵 배경.png", display.contentWidth, display.contentHeight)
	background.x, background.y=display.contentWidth/2, display.contentHeight/2


	-- 건물 배치 코드
	local buildingFileNames = { "ㄱ인문관", "ㄱ음악관", "ㄱ예지관", "ㄱ대학원", "ㄱ 본관", "ㄱ정문", "ㄱ백주년", "ㄱ학생관"}
	local buildingNames = { "인문관", "음악관", "예지관", "대학원", "본관", "정문", "백주년", "학생관"}
	local building_x = {0.42, 0.75, 0.84, 0.25, 0.35, 0.3, 0.09, 0.53}
	local building_y = {0.22, 0.22, 0.44, 0.35, 0.52, 0.85, 0.87, 0.54}
	local building_size = {2.3, 2.5, 2.5, 2.5, 2.3, 3, 3, 2.5 }

	local buildingGroup = display.newGroup()
	local building = {}

	for i = 1, 8 do 
		local size = building_size[i]
		building[i] = display.newImageRect(buildingGroup, "image/map/".. buildingFileNames[i] ..".png", 512/size, 512/size)
 		building[i].x, building[i].y = display.contentWidth*building_x[i], display.contentHeight*building_y[i]
 		building[i].name = buildingNames[i]
	end


	sceneGroup:insert(background)
	sceneGroup:insert(buildingGroup)
	
	local target
	-- showoverlay 함수 사용 option
    -- local options = {
    --     isModal = true
    -- }


    
	--샘플 볼륨 이미지
    -----음악

    -- showoverlay 함수 사용 option
    -- local options = {
    --     isModal = true
    -- }

    --샘플 볼륨 이미지
    -- local volumeButton = display.newImageRect("image/설정/설정.png", 100, 100)
    -- volumeButton.x,volumeButton.y = display.contentWidth * 0.91, display.contentHeight * 0.4
    -- sceneGroup:insert(volumeButton)


    --샘플볼륨함수--
    -- local function setVolume(event)
    --     composer.showOverlay( "volumeControl", options )
    -- end
    -- volumeButton:addEventListener("tap",setVolume)

    --[[local home = audio.loadStream( "음악/음악샘플.mp3" )
    audio.setVolume( loadedEnding.logValue )--loadedEndings.logValue
    audio.play(home)
]]	
	
	local target

	local function gotoCheckMsg( event )
		print("클릭함")
		target = event.target.name
		print(target)
		local options = {
        	isModal = true,
        	params = {
        	targetName = target
    		}
    	}
    	print(options.params.targetName)
		composer.showOverlay("showGotoCheckMsg", options)
	end
	for i = 1, 8 do 
		building[i]:addEventListener("tap", gotoCheckMsg)
	end



 

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