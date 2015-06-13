
require("config")
require("cocos.init")
require("framework.init")

local MyApp = class("MyApp", cc.mvc.AppBase)

function MyApp:ctor()
    MyApp.super.ctor(self)
end

function MyApp:run()
	--添加搜索路径
    cc.FileUtils:getInstance():addSearchPath("res/")
    cc.FileUtils:getInstance():addSearchPath("res/Effect")

     display.addSpriteFrames("ImageCollect.plist", "ImageCollect.png")
    
    self:enterScene("GameScene")
end

return MyApp
