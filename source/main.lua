import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"

local gfx <const> = playdate.graphics
local tilemap
local playerImg

local playerSprite

import "game"

local function myGameSetUp()
    print("Game setup start")
    gfx.setImageDrawMode(gfx.kDrawModeBlackTransparent)
    gfx.setBackgroundColor(gfx.kColorBlack);

    tilemap = gfx.imagetable.new("images/tilemap")
    playerImg = tilemap:getImage(1, 3)

    playerSprite = gfx.sprite.new(playerImg)
    playerSprite:moveTo(100, 100)
    playerSprite:add()
    print("Game setup end")
end

myGameSetUp()

function playdate.update()
    GameUpdate()

    gfx.clear()
    gfx.sprite.update()
    playdate.timer.updateTimers()
end