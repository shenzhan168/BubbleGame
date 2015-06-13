--一个泡泡
local Bubble=class("Bubble",function()
     return display.newSprite()
 end
)

--物理材质
local MATERIAL_DEFAULT = cc.PhysicsMaterial(5.0, 0.4, 0.0)

function Bubble:ctor()

  --*********

	-- body
	self.BubbleLayer={};
  self:setEvent()
  self:init()

end

--设置选择状态
function Bubble:setSelect(isSelect)
  -- body
     --printInfo("select")

    if isSelect then
       printInfo("selected")
       self.isSelect=true
       local sequence = transition.sequence({
           cc.ScaleTo:create(0.4, 1.2, 1.2, 1),
           cc.ScaleTo:create(0.4, 1.0, 1.0, 1),
        })

       --local ro=cc.RotateBy:create(1.5, 360)
       local rep=cc.RepeatForever:create(sequence)
        self.ballInSprite:runAction(rep)

       --self:removeSelf()

    else
      self.isSelect=false;
       self.ballInSprite:stopAllActions()        
    end

end

function Bubble:init()
    --set ball
   local ballFrame=display.newSpriteFrame("selectionsss.png")
   self:setSpriteFrame(ballFrame)

   local ballWidth =self:getContentSize().width/2

   self.ballInSprite=display.newSprite(ballFrame,ballWidth,ballWidth)
                      :addTo(self)

   --set physics
    local ballBody=cc.PhysicsBody:createCircle(ballWidth,MATERIAL_DEFAULT,cc.p(0,0))
    self:setPhysicsBody(ballBody)
   
end

--[[设置泡泡的类型
    根据ID
]]
function Bubble:setValue(id)

    self.typeID=id

   --set candy in ball
   local  bubbleName = string.format("row%d.png", id) 
   --print(bubbleName)

   local frameNo = display.newSpriteFrame(bubbleName)
   if frameNo then
         self.ballInSprite:setSpriteFrame(frameNo)
   else
   		--todo
   		print("No Frame")
   end

end

--[[泡泡的点击事件]]
function Bubble:setEvent( )
  
  self:setTouchEnabled(true)
  self:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
         
         if event.name == "began" then
 

             print("begin buble type" ,self.typeID)
             --self:setSelect(true)
             self.BubbleLayer:dealLinkBubble(self)

           
         elseif event.name =="moved" then

         elseif event.name =="ended" then
                      
         end
     end)  
end



return Bubble