-----------------------------------------------------------------------------------------
--
-- view1.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

	--이미지 설정

	local background = display.newImageRect("H_image/view03_background.jpg", display.contentWidth, display.contentHeight)
	background.x, background.y = display.contentWidth/2, display.contentHeight/2

	local cat = display.newImage("H_image/cat.png")
 	cat.x, cat.y = display.contentWidth*0.3, display.contentHeight*0.6+20

 	local student = display.newImage("H_image/student.png")
 	student.x, student.y = display.contentWidth*0.7, display.contentHeight*0.6

 	local paper = display.newImage("H_image/paper.png")
 	paper.x, paper.y = display.contentWidth*0.7, display.contentHeight*0.9

 	local scissors = display.newImage("H_image/scissors.png")
 	scissors.x, scissors.y = display.contentWidth*0.5, display.contentHeight*0.9

 	local rock = display.newImage("H_image/rock.png")
 	rock.x, rock.y = display.contentWidth*0.3, display.contentHeight*0.9

 	local AIpaper = display.newImage("H_image/paper.png")
 	AIpaper.x, AIpaper.y = display.contentWidth*0.75, display.contentHeight*0.55

 	local AIscissors = display.newImage("H_image/scissors.png")
 	AIscissors.x, AIscissors.y = display.contentWidth*0.75, display.contentHeight*0.55

 	local AIrock = display.newImage("H_image/rock.png")
 	AIrock.x, AIrock.y = display.contentWidth*0.75, display.contentHeight*0.55

 	cat:scale(0.15,0.15)
 	student:scale(0.7,0.7)
 	rock:scale(1.5,1.5)
 	scissors:scale(1.5,1.5)
 	paper:scale(1.5,1.5)

 	sceneGroup:insert(background)
 	sceneGroup:insert(cat)
 	sceneGroup:insert(student)
 	sceneGroup:insert(paper)
 	sceneGroup:insert(scissors)
 	sceneGroup:insert(rock)
 	sceneGroup:insert(AIpaper)
 	sceneGroup:insert(AIscissors)
 	sceneGroup:insert(AIscissors)

 	local winText = display.newText('바위 가위 보 중 하나를 선택해주세요', display.contentCenterX, display.contentCenterY-300)
 	winText.size = 50
 	winText:setFillColor(0)
 	winText.alpha = 0.8

 	sceneGroup:insert(winText)


 	local PlayerScore = 0
	local AIScore= 0
	local AIDO = 0

	local student_yStart = student.y
	local cat_yStart = cat.y

	--클릭
	AIrock.alpha = 0
 	AIscissors.alpha = 0
 	AIpaper.alpha = 0

 	local function sleep(sec)
	    local t = os.clock()
	    while os.clock() - t <= sec do
	    end
	end

	local function tap( event )
		--AI가위바위보
		math.randomseed(os.time())        
 		AIDO = math.random(3)
 		print("AIDO:"..AIDO)

 		AIrock.alpha = 0
 		AIscissors.alpha = 0
 		AIpaper.alpha = 0

 		local function who_win( )
	 		if student.y <= student_yStart - 100 then
	 			winText.text = '게임에 졌습니다.'
		 		print("게임에 졌습니다.")
		 		sleep(5)
		 		composer.gotoScene("ending")
		 	elseif cat.y <= cat_yStart - 100 then
		 		winText.text = '게임에 이겼습니다.'
		 		print("게임에 이겼습니다.")
		 		AIrock.alpha = 0
 				AIscissors.alpha = 0
 				AIpaper.alpha = 0
 				sleep(5)
		 		composer.gotoScene("ending")
		 	end
	 	end

 		--AI가 낸 거 보여주기
 		if AIDO == 1 then
 			AIrock.alpha = 1
 		 	AIscissors.alpha = 0
 			AIpaper.alpha = 0
 		elseif AIDO == 2 then
 			AIrock.alpha = 0
 		 	AIscissors.alpha = 1
 			AIpaper.alpha = 0
 		else
 			AIrock.alpha = 0
 		 	AIscissors.alpha = 0
 			AIpaper.alpha = 1
 		end

 		--가위바위보시작
	 	if (event.target == rock) then
	 		if AIDO == 1 then
	 			winText.text = '무승부입니다'
	 			print("무승부입니다.")
	 		elseif AIDO == 2 then
	 			cat.y = cat.y-10
	 			winText.text = '이겼습니다. 고양이가 1칸 올라갑니다.'
	 			print("이겼습니다. 고양이가 1칸 올라갑니다.")
	 		else
	 			student.y = student.y-50
	 			AIscissors.y = AIscissors.y-50
	 			AIpaper.y = AIpaper.y-50
	 			AIrock.y = AIrock.y-50
	 			winText.text = '졌습니다. 학생이 5칸 올라갑니다.'
	 			print("졌습니다. 학생이 5칸 올라갑니다.")
	 		end
	 		who_win()

	  	elseif (event.target == scissors) then
	  		if AIDO == 2 then
	  			winText.text = '무승부입니다'
	 			print("무승부입니다.")
	 		elseif AIDO == 3 then
	 			cat.y = cat.y-20
	 			winText.text = '이겼습니다. 고양이가 2칸 올라갑니다.'
	 			print("이겼습니다. 고양이가 2칸 올라갑니다.")
	 		else
	 			student.y = student.y-10
	 			AIscissors.y = AIscissors.y-10
	 			AIpaper.y = AIpaper.y-10
	 			AIrock.y = AIrock.y-10
	 			winText.text = '졌습니다. 학생이 1칸 올라갑니다.'
	 			print("졌습니다. 학생이 1칸 올라갑니다.")
	 		end
	 		who_win()

	 	elseif (event.target == paper) then
	 		if AIDO == 3 then
	 			winText.text = '무승부입니다'
	 			print("무승부입니다.")
	 		elseif AIDO == 1 then
	 			cat.y = cat.y-50
	 			winText.text = '이겼습니다. 고양이가 5칸 올라갑니다.'
	 			print("이겼습니다. 고양이가 5칸 올라갑니다.")
	 		else
	 			student.y = student.y-20
	 			AIscissors.y = AIscissors.y-20
	 			AIpaper.y = AIpaper.y-20
	 			AIrock.y = AIrock.y-20
	 			winText.text = '졌습니다. 학생이 2칸 올라갑니다.'
	 			print("졌습니다. 학생이 2칸 올라갑니다.")
	 		end
	 		who_win()
	 	end
	end
	rock:addEventListener("tap", tap)
 	scissors:addEventListener("tap", tap)
 	paper:addEventListener("tap", tap)
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