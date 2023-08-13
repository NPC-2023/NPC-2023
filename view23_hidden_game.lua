-----------------------------------------------------------------------------------------
--
-- view1.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local loadsave = require( "loadsave" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

	local loadedSettings = loadsave.loadTable( "settings.json" )
	local volumeButton = display.newImageRect("image/설정/설정.png", display.contentWidth/5, display.contentHeight/8)
    volumeButton.x,volumeButton.y = display.contentWidth * 1.8, display.contentHeight * 0.12

    local function pagemove()
		display.remove(sceneGroup)
		-- display.remove(floor)
		-- Runtime:removeEventListener("touch", bearmove)
		-- timer.cancel( timer1 )
		-- display.remove(cat)
	end

	--게임 인트로&게임 방법----------------------------------------------------------------------------------------------------------------------------------------
	function startscene()

		composer.setVariable("gameName", "view23_hidden_game")

		local gametitle = display.newImageRect("image/hidden/title.png", 687/1.4, 604/1.4)
		gametitle.x, gametitle.y = display.contentWidth/2, display.contentHeight/2

		local title = display.newText("바위가위보로 \n계단 올라가기", 0, 0, "ttf/Galmuri7.ttf", 45)
		title.x, title.y=display.contentWidth/2, display.contentHeight*0.65
		title:setFillColor(0)

		local titlebackground = display.newImageRect("image/hidden/view03_background.jpg", display.contentWidth*3, display.contentHeight)
		titlebackground.x = display.contentCenterX
    	titlebackground.y = display.contentCenterY

		local section = display.newRect(display.contentWidth/2, display.contentHeight*0.85, display.contentWidth*3, display.contentHeight*0.9)
		section:setFillColor(0.35, 0.35, 0.35, 0.35)
		section.alpha=0

		local script = display.newText("게임방법\n\n학생과 바위가위보게임을 하며 계단을 올라가보세요! \n 14칸을 먼저 올라가는 사람이 이깁니다.\n\n 점수\n 바위 : 1칸   가위 : 2칸   보 : 5칸", section.x+30, section.y-100, native.systemFontBold)
		script.size = 30
		script:setFillColor(1)
		script.x, script.y = display.contentWidth/2, display.contentHeight*0.7
		script.alpha=0

		local home = audio.loadStream( "music/music8.ogg" )
    	audio.setVolume( loadedEndings.logValue )--loadedEndings.logValue

    	local musicOption = { 
    		loops = -1
		}
	
		audio.play(home, musicOption)
   	
   		local options = {
    	    isModal = true
   		 }

   		-- 2023.07.04 edit by jiruen // 샘플 볼륨 bgm
    	local volumeBgm = audio.loadStream("soundEffect/263126_설정 클릭시 나오는 효과음(2).wav")

   		 --샘플볼륨함수--
    	local function setVolume(event)
    		--audio.pause(bgm_play)
    		audio.play(volumeBgm)
      		composer.showOverlay( "StopGame", options )
   	 	end
   		 volumeButton:addEventListener("tap", setVolume)
		
		sceneGroup:insert(gametitle)
		sceneGroup:insert(title)
		sceneGroup:insert(titlebackground)
		sceneGroup:insert(section)
		sceneGroup:insert(script)
		
		local function scriptremove(event)
			timer1=timer.performWithDelay(500, spawn, 0)
			section.alpha=0
			script.alpha=0
			gamescene()
		end

		local function titleremove(event)
			gametitle.alpha=0
			title.alpha=0
			section.alpha=1
			script.alpha=1
			section:addEventListener("tap", scriptremove)
		end
		gametitle:addEventListener("tap", titleremove)
		gametitle:toFront()
		title:toFront()
	end

	--게임 시작------------------------------------------------------------------------------------------------------------------------------------
	function gamescene()
		--이미지 설정
		local background = display.newImageRect("image/hidden/view03_background.jpg", display.contentWidth*3, display.contentHeight)
		background.x, background.y = display.contentCenterX,  display.contentCenterY

		local cat = display.newImage("image/hidden/cat.png")
	 	cat.x, cat.y = display.contentWidth*-0.1, display.contentHeight*0.6+20

	 	local student = display.newImage("image/hidden/student.png")
	 	student.x, student.y = display.contentWidth*1.1, display.contentHeight*0.6

	 	local paper = display.newImage("image/hidden/paper.png")
	 	paper.x, paper.y = display.contentWidth*1.1, display.contentHeight*0.9

	 	local scissors = display.newImage("image/hidden/scissors.png")
	 	scissors.x, scissors.y = display.contentWidth*0.5, display.contentHeight*0.9

	 	local rock = display.newImage("image/hidden/rock.png")
	 	rock.x, rock.y = display.contentWidth*-0.1, display.contentHeight*0.9

	 	local Student_paper = display.newImage("image/hidden/Student_paper.png")
	 	Student_paper.x, Student_paper.y = display.contentWidth*1.1, display.contentHeight*0.45

	 	local Student_scissors = display.newImage("image/hidden/Student_scissors.png")
	 	Student_scissors.x, Student_scissors.y = display.contentWidth*1.1, display.contentHeight*0.45

	 	local Student_rock = display.newImage("image/hidden/Student_rock.png")
	 	Student_rock.x, Student_rock.y = display.contentWidth*1.1, display.contentHeight*0.45

	 	cat:scale(0.15,0.15)
	 	student:scale(0.7,0.7)
	 	rock:scale(0.25,0.25)
	 	scissors:scale(0.25,0.25)
	 	paper:scale(0.25,0.25)
	 	Student_rock:scale(0.3,0.3)
	 	Student_scissors:scale(0.3,0.3)
	 	Student_paper:scale(0.3,0.3)

	 	sceneGroup:insert(background)
	 	sceneGroup:insert(cat)
	 	sceneGroup:insert(student)
	 	sceneGroup:insert(paper)
	 	sceneGroup:insert(scissors)
	 	sceneGroup:insert(rock)
	 	sceneGroup:insert(Student_paper)
	 	sceneGroup:insert(Student_scissors)
	 	sceneGroup:insert(Student_rock)
	 	sceneGroup:insert(volumeButton)

	 	local winText = display.newText('바위 가위 보 중 하나를 선택해주세요', display.contentCenterX, display.contentCenterY-300)
	 	winText.size = 50
	 	winText:setFillColor(0)
	 	winText.alpha = 0.8

	 	sceneGroup:insert(winText)
	 	--winText:toFront()

	 	local PlayerScore = 0
		local Student_Score= 0
		local Student_DO = 0

		local student_yStart = student.y
		local cat_yStart = cat.y

		--클릭
		Student_rock.alpha = 0
	 	Student_scissors.alpha = 0
	 	Student_paper.alpha = 0

		local function tap( event )
			--Student_가위바위보
			math.randomseed(os.time())        
	 		-- Student_DO = math.random(3)
	 		--Student_가 내는 패가 오늘의 날짜를 반영하도록 하여 게임 난이도를 하향조정
	 		local today = os.date("*t")  -- Get today's date and time
			local remainder = today.day % 3  -- Calculate remainder of today's date divided by 3

			local Student_DO
			local randN = math.random(6)
			if remainder == 0 then
				if randN <= 3 then
			  		Student_DO = 3
			  	elseif randN <= 5 then
			  		Student_DO = 1
			  	else
			  		Student_DO = 2
			  	end
			elseif remainder == 1 then
				if randN <= 3 then
			  		Student_DO = 1
			  	elseif randN <= 5 then
			  		Student_DO = 2
			  	else
			  		Student_DO = 3
			  	end
			else
				if randN <= 3 then
			  		Student_DO = 2
			  	elseif randN <= 5 then
			  		Student_DO = 3
			  	else
			  		Student_DO = 1
			  	end
			end
			
	 		print("Student_DO:"..Student_DO)

	 		Student_rock.alpha = 0
	 		Student_scissors.alpha = 0
	 		Student_paper.alpha = 0

	 		--게임 성공 판별 기준 student_yStart - 140을 넘어가면 ending으로 이동------------------------------------------------------------------------
	 		local function who_win()
		 		if student.y <= student_yStart - 140 then
		 			winText.text = '게임에 졌습니다.'
			 		print("게임에 졌습니다.")
			 		pagemove()
			 		composer.setVariable("hidden_game_status", "fail")
					audio.pause(explosionSound)

					-- 2023.07.03 edit by jiruen // 게임 over 파일에 넘겨줄 변수 추가
					composer.setVariable("score", -1)

					composer.removeScene("view23_hidden_game")
					composer.gotoScene("view23_hidden_game_over")
			 	elseif cat.y <= cat_yStart - 140 then
			 		winText.text = '게임에 이겼습니다.'
			 		print("게임에 이겼습니다.")
			 		Student_rock.alpha = 0
	 				Student_scissors.alpha = 0
	 				Student_paper.alpha = 0
	 				pagemove()
	 				composer.setVariable("hidden_game_status", "success")
	 				
	 				-- 2023.07.03 edit by jiruen // 게임 over 파일에 넘겨줄 변수 추가
	 				composer.setVariable("score", 1)

	 				audio.pause(explosionSound)
					composer.removeScene("view23_hidden_game")
					composer.gotoScene("view23_hidden_game_over")		 		
			 	end
		 	end

	 		--Student_가 낸 거 보여주기
	 		if Student_DO == 1 then
	 			Student_rock.alpha = 1
	 		 	Student_scissors.alpha = 0
	 			Student_paper.alpha = 0
	 		elseif Student_DO == 2 then
	 			Student_rock.alpha = 0
	 		 	Student_scissors.alpha = 1
	 			Student_paper.alpha = 0
	 		else
	 			Student_rock.alpha = 0
	 		 	Student_scissors.alpha = 0
	 			Student_paper.alpha = 1
	 		end

	 		--가위바위보시작
		 	if (event.target == rock) then
		 		if Student_DO == 1 then
		 			winText.text = '무승부입니다'
		 			print("무승부입니다.")
		 		elseif Student_DO == 2 then
		 			cat.y = cat.y-10
		 			winText.text = '이겼습니다. 고양이가 1칸 올라갑니다.'
		 			print("이겼습니다. 고양이가 1칸 올라갑니다.")
		 		else
		 			student.y = student.y-50
		 			Student_scissors.y = Student_scissors.y-50
		 			Student_paper.y = Student_paper.y-50
		 			Student_rock.y = Student_rock.y-50
		 			winText.text = '졌습니다. 학생이 5칸 올라갑니다.'
		 			print("졌습니다. 학생이 5칸 올라갑니다.")
		 		end

		  	elseif (event.target == scissors) then
		  		if Student_DO == 2 then
		  			winText.text = '무승부입니다'
		 			print("무승부입니다.")
		 		elseif Student_DO == 3 then
		 			cat.y = cat.y-20
		 			winText.text = '이겼습니다. 고양이가 2칸 올라갑니다.'
		 			print("이겼습니다. 고양이가 2칸 올라갑니다.")
		 		else
		 			student.y = student.y-10
		 			Student_scissors.y = Student_scissors.y-10
		 			Student_paper.y = Student_paper.y-10
		 			Student_rock.y = Student_rock.y-10
		 			winText.text = '졌습니다. 학생이 1칸 올라갑니다.'
		 			print("졌습니다. 학생이 1칸 올라갑니다.")
		 		end

		 	elseif (event.target == paper) then
		 		if Student_O == 3 then
		 			winText.text = '무승부입니다'
		 			print("무승부입니다.")
		 		elseif Student_DO == 1 then
		 			cat.y = cat.y-50
		 			winText.text = '이겼습니다. 고양이가 5칸 올라갑니다.'
		 			print("이겼습니다. 고양이가 5칸 올라갑니다.")
		 		else
		 			student.y = student.y-20
		 			Student_scissors.y = Student_scissors.y-20
		 			Student_paper.y = Student_paper.y-20
		 			Student_rock.y = Student_rock.y-20
		 			winText.text = '졌습니다. 학생이 2칸 올라갑니다.'
		 			print("졌습니다. 학생이 2칸 올라갑니다.")
		 		end
		 	end
		 	who_win()
		end
		rock:addEventListener("tap", tap)
	 	scissors:addEventListener("tap", tap)
	 	paper:addEventListener("tap", tap)
	end

	--게임 엔딩---------------------------------------------------------------------------------------------------------------------------------------------------
	--view23_hidden_game_over로 대체
	-- function endingscene()
	-- 	audio.pause(home)
	-- 	local endingBackground = display.newRect(display.contentWidth/2, display.contentHeight/2, display.contentWidth, display.contentHeight)
	-- 	endingBackground:setFillColor(0)

	-- 	local endingText = display.newText("엔딩", display.contentWidth/2, display.contentHeight*0.4)
	--  	endingText.size = 200
	--  	endingText:setFillColor(1)

	--  	local replay = display.newText("다시 하기", display.contentWidth/2, display.contentHeight*0.7)
	-- 	replay.size = 100
	-- 	replay:setFillColor(1)

	-- 	sceneGroup:insert(endingBackground)
	-- 	sceneGroup:insert(endingText)
	-- 	sceneGroup:insert(replay)

	--  	local function touchEventListener( event )
	--  		if (event.phase == "began") then 
	--  			if event.target == replay then
	--  				endingBackground.alpha=0
	-- 				endingText.alpha=0
	-- 				replay.alpha=0
	--  				gamescene()
	--  			end
	--  		end
	--  	end
	--  	local function toFront(event) 
	--  		if (event.phase == "began") then 
	--  			loadedSettings.money = loadedSettings.money + 3
	-- 			composer.setVariable("hiddengame_status", "success")
	-- 			composer.removeScene("view23_hidden_game")
	-- 			composer.gotoScene("view23_npc_hidden_game")
	-- 			loadedSettings.total_success = 0
	-- 		end
	-- 	end

	--  	replay:addEventListener("touch", touchEventListener)
	--  	endingText:addEventListener("touch", toFront)
	--  	--replay:toFront()
	-- end

	loadsave.saveTable(loadedSettings,"settings.json")

	startscene()
end

-----------------------------------------------------------------------------------------------------------------------------------------------------------------
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