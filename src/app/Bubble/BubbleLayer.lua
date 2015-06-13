
  --[[
    游戏的主要规则控制层
    单独出来，然后加入到GameScene
  ]]

local Bubble=require("app.Bubble.Bubble")

local BubbleLayer=class("BubbleLayer", function ( )
	-- body
	return display.newLayer()
end)


function BubbleLayer:ctor( ... )
	-- body
	printInfo("BubbleLayer ctor")

  
  -- self:setEvent()
  --***************************
  --define value
  self.isTouchable=true
  self.bubbleList={}  --bubbleList , All balls are in this List
  self.ballCount=90
  self.selectedBubbles={}

  --*********************************
  --function
  self:setPhysicsLayer()

  self:initBall()


end

--[[设置场景的物理边界]]
function BubbleLayer:setPhysicsLayer(  )
    

    local ground = display.newNode()
    local bodyBottom = cc.PhysicsBody:createEdgeSegment(cc.p(0, 5), cc.p(480, 5))
    ground:setPhysicsBody(bodyBottom)
    self:addChild(ground)

    local left = display.newNode()
    local bodyLeft = cc.PhysicsBody:createEdgeSegment(cc.p(1, 5), cc.p(1, 800))
    left:setPhysicsBody(bodyLeft)
    self:addChild(left)

    local rightSide = display.newNode()
    local bodyRight = cc.PhysicsBody:createEdgeSegment(cc.p(479, 5), cc.p(479, 800))
    rightSide:setPhysicsBody(bodyRight)
    self:addChild(rightSide)
  
   -- self.bgSprite = display.newSprite("main_bg.png",display.cx,display.cy)
    --                 :addTo(self)

end


--[[初始化泡泡]]
function BubbleLayer:initBall( )

	
	-- body
    for i=1,self.ballCount do
    	--print(i)
       local myBubble=Bubble.new()
       myBubble:retain()
       myBubble.BubbleLayer=self
       myBubble:pos(math.random()*480, math.random()*700)
       myBubble:setValue(math.random(1,5))
       self:addChild(myBubble, 3)
       
       self.bubbleList[i]=myBubble

    end	
end

-- function BubbleLayer:setEvent( )
	
-- 	 self:setTouchEnabled(true)
--      self:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
         
--          if event.name == "began" then
--              printInfo("begin")

--          	local buble = self:getBubbleByPos(event.x, event.y)
--          	if bubble then
--          		self.curBubble=bubble
--          		table.insert(self.selectedBubble,buble)
--          		buble:setSelect(true)
--          	end

--          elseif event.name =="moved" then

--          elseif event.name =="ended" then
         	            
--          end
--      end)  
-- end

function BubbleLayer:getBubbleByPos( x,y )
	-- body
	print("get bubble")
	for i=1,self.ballCount do
		 
		 local bubble=self.bubbleList[i]
		 if bubble then
              local rect=bubble:getBoundingBox()
              if cc.rectContainsPoint(rect,cc.p(x,y)) then
                 return buble
              end
		 end

	end

	return nil
end
--[[ 获取 和处理 相连接的泡泡]]
function BubbleLayer:dealLinkBubble(selBubble)
  -- body
  print("selected type" ,selBubble.typeID)
  
  local selType=selBubble.typeID

  --把同类型 && 相连的 泡泡加入到 列表中
  self.selectedBubbles={}
  table.insert(self.selectedBubbles, selBubble)

  --debug():

  local keyIndex=1
  while self.selectedBubbles[keyIndex] ~=nil do
    --todo
    local cmpBub=self.selectedBubbles[keyIndex]

    for i=1,self.ballCount do
    
      repeat
        local curBub=self.bubbleList[i]



        -- judge typeID
        if curBub.typeID ~= selType then
          break
        end

        --judge  in selected
        local isInSelect=table.keyof(self.selectedBubbles,curBub)
        if nil ~= isInSelect then
          break
        end

        --judge link
        local isLink=self:checkLinkOfTwoBubble(cmpBub,curBub)
        if false == isLink then
            break
        end

        table.insert(self.selectedBubbles,curBub)

      until false
    end


    keyIndex=keyIndex+1
  end

  print("select count" ,#self.selectedBubbles)
 
  self:explodeSelectBuble()
  self:productNewBubble()


end



--[[让选中的泡泡爆炸]]
function BubbleLayer:explodeSelectBuble()
  -- body
  local selectCount= (#self.selectedBubbles)

  for i=1,selectCount do
     
     local curBub=self.selectedBubbles[i]
     local posX,posY = curBub:getPosition()

     local explodePati=cc.ParticleSystemQuad:create("bubbleExplode.plist")
     explodePati:pos(posX, posY)
     explodePati:setAutoRemoveOnFinish(true)
     self:addChild(explodePati)

     curBub:pos(200, 80000)
  end
end

--[[产生新的泡泡]]
function BubbleLayer:productNewBubble( )
  -- body
  local selectCount= (#self.selectedBubbles)

  for i=1,selectCount do
     
       local myBubble=self.selectedBubbles[i]
       
       --print("xxxx", myBubble)

       myBubble.BubbleLayer=self
       myBubble:pos(math.random()*480, (math.random()*100+800) )
       myBubble:setValue(math.random(1,5))
       --self:addChild(myBubble, 3)
     
  end

end

--[[检测两个泡泡是否接触]]
function BubbleLayer:checkLinkOfTwoBubble( bubA,bubB )
  -- body
  local widthA=bubA:getContentSize().width/2
  local widthB=bubB:getContentSize().width/2
  local dif=10
  local norDistance=widthA+widthB+dif


  local posAX,posAY=bubA:getPosition()
  local posBX,posBY=bubB:getPosition()


  local curDistance= (posAX - posBX)^2 + (posAY-posBY)^2

  if curDistance <norDistance^2 then
    return true
  else 
    return false
  end
end

return BubbleLayer