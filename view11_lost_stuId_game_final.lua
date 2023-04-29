-----------------------------------------------------------------------------------------
--
-- view02_lost_stuId_game_final.lua -> 학생증 찾기 게임입니다!
--
-- ## 2023-02-27 PM4:00 변경 사항
-- (1) 16-21번째 -> 게임타이틀 그림과 게임타이틀명 추가
-- (2) 367번째줄 -> titleremove 함수를 밑으로 이동 및 hint:addEventListener("tap", hintShow)를 titleremove 함수로 이동
-- 
-- ## 게임 성공 시 이동
-- 245번째 줄 -> result: 1를 view02_lost_stuId_game_over.lua에 전달

-- ## 게임 실패 시 이동
-- 292번째 줄 -> result: 0를 view02_lost_stuId_game_over.lua에 전달
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local physics = require("physics")
local scene = composer.newScene()
local loadsave = require( "loadsave" )
local json = require( "json" )

function scene:create( event )
	local sceneGroup = self.view

	local bgMusic = audio.loadStream( "music/lost stu_id music.ogg" )
    audio.play(bgMusic)
    -- audio.setVolume( 0.4 )


	local gametitle = display.newImageRect("image/lost_stuId/미니게임 타이틀.png", 687/1.2, 604/1.2)
	gametitle.x, gametitle.y = display.contentWidth/2, display.contentHeight/2

	local gameName = display.newText("학생증 찾기", 0, 0, "font/font.ttf", 40)
	gameName:setFillColor(0)
	gameName.x, gameName.y=display.contentWidth/2, display.contentHeight*0.65

	local section = display.newRect(display.contentWidth/2, display.contentHeight*0.8, display.contentWidth, display.contentHeight*0.3)
	section:setFillColor(0.35, 0.35, 0.35, 0.35)
	section.alpha=0

	local script = display.newText("게임방법\n\n제한 시간 15초 이내에\n왼쪽의 힌트를 참고하여 학생증을 찾아 솜냥이에게 가져다주세요!", section.x+30, section.y-100, native.systemFontBold)
	script.size = 30
	script:setFillColor(1)
	script.x, script.y = display.contentWidth/2, display.contentHeight*0.789
	script.alpha=0

	local background = display.newImageRect("image/lost_stuId/background.png", display.contentWidth, display.contentHeight)
	background.x, background.y=display.contentWidth/2, display.contentHeight/2

	-- 힌트 버튼
	local hint = display.newImageRect("image/lost_stuId/확인,힌트 버튼.png", 768/3, 768/3)
	hint.x, hint.y = display.contentWidth*0.1, display.contentHeight*0.1

	-- 힌트 글자

	local hintTextScript = display.newText( "HINT",  display.contentWidth*0.1, display.contentHeight*0.09, native.systemFont, 30 )
	hintTextScript:setFillColor( 1, 1, 1 )


	local cat2 = display.newImageRect("image/lost_stuId/cat2.png", 1024/6, 1024/6)
	cat2.x, cat2.y = display.contentWidth/2, display.contentHeight*0.65

	-- 가짜 아이템 배치
 	local fakeItemGroup = display.newGroup()
 	local fakeItem = {}

 	fakeItem[1] = display.newImageRect(fakeItemGroup, "image/lost_stuId/can7.png", 768/10, 768/10)
 	fakeItem[1].x, fakeItem[1].y = display.contentWidth*0.678, display.contentHeight*0.3

 	fakeItem[2] = display.newImageRect(fakeItemGroup, "image/lost_stuId/can1.png", 768/10, 768/10)
 	fakeItem[2].x, fakeItem[2].y = display.contentWidth*0.15, display.contentHeight*0.28

 	fakeItem[3] = display.newImageRect(fakeItemGroup, "image/lost_stuId/can2.png", 768/10, 768/10)
 	fakeItem[3].x, fakeItem[3].y = display.contentWidth*0.65, display.contentHeight*0.53


	-- 고정된 사물 ex) 나무, 벤치, 우물
	local treeGroup = display.newGroup()
 	local tree = {}

 	-- 왼쪽에서 2번째
 	tree[1] = display.newImageRect(treeGroup, "image/lost_stuId/나무.png", 384/1.3, 384/1.3)
 	tree[1].x, tree[1].y = display.contentWidth*0.18, display.contentHeight*0.2

 	-- 왼쪽에서 3번째
 	tree[2] = display.newImageRect(treeGroup, "image/lost_stuId/나무.png", 384/1.5, 384/1.5)
 	tree[2].x, tree[2].y = display.contentWidth*0.6, display.contentHeight*0.15

 	-- 왼쪽에서 4번째
 	tree[3] = display.newImageRect(treeGroup, "image/lost_stuId/나무.png", 384/1.4, 384/1.4)
 	tree[3].x, tree[3].y = display.contentWidth*0.7, display.contentHeight*0.25

 	-- 왼쪽에서 1번째
 	tree[6] = display.newImageRect(treeGroup, "image/lost_stuId/나무.png", 384/1.2, 384/1.2)
 	tree[6].x, tree[6].y = display.contentWidth*0.1, display.contentHeight*0.5

 	tree[4] = display.newImageRect(treeGroup, "image/lost_stuId/나무.png", 384/1.7, 384/1.7)
 	tree[4].x, tree[4].y = display.contentWidth*0.88, display.contentHeight*0.2

 	tree[5] = display.newImageRect(treeGroup, "image/lost_stuId/나무.png", 384/1.8, 384/1.8)
 	tree[5].x, tree[5].y = display.contentWidth*0.9, display.contentHeight*0.3

 	----------------------------------------------
 	-- 벤치
 	local benchGroup = display.newGroup()
 	local bench = {}
 	bench[1] = display.newImageRect(benchGroup, "image/lost_stuId/벤치.png", 512/4, 512/4)
 	bench[1].x, bench[1].y = display.contentWidth*0.4, display.contentHeight*0.3

 	bench[2] = display.newImageRect(benchGroup, "image/lost_stuId/벤치.png", 512/3.5, 512/3.5)
 	bench[2].x, bench[2].y = display.contentWidth*0.58, display.contentHeight*0.5

 	----------------------------------------------
 	-- 우물
 	local wellGroup = display.newGroup()
 	local well = {}
 	well[1] = display.newImageRect(wellGroup, "image/lost_stuId/우물.png", 384/1.4, 384/1.4)
 	well[1].x, well[1].y = display.contentWidth*0.3, display.contentHeight*0.65

 	-- 풍덩 물 튀기
 	local waterGroup = display.newGroup()
 	local water = {}
 	water[1] = display.newImageRect(waterGroup, "image/lost_stuId/낚시 물튀기.png", 514/4, 514/4)
 	water[1].x, water[1].y = display.contentWidth*0.3, display.contentHeight*0.88

 	water[2] = display.newImageRect(waterGroup, "image/lost_stuId/낚시 물튀기.png", 514/5, 514/5)
 	water[2].x, water[2].y = display.contentWidth*0.85, display.contentHeight*0.8


 	-- 풀 덩굴
 	-- local grassGroup = display.newGroup()
 	-- local grass = {}

 	-- grass[1]= display.newImageRect(grassGroup, "image/lost_stuId/grass(2).png", 139, 56)
 	-- grass[1].x, grass[1].y = display.contentWidth*0.37, display.contentHeight*0.6

 	-- grass[2]= display.newImageRect(grassGroup, "image/lost_stuId/grass(1).png", 139, 56)
 	-- grass[2].x, grass[2].y = display.contentWidth*0.65, display.contentHeight*0.7



 	-- 드래그 가능한 사물 ex) 바위, 꽃, 물고기
 	-- 바위 배치
 	local rockGroup = display.newGroup()
 	local rock = {}

 	rock[1] = display.newImageRect(rockGroup, "image/lost_stuId/큰바위.png", 384/5.5, 384/5.5)
 	rock[1].x, rock[1].y = display.contentWidth*0.62, display.contentHeight*0.69

 	rock[2] = display.newImageRect(rockGroup, "image/lost_stuId/큰바위.png", 384/7, 384/7)
 	rock[2].x, rock[2].y = display.contentWidth*0.66, display.contentHeight*0.69

 	rock[3] = display.newImageRect(rockGroup, "image/lost_stuId/큰바위.png", 384/5, 384/5)
 	rock[3].x, rock[3].y = display.contentWidth*0.12, display.contentHeight*0.69

 	rock[4] = display.newImageRect(rockGroup, "image/lost_stuId/작은바위.png", 384/3, 384/3)
 	rock[4].x, rock[4].y = display.contentWidth*0.17, display.contentHeight*0.72

 	rock[5] = display.newImageRect(rockGroup, "image/lost_stuId/큰바위.png", 384/7, 384/7)
 	rock[5].x, rock[5].y = display.contentWidth*0.92, display.contentHeight*0.45
 	
 	-- 꽃 배치
 	local flowerGroup = display.newGroup()
 	local flower = {}
 	for i = 1, 2 do
 		flower[i] = display.newImageRect(flowerGroup, "image/lost_stuId/꽃.png", 384/4, 384/4)
 		flower[i].x, flower[i].y = display.contentWidth*0.15 + 60*i, display.contentHeight*0.38
 	end

 	for i = 3, 4 do
 		flower[i] = display.newImageRect(flowerGroup, "image/lost_stuId/꽃.png", 384/4, 384/4)
 		flower[i].x, flower[i].y = display.contentWidth*0.62 + 60*(i-3), display.contentHeight*0.55
 	end

 	for i = 5, 6 do
 		flower[i] = display.newImageRect(flowerGroup, "image/lost_stuId/꽃.png", 384/4, 384/4)
 		flower[i].x, flower[i].y = display.contentWidth*0.5 + 60*(i-6), display.contentHeight*0.3
 	end

 	-- 학생증 배치
 	local stuId = display.newImageRect("image/lost_stuId/학생증.png", 384/8, 384/8)
 	stuId.x, stuId.y = display.contentWidth*0.13, display.contentHeight*0.685

 	-- 물고기 
 	local fishGroup = display.newGroup()
 	local fish = {}
 	
 	fish[1] = display.newImageRect(fishGroup, "image/lost_stuId/can4.png", 384/5, 384/5)
 	fish[1].x, fish[1].y = display.contentWidth*0.3, display.contentHeight*0.8

 	fish[2] = display.newImageRect(fishGroup, "image/lost_stuId/can5.png", 384/6, 384/6)
 	fish[2].x, fish[2].y = display.contentWidth*0.84, display.contentHeight*0.75
 	

 	local result = 0
 	local click = audio.loadStream( "music/스침.wav" )

 	local function dragfakeItem( event )
 		if( event.phase == "began" ) then
 			local backgroundMusicChannel = audio.play(click)
 			display.getCurrentStage():setFocus( event.target )
 			event.target.isFocus = true
 			-- 드래그 시작할 때
 			event.target.initX = event.target.x
 			event.target.initY = event.target.y

 		elseif( event.phase == "moved" ) then

 			if ( event.target.isFocus ) then
 				-- 드래그 중일 때
 				event.target.x = event.xStart + event.xDelta
 				event.target.y = event.yStart + event.yDelta
 			end

 		elseif ( event.phase == "ended" or event.phase == "cancelled") then
 			if ( event.target.isFocus ) then
 				display.getCurrentStage():setFocus( nil )
 				event.target.isFocus = false

 				-- 드래그 끝났을 때
 				-- event.target.x = event.target.initX
 				-- event.target.y = event.target.initY
 			else
 				display.getCurrentStage():setFocus( nil )
 				event.target.isFocus = false
 			end
 		end
 	end

 	local function dragStuId( event )
 		if( event.phase == "began" ) then
 			local backgroundMusicChannel = audio.play(click)
 			display.getCurrentStage():setFocus( event.target )
 			event.target.isFocus = true
 			-- 드래그 시작할 때
 			event.target.initX = event.target.x
 			event.target.initY = event.target.y

 		elseif( event.phase == "moved" ) then

 			if ( event.target.isFocus ) then
 				-- 드래그 중일 때
 				event.target.x = event.xStart + event.xDelta
 				event.target.y = event.yStart + event.yDelta
 			end

 		elseif ( event.phase == "ended" or event.phase == "cancelled") then
 			if ( event.target.isFocus ) then
 				display.getCurrentStage():setFocus( nil )
 				event.target.isFocus = false

 				-- 드래그 끝났을 때
 				if ( event.target.x > cat2.x - 50 and event.target.x < cat2.x + 50
 					and event.target.y > cat2.y - 50 and event.target.y < cat2.y + 50) then

 					display.remove(event.target) -- 당근 삭제하기
 					result = 1
 					timer.cancelAll()
 					
 					composer.removeScene("view11_lost_stuId_game_final")
 					composer.setVariable("result", 1)
 					audio.stop()
 					composer.gotoScene("view12_lost_stuId_game_over")

 				else
 					event.target.x = event.target.initX
 					event.target.y = event.target.initY
 				end

 			else
 				display.getCurrentStage():setFocus( nil )
 				event.target.isFocus = false
 			end
 		end
 	end



 	local timebg = display.newImageRect("image/lost_stuId/알람, 타임.png", 384/2.2, 384/2.2 )
	timebg.x, timebg.y=display.contentWidth*0.9, display.contentHeight*0.12

 	local time= display.newText(15, display.contentWidth*0.905, display.contentHeight*0.15)
 	time.size = 65
 	time:setFillColor(1, 1, 1)




 	local function counter( event )
 		time.text = time.text - 1
 		-- print(time.text)
 		if( time.text == '5' ) then
 			time:setFillColor(1, 0, 0)
 		end

 		if( time.text == '-1') then
 			time.alpha = 0

 			if( result ~= 1 ) then
 				stuId:removeEventListener("touch", dragStuId)
 				
				-- audio.pause(explosionSound)
				composer.removeScene("view11_lost_stuId_game_final")
				composer.setVariable("result", 0)
				audio.stop()
				composer.gotoScene("view12_lost_stuId_game_over")

 			end
 		end
 	end

	local function scriptremove(event)
		
		section.alpha=0
		script.alpha=0
		-- Runtime:addEventListener( "touch", bearmove)
		timeAttack = timer.performWithDelay(1000, counter, 16)


		stuId:addEventListener("touch", dragStuId)
 		for i = 1, 3 do
 			fakeItem[i]:addEventListener("touch", dragfakeItem)
 		end

 		for i = 1, 5 do
 			rock[i]:addEventListener("touch", dragfakeItem)
 		end

 		for i = 1, 6 do
 			flower[i]:addEventListener("touch", dragfakeItem)
 		end


	end	

	local function pagemove()
		display.remove(objectGroup)
		display.remove(floor)
		Runtime:removeEventListener("touch", bearmove)
		timer.cancel( timer1 )
		display.remove(cat)
	end	

	-- 시간 멈춤 (0: 멈춤 1: 재생)
	local timeResume = 1

	local hintClose
	local hintScript
	local hintCloseText
	local hintContentScript

	local function hintHide(event)
		timer.resumeAll()
		display.remove(hintScript)
		display.remove(hintClose)
		display.remove(hintCloseText)
		display.remove(hintContentScript)
	end

	local function hintShow(event)
		hintScript = display.newImageRect("image/lost_stuId/메뉴바.png", 1024/1.5, 1024/1.5)
		hintScript.x, hintScript.y = display.contentWidth/2, display.contentHeight/2
		sceneGroup:insert(hintScript)

		hintContentScript = display.newText("힌트\n1. 물가 근처를 찾아봐!\n2. 바위 근처에 있을지도 몰라!\n3. 바위나 꽃을 드래그 해봐!", section.x+30, section.y-100, native.systemFontBold)
		hintContentScript.size = 35
		hintContentScript:setFillColor(0, 0, 0)
		hintContentScript.x, hintContentScript.y = display.contentWidth/2, display.contentHeight*0.4
		sceneGroup:insert(hintContentScript)

		hintClose = display.newImageRect("image/lost_stuId/확인,힌트 버튼.png", 768/4, 768/4)
		hintClose.x, hintClose.y = display.contentWidth/2, display.contentHeight*0.6
		sceneGroup:insert(hintClose)

		hintCloseText = display.newText( "확 인", display.contentWidth/2, display.contentHeight*0.59, native.systemFont, 30 )
		hintCloseText:setFillColor( 1, 1, 1 )	-- black
		sceneGroup:insert(hintCloseText)

		hintClose:addEventListener("tap", hintHide)

		timer.pauseAll()
	end


	local function titleremove(event)
		gametitle.alpha=0
		section.alpha=1
		script.alpha=1
		display.remove(gameName)
		section:addEventListener("tap", scriptremove)
		hint:addEventListener("tap", hintShow)
	end


	gametitle:addEventListener("tap", titleremove)
	

	sceneGroup:insert(background)
	sceneGroup:insert(cat2)
	
	sceneGroup:insert(fakeItemGroup)
	sceneGroup:insert(wellGroup)
	sceneGroup:insert(waterGroup)
	sceneGroup:insert(fishGroup)
	sceneGroup:insert(treeGroup)
	sceneGroup:insert(stuId)
	sceneGroup:insert(benchGroup)
	sceneGroup:insert(flowerGroup)
	sceneGroup:insert(rockGroup)
	-- sceneGroup:insert(grassGroup)
	sceneGroup:insert(timebg)
	sceneGroup:insert(time)
	sceneGroup:insert(hint)
	sceneGroup:insert(hintTextScript)
	sceneGroup:insert(gametitle)
	sceneGroup:insert(gameName)


	sceneGroup:insert(section)
	sceneGroup:insert(script)


    -- showoverlay 함수 사용 option
    local options = {
        isModal = true
    }

    --샘플 볼륨 이미지
    local volumeButton = display.newImageRect("image/설정/설정.png", 100, 100)
    volumeButton.x,volumeButton.y = display.contentWidth * 0.91, display.contentHeight * 0.3
    
    sceneGroup:insert(volumeButton)


    --샘플볼륨함수--
    local function setVolume(event)
        composer.showOverlay( "volumeControl", options )
    end
    volumeButton:addEventListener("tap",setVolume)
	
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