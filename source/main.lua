import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"

local gfx <const> = playdate.graphics
local tilemapImg
local playerImg
local tilemap

local playerSprite

import "map"
import "game"

local function myGameSetUp()
    print("Game setup start")
    gfx.setImageDrawMode(gfx.kDrawModeBlackTransparent)
    gfx.setBackgroundColor(gfx.kColorBlack);

    tilemapImg = gfx.imagetable.new("images/tilemap")
    playerImg = tilemapImg:getImage(1, 3)

    playerSprite = gfx.sprite.new(playerImg)
    playerSprite:moveTo(-100, -100) --offscreen
    playerSprite:add()

    tilemap = gfx.tilemap.new()
    tilemap:setImageTable(tilemapImg)

    InitRandomMap()
    tilemap:setSize(GetMapWidth(), GetMapHeight())
    -- TODO: only recalculate tilemap data when map data changes
    for i = 1,GetMapWidth()+1 do
        for j = 1,GetMapHeight()+1 do
            local s = GetMapAt(i, j)
            local tile = 1
            if s == 1 then
                tile = 3
            end
            print("Tile at " .. i .. ", " .. j .. " = " .. tile)
            tilemap:setTileAtPosition(i, j, tile)
        end
    end

    print("Game setup end")
end

myGameSetUp()

function playdate.update()
    GameUpdate()

    --TODO: recalculate tilemap

    gfx.clear()
    gfx.sprite.update()
    tilemap:draw(1, 1) --TODO: offset tilemap by multiplier by screen size
    playdate.timer.updateTimers()
end