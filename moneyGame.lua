-----------------------------------------------------------------------------------------
--
-- cafeteria.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

	local background = display.newImageRect("image/store.jpg", display.contentWidth, display.contentHeight)
 	background.x, background.y = display.contentWidth/2, display.contentHeight/2

 	local object = {}

	object[1] = display.newImageRect("image/snack1.png", 100, 100)
 	object[2] = display.newImageRect("image/snack2.png", 100, 100)
 	object[3] = display.newImageRect("image/bread1.png", 100, 100)
 	object[4] = display.newImageRect("image/bread2.png", 100, 100)
 	object[5] = display.newImageRect("image/drink1.png", 100, 100)
 	object[6] = display.newImageRect("image/drink2.png", 100, 100)

	local objectGroup = display.newGroup()

	local money = {"1000", "1000", "2000", "2500", "1500", "1000"}

	for i = 1, 6 do
		object[i].x, object[i].y = display.contentWidth*0.1*(i+1), display.contentHeight*0.4
		object[i].money = money[i]
 		objectGroup:insert(object[i])
 	end

 	local money = {"1000", "1000", "2000", "2500", "1500", "1000"}
 	local script = {}

 	for i = 1, 6 do
 		script[i] = display.newText(money[i], object[i].x, object[i].y+90, "font/DOSGothic.ttf")
		script[i].size = 45
		script[i]:setFillColor(1)
		objectGroup:insert(script[i])
	end

	local totalScript = display.newText("0", display.contentWidth*0.1, display.contentHeight*0.1, "font/DOSGothic.ttf")
	totalScript.size = 50
	totalScript:setFillColor(1)

	local total = 0
	local function tapEventListener( event )
		total = total + tonumber(event.target.money)
		totalScript.text = total
		local soundEffect = audio.loadSound( "soundEffect/coin.wav" )
		audio.play( soundEffect )
	end

	local errand = composer.getVariable("money")

	local reset = display.newText("reset", display.contentWidth*0.2, display.contentHeight*0.1, "font/DOSGothic.ttf")
	reset.size = 50
	reset:setFillColor(1)

	local buy = display.newText("계산하기", display.contentWidth*0.5, display.contentHeight*0.65, "font/DOSGothic.ttf", 50)
	buy:setFillColor(1)

	local function resetTotalListener( event )
		totalScript.text = "0"
		total = 0
	end

	local text = ""
	local function buyListener( event )
		local soundEffect = audio.loadSound( "soundEffect/coin.8.ogg" )
		audio.play( soundEffect )

		if(total == errand) then
			text = display.newText("성공 !", display.contentWidth*0.5, display.contentHeight*0.85, "font/DOSGothic.ttf", 80)
			text:setFillColor(0)
			buy.alpha = 0
			objectGroup:insert(text)
			--다시 퀘스트 수락 화면으로 돌아옴
			timer.performWithDelay( 1000, function() 
				composer.setVariable("success", "success")
				composer.removeScene("moneyGame")
				composer.gotoScene("pre_moneyGame")
			end)
		else
			text = display.newText("실패다냥", display.contentWidth*0.5, display.contentHeight*0.85, "font/DOSGothic.ttf", 80)
			text:setFillColor(0)
		end
		
		timer.performWithDelay( 1500, function() 
			text.alpha = 0
		end )	
	end
	
	for i = 1, 6 do
		object[i]:addEventListener("tap", tapEventListener)
	end

	reset:addEventListener("tap", resetTotalListener)
	buy:addEventListener("tap", buyListener)

	objectGroup:insert(totalScript)
	objectGroup:insert(reset)
	objectGroup:insert(buy)

	sceneGroup:insert(background)
 	sceneGroup:insert(objectGroup)
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