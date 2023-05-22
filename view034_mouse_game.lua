-- 두더지게임
local composer = require( "composer" )
local physics = require("physics")
local scene = composer.newScene()
local loadsave = require( "loadsave" )
local json = require( "json" )


function scene:create( event )
	local sceneGroup = self.view
	
	loadedEndings = loadsave.loadTable( "endings.json" )

	
	local background = display.newImageRect("image/mouse/background.png",display.contentWidth, display.contentHeight)
	background.x,background.y = display.contentWidth/2,display.contentHeight/2
	sceneGroup:insert(background)

	-- 변수 설정
	local dudu = {}
	local dudu1 = {}
	local dudu2 = {}
	local dudu_hit ={}
	local dudu_hit1 = {}
	local dudu_hit2 = {}
	local holl = {}
	local holl1 = {}
	local holl2 = {}

	local score_num = 0
	local score1 = 0
	local score_num = 0


	--위치 설정
	local position_dudu_x ={
		display.contentWidth/5.27,
		display.contentWidth/2.2594,
		display.contentWidth/1.4406
	}
	local position_dudu_y ={
		display.contentHeight/2.78565901-80,
		display.contentHeight/1.62738834-80,
		display.contentHeight/1.12738834-80
	}
	local position_dudu_hit_x ={
		display.contentWidth/5.27,
		display.contentWidth/2.2594,
		display.contentWidth/1.4406
	}
	local position_dudu_hit_y ={
		display.contentHeight/9.8675194-80,
		display.contentHeight/2.78565901-80,
		display.contentHeight/1.62738834-80
	}
	local holl_x ={
		display.contentWidth/6.44771308,
		display.contentWidth/2.45907938,
		display.contentWidth/1.51925177
	}
	local holl_y={
		display.contentHeight/2.9476787-80,
		display.contentHeight/1.68122169-80,
		display.contentHeight/1.17597099-80
	}

	-- 두더지, 맞은 두더지, 구멍 객체
	for i=1,3 do
		dudu[i] = display.newImageRect("image/mouse/맞기전.png", 130, 130)
		dudu[i].x,dudu[i].y = position_dudu_x[i],position_dudu_y[1]
		dudu[i].anchorX, dudu[i].anchorY = 0,0
		sceneGroup:insert(dudu[i])

		dudu_hit[i] = display.newImageRect("image/mouse/맞은후.png", 130, 130)
		dudu_hit[i].x, dudu_hit[i].y = position_dudu_hit_x[i],position_dudu_hit_y[1]
		dudu_hit[i].anchorX,dudu_hit[i].anchorY = 0,0
		dudu_hit[i].alpha = 0
		sceneGroup:insert(dudu_hit[i])

		holl[i] = display.newImageRect("image/mouse/두더지게임 구덩이.png", 200, 200)
		holl[i].x, holl[i].y = holl_x[i],holl_y[1]
		holl[i].anchorX, holl[i].anchorY = 0,0
		sceneGroup:insert(holl[i])
	end

	for i=1,3 do
		dudu1[i] = display.newImageRect("image/mouse/맞기전.png", 130, 130)
		dudu1[i].x,dudu1[i].y = position_dudu_x[i],position_dudu_y[2]
		dudu1[i].anchorX, dudu1[i].anchorY = 0,0
		sceneGroup:insert(dudu1[i])

		dudu_hit1[i] = display.newImageRect("image/mouse/맞은후.png", 130, 130)
		dudu_hit1[i].x, dudu_hit1[i].y = position_dudu_hit_x[i],position_dudu_hit_y[2]
		dudu_hit1[i].anchorX,dudu_hit1[i].anchorY = 0,0
		dudu_hit1[i].alpha = 0
		sceneGroup:insert(dudu_hit1[i])

		holl1[i] = display.newImageRect("image/mouse/두더지게임 구덩이.png", 200, 200)
		holl1[i].x, holl1[i].y = holl_x[i],holl_y[2]
		holl1[i].anchorX, holl1[i].anchorY = 0,0
		sceneGroup:insert(holl1[i])
	end

	for i=1,3 do
		dudu2[i] = display.newImageRect("image/mouse/맞기전.png", 130, 130)
		dudu2[i].x,dudu2[i].y = position_dudu_x[i],position_dudu_y[3]
		dudu2[i].anchorX, dudu2[i].anchorY = 0,0
		sceneGroup:insert(dudu2[i])

		dudu_hit2[i] = display.newImageRect("image/mouse/맞은후.png", 130, 130)
		dudu_hit2[i].x, dudu_hit2[i].y = position_dudu_hit_x[i],position_dudu_hit_y[3]
		dudu_hit2[i].anchorX,dudu_hit2[i].anchorY = 0,0
		dudu_hit2[i].alpha = 0
		sceneGroup:insert(dudu_hit2[i])

		holl2[i] = display.newImageRect("image/mouse/두더지게임 구덩이.png", 200, 200)
		holl2[i].x, holl2[i].y = holl_x[i],holl_y[3]
		holl2[i].anchorX, holl2[i].anchorY = 0,0
		sceneGroup:insert(holl2[i])
	end

	-- 흰색 가리기
	--[[local holl_bg = display.newImage("이미지/미니게임/미니게임_빨강마을/bg.png")
	holl_bg.x, holl_bg.y = display.contentWidth/2,display.contentHeight-30
	sceneGroup:insert(holl_bg)]]

	-- 해머 객체
	local h1 = display.newImageRect("image/mouse/고양이 발.png",150, 150)
	h1.anchorX,h1.anchorY=0.3,0.3
	h1.x,h1.y = 640,360
	sceneGroup:insert(h1)


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

    local home = audio.loadStream( "music/Trust.mp3" )
    audio.setVolume( loadedEndings.logValue )--loadedEndings.logValue
    audio.play(home)


    -------------


	-- 클릭 시 해머가 기울어짐
	function move(event)
		if (event.phase == "began") then
			transition.to(h1,{rotation=-45,time=200})
		end

		if (event.phase == "ended") then
			transition.to(h1,{rotation=0,time=200})
		end
	end


	function move1(event)
		h1.x,h1.y = event.x,event.y
	end

	Runtime:addEventListener("mouse",move1)
	h1:addEventListener("touch",move)

	--시간과 점수
	local time = display.newImageRect("image/mouse/미니게임_시간타이머.png", 180, 180)
	time.anchorX, time.anchorY =0,0
	time.x,time.y = display.contentWidth*0.83, display.contentHeight*0.02
	sceneGroup:insert(time)

	local score = display.newImageRect("image/mouse/score.png", 150, 150)
	score.anchorX, score.anchorY =0,0
	score.x,score.y = display.contentWidth/34, display.contentHeight/13.2482826
	sceneGroup:insert(score)

	local showScore = display.newText(score1,display.contentWidth/11,display.contentHeight/5.555,"font/잘풀리는오늘 Medium.ttf") 
	showScore:setFillColor(1,0,0) 
	showScore.size = 60
	sceneGroup:insert(showScore)



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

    local home = audio.loadStream( "music/music5.mp3" )
    audio.setVolume( loadedEndings.logValue )--loadedEndings.logValue
    audio.play(home)


    -------------

	-- 1번째 ~ 3번째 (1,2,3 위치 랜덤으로 등장/같은 함수 쓰면 중첩돼서 함수 따로 써야됨)

	function move_dudu()
		-- 두더지 들어가는 모션
		local i
		function popout(event)
			transition.to(dudu[i],{time=300,y=display.contentHeight/2.78565901-80,tag="down",onComplete=function() interval() end})
		end

		-- 두더지 때렸을 때
		function hit_dudu(event)
			if event.phase == "ended" then
				score_num = score_num + 1
				--[[if score_num == 6 then
					score1 = 10
					showScore.text = score1
				elseif score_num == 15 then
					score1 = 15
					showScore.text = score1
				end]]
				score1 = score_num
				showScore.text = score1
				transition.cancel("pop")
				dudu[i]:removeEventListener("touch",hit_dudu)
				dudu_hit[i].x, dudu_hit[i].y = position_dudu_hit_x[i],position_dudu_hit_y[1]
				dudu_hit[i].alpha=1
				dudu[i].alpha=0
				transition.to(dudu_hit[i],{time=300,y=display.contentHeight/2.78565901-80,onComplete=function() dudu[i].alpha=1 dudu_hit[i].alpha=0 interval() end})
				transition.to(dudu[i],{time=300,y=display.contentHeight/2.78565901-80})
			end
		end

		-- 두더지 나왔음
		function pop(event)
			transition.to(dudu[i],{delay=700,tag="pop",onComplete=function() popout() dudu[i]:removeEventListener("touch",hit_dudu) end})
		end

		-- 두더지 나오는 모션
		function popup(event)
			transition.to(dudu[i],{time=300,y=display.contentHeight/9.8675194-80,onComplete=function() pop() dudu[i]:addEventListener("touch",hit_dudu) end})
		end

		-- 두더지 대기
		function interval()
			local time1 = math.random(10,100)
			local trans = math.random(1,3)
			i = trans
			transition.to(dudu[i],{delay=time1,onComplete=function() popup() end})
		end
		interval()
	end

	move_dudu()

	-- 4번째 ~ 6번째줄

	function move_dudu1()
		-- 두더지 들어가는 모션
		local i 
		function popout1(event)
			transition.to(dudu1[i],{time=300,y=display.contentHeight/1.62738834-80,tag="down1",onComplete=function() interval1() end})
		end

		-- 두더지 때렸을 때
		function hit_dudu1(event)
			if event.phase == "ended" then
				score_num = score_num + 1
				--[[if score_num == 6 then
					score1 = 10
					showScore.text = score1
				elseif score_num == 15 then
					score1 = 15
					showScore.text = score1
				end]]
				score1 = score_num
				showScore.text = score1

				transition.cancel("pop1")
				dudu1[i]:removeEventListener("touch",hit_dudu1)

				dudu_hit1[i].x, dudu_hit1[i].y = position_dudu_hit_x[i],position_dudu_hit_y[2]
				dudu_hit1[i].alpha=1
				dudu1[i].alpha=0
				transition.to(dudu_hit1[i],{time=300,y=display.contentHeight/1.62738834-80,onComplete=function() dudu1[i].alpha=1 dudu_hit1[i].alpha=0 interval1() end})
				transition.to(dudu1[i],{time=300,y=display.contentHeight/1.62738834-80})
			end
		end

		-- 두더지 나왔음
		function pop1(event)
			transition.to(dudu1[i],{tag="pop1",delay=700,onComplete=function() popout1() dudu1[i]:removeEventListener("touch",hit_dudu1) end})
		end

		-- 두더지 나오는 모션
		function popup1(event)
			transition.to(dudu1[i],{time=300,y=display.contentHeight/2.78565901-80,onComplete=function() pop1() dudu1[i]:addEventListener("touch",hit_dudu1) end})
		end

		-- 두더지 대기
		function interval1()
			local time1 = math.random(10,100)
			local trans = math.random(1,3)
			i = trans
			transition.to(dudu1[i],{delay=time1,onComplete=function() popup1() end})
		end
		interval1()
	end

	move_dudu1()
	

	--7번째줄 ~ 9번째줄

	function move_dudu2()
		-- 두더지 들어가는 모션
		local i 
		function popout2(event)
			transition.to(dudu2[i],{time=300,y=display.contentHeight/1.12738834-80,tag="down2",onComplete=function() interval2() end})
		end

		-- 두더지 때렸을 때
		function hit_dudu2(event)
			if event.phase == "ended" then
				score_num = score_num + 1
				--[[if score_num == 6 then
					score1 = 10
					showScore.text = score1
				elseif score_num == 15 then
					score1 = 15
					showScore.text = score1
				end]]
				score1 = score_num
				showScore.text = score1
				transition.cancel("pop2")
				dudu2[i]:removeEventListener("touch",hit_dudu2)

				dudu_hit2[i].x, dudu_hit2[i].y = position_dudu_hit_x[i],position_dudu_hit_y[3]
				dudu_hit2[i].alpha=1
				dudu2[i].alpha=0
				transition.to(dudu_hit2[i],{time=300,y=display.contentHeight/1.12738834-80,onComplete=function() dudu2[i].alpha=1 dudu_hit2[i].alpha=0 interval2() end})
				transition.to(dudu2[i],{time=300,y=display.contentHeight/1.12738834-80})
			end
		end

		-- 두더지 나왔음
		function pop2(event)
			transition.to(dudu2[i],{tag="pop2",delay=700,onComplete=function() popout2() dudu2[i]:removeEventListener("touch",hit_dudu2) end})
		end

		-- 두더지 나오는 모션
		function popup2(event)
			transition.to(dudu2[i],{time=300,y=display.contentHeight/1.62738834-80,onComplete=function() pop2() dudu2[i]:addEventListener("touch",hit_dudu2) end})
		end

		-- 두더지 대기
		function interval2()
			local time1 = math.random(10,100)
			local trans = math.random(1,3)
			i = trans
			transition.to(dudu2[i],{delay=time1,onComplete=function() popup2() end})
		end
		interval2()
	end

	move_dudu2()

	-- 제한 시간
	local limit = 15
	local showLimit = display.newText(limit,display.contentWidth/1.1,display.contentHeight/5.8,"font/잘풀리는오늘 Medium.ttf")
	showLimit:setFillColor(1,0,0)
	showLimit.size =60
	sceneGroup:insert(showLimit)

	local function timeAttack( event )
		limit = limit - 1
		showLimit.text = limit

		if limit == 0 then
			transition.cancelAll()
			composer.setVariable("score2", score1)
			Runtime:removeEventListener("mouse",move1)
			h1:removeEventListener("touch",move)

			for i=1,3 do
				dudu[i]:removeSelf()
				dudu1[i]:removeSelf()
				dudu2[i]:removeSelf()

				dudu_hit[i]:removeSelf()
				dudu_hit1[i]:removeSelf()
				dudu_hit2[i]:removeSelf()

				dudu[i] = nil 
				dudu1[i] = nil
				dudu2[i] = nil

				dudu_hit[i] = nil
				dudu_hit1[i] = nil
				dudu_hit2[i] =nil
			end

			composer.removeScene("view034_mouse_game")
			composer.gotoScene("view034_mouse_game_over")
		end
	end
	 
	timer.performWithDelay( 1000, timeAttack, 0 ,"attack")

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