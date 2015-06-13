
local  LevelScene=class("LevelScene", function ( )
	return display.newScene("LevelScene");
end)

function LevelScene:ctor()
	-- body
	self.backMap=display.newSprite("level_map.png",display.cx,display.cy)
	             :addTo(self)


end

return LevelScene