local StartScene = class("StartScene", function()
    return display.newScene("StartScene")
end)

function StartScene:ctor()
     
     print("StartScene")	
     self.bgSprite = display.newSprite("main_bg.png",display.cx,display.cy)
	                  :addTo(self)

	self.titleSprite=display.newSprite("main_title.png",display.cx,display.cy+150)
	                   :addTo(self)
  
 end 


 return StartScene