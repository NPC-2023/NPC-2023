local composer = require( "composer" )
local physics = require("physics")
local scene = composer.newScene()
local loadsave = require( "loadsave" )
local json = require( "json" )

function scene:create( event )
	local sceneGroup = self.view

	----저장관련 기능------
	local loadedEndings = loadsave.loadTable( "endings.json" )
	local loadedSettings = loadsave.loadTable( "settings.json" )

	local b = {}
	local bGroup = display.newGroup()
	local loadedSettings = loadsave.loadTable( "settings.json" )
	mainName = loadedSettings.name
	--배경
	for i = 1, 3 do
		b[i] = display.newImage(bGroup, "image/hiddenQuest/" .. i .. ".png")
	end
	bGroup.x,bGroup.y = display.contentWidth/2,display.contentHeight/2
	sceneGroup:insert(bGroup)

	--composer.setVariable("find1", 0)	
	--composer.setVariable("find2", 0)	
	--composer.setVariable("find3", 0)	
	--composer.setVariable("find4", 0)	
	--composer.setVariable("find5", 0)	


	local section = display.newRect(display.contentWidth/2, display.contentHeight*0.8, display.contentWidth, display.contentHeight*0.3)
	section:setFillColor(0.8, 0.8, 0.8, 0.8)
	sceneGroup:insert(section)
	--local speakerImg = display.newRect(section.x, section.y - 700, 900, 900)


	local t = {}
	local tGroup = display.newGroup()
	local index = math.random(8)
	t[1] = display.newText(mainName.."! 일일 퀘스트를\n다 클리어했구나 정말 대단하다냥!", display.contentWidth * 0.5, display.contentHeight * 0.93 - 100, "font/NanumSquareRoundR.ttf", 30)
	t[2] = display.newText("열심히 한 "..mainName.."를 위해 보상으로\n히든 퀘스트를 준비했다냥", display.contentWidth * 0.5, display.contentHeight * 0.93 - 100, "font/NanumSquareRoundR.ttf", 30)
	t[3] = display.newText(loadedSettings.buildings_index[index].."에 가서 히든 퀘스트를 수행하면 선물도 준다냥!", display.contentWidth * 0.5, display.contentHeight * 0.93 - 100, "font/NanumSquareRoundR.ttf", 30)	
	loadedSettings.hiddenQuest[index] = true

	for i =1, 3 do
		tGroup:insert(t[i])
	end
	sceneGroup:insert(tGroup)
    for i = 2, 3 do
		b[i].alpha = 0
		t[i].alpha = 0
	end

	-- 화면전환
	local j = 2
	local function next1()
		if j > 1 and j < 4 then
			b[j - 1].alpha = 0
			t[j - 1].alpha = 0
			b[j].alpha = 1
			t[j].alpha = 1
		end

		j = j + 1

		if j == 5 then
			composer.removeScene("hiddenQuest")
			--audio.pause(tutorialMusic)
			composer.gotoScene("view06_main_map1")
			loadsave.saveTable(loadedSettings,"settings.json")
			
		end
	end
	
	section:addEventListener("tap", next1)
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