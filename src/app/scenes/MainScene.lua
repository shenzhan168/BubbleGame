
local MainScene = class("MainScene", function()
    return display.newPhysicsScene("MainScene")
end)

function MainScene:ctor()

    self.world = self:getPhysicsWorld()
    self.world:setGravity(cc.p(0, -98.0))
   -- self.world:setDebugDrawMask(cc.PhysicsWorld.DEBUGDRAW_ALL)

    local ground = display.newNode()
    local bodyBottom = cc.PhysicsBody:createEdgeSegment(cc.p(0, 50), cc.p(480, 50))
    ground:setPhysicsBody(bodyBottom)
    self:addChild(ground)

    local left = display.newNode()
    local bodyLeft = cc.PhysicsBody:createEdgeSegment(cc.p(1, 50), cc.p(1, 800))
    left:setPhysicsBody(bodyLeft)
    self:addChild(left)

    local rightSide = display.newNode()
    local bodyRight = cc.PhysicsBody:createEdgeSegment(cc.p(479, 50), cc.p(479, 800))
    rightSide:setPhysicsBody(bodyRight)
    self:addChild(rightSide)
   
	self:initScene()

    for i=1,90 do
        print(i)
        self:initBall()
    end

    

end

function MainScene:initScene()
	print("init scene")
	self.bgSprite = display.newSprite("main_bg.png",display.cx,display.cy)
	                  :addTo(self)

	self.titleSprite=display.newSprite("main_title.png",display.cx,display.cy+150)
	                   :addTo(self)
    
    self.titleSprite:setTouchEnabled(true)
    self.titleSprite:addNodeEventListener(cc.NODE_TOUCH_EVENT,function(event)
    	-- body
        
        --print("touch")
        if(event.name == "began") then
           print("began")
           local ac=cc.ScaleTo:create(0.1, 1.2, 1.2, 1)
           transition.execute(self.titleSprite,ac)
        elseif event.name =="ended" then
        	--todo
        	local ac=cc.ScaleTo:create(0.1, 1, 1, 1)
           transition.execute(self.titleSprite,ac)
        	print("end")
        end
        

    	return true;
    end)

    -- self.go=display.newSprite("main_start.png",display.cx,display.cy)
    --         :addTo(self)

    -- local goWidth = self.go:getContentSize().width/2

    -- local body=cc.PhysicsBody:createCircle(goWidth,cc.PHYSICSBODY_MATERIAL_DEFAULT, cc.p(0,0))
    -- self.go:setPhysicsBody(body);


end

function MainScene:createSceneEdge()
    -- body
end

function  MainScene:initBall()
    -- body
    print("create Ball")

    local   ballSprite=display.newSprite("selectionsss.png",display.cx,display.cy)
                       :addTo(self)
    

    local width=ballSprite:getContentSize().width/2

    local   candySprite=display.newSprite("row1.png",width,width)
                        :addTo(ballSprite)

    local MATERIAL_DEFAULT = cc.PhysicsMaterial(20.0, 0.9, 0)

    local ballBody=cc.PhysicsBody:createCircle(width,MATERIAL_DEFAULT,cc.p(0,0))
    ballSprite:setPhysicsBody(ballBody)
end

function MainScene:onEnter()
end

function MainScene:onExit()
end

return MainScene
