--[[游戏场景
  
  by superzhan
]]
 



local Bubble = require("app.Bubble.Bubble")
local BubbleLayer=require("app.Bubble.BubbleLayer")



local GameScene=class("GameScene", function()
	return display.newPhysicsScene("GameScene")
end)

function GameScene:ctor()

    --设置物理参数
    self.world = self:getPhysicsWorld()
    self.world:setGravity(cc.p(0, -980.0))
    --self.world:setDebugDrawMask(cc.PhysicsWorld.DEBUGDRAW_ALL)
    
    math.randomseed(os.time()) 

    local particle = cc.ParticleSystemQuad:create("gameBack.plist")
    self:addChild(particle)
  

    self.bubbleLayer=BubbleLayer.new()
                     :addTo(self)
	
end





return GameScene