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

## Summary

Post-menus there's 4 basic game states, starts in 1.

1. Place block:
	a. Have a currently highlighted block from available blocks.
	b. Have a specific current place point on map.
	c. Show place point on map with ghost of currently highlighted block.
	d. When rotate key is pressed, rotate currently highlighted block.
	e. When confirm key is pressed, go to #2.
2. Block placed:
	a. Remove current block from available blocks (get new from queued).
	b. Set new place point on map based on current block and rotation.
	c. If no block placements are possible, go to #3.
	d. If all enemies covered, go to #3.
	e. Go to #1.
3. Blocks all done:
	a. When correct input is done for top of list of movements, show animation then pop top of list.
	b. When incorrect input is done, show animation.
	c. When entire list done, go to #4.
4. Animation all done:
	a. Remove any enemies covered by list of movements.
	b. Move player to final place location.
	c. If all enemies removed, end level.
	d. Go to #1.

When entering 1:
1. Generate map (if needed, when new map).
2. Generate enemies (if needed, when new map).
3. Generate a shuffled list of blocks available (and queued potentially).

When entering 3:
1. Turn placed blocks into a list of movements that need to be done in sequence.

## Initial MVP tasks

[x] map drawing
[x] block graphics
[x] block hand drawing
[ ] block outline
[ ] mob drawing
[ ] block selection process
[ ] block map drawing
[ ] block rotation
[ ] available vs placed blocks