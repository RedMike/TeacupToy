# TeacupToy
Sample project to figure out Playdate development.

## Instructions

### VSCode Lua

Using [LuaCATS VSCode](https://github.com/notpeter/playdate-luacats) cloned one folder above in `playdate-luacats`.
`git pull` in `playdate-luacats` to update it.

Adding classes:

```
---@class FillSprite: _Sprite
---@field color: integer
---@overload fun(w: integer, h:integer, color:integer): FillSprite
FillSprite = class("FillSprite").extends(playdate.graphics.sprite) or FillSprite

function FillSprite:init(w, h, color)
	local img = playdate.graphics.image.new(w, h, color)
    FillSprite.super.init(self, img)
	self.color = color
end

local ts = FillSprite(64, 64 playdate.graphics.kColorBlack)
```