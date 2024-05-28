import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"

local screenW = 400
local screenH = 240

local gfx <const> = playdate.graphics
local tileSize
local tilemapImg
local playerImg
local tilemap
local tilemapWOffset
local tilemapHOffset

local playerSprite

import "map"
import "game"

local function recalculateTilemap()
    local w = GetMapWidth()
    local h = GetMapHeight()
    tilemap:setSize(w, h)
    local wPixels = w * tileSize
    local hPixels = h * tileSize

    tilemapWOffset = (screenW-wPixels)/2 + 1
    tilemapHOffset = 1

    -- TODO: only recalculate tilemap data when map data changes
    for i = 1,w+1 do
        for j = 1,h+1 do
            local s = GetMapAt(i, j)

            -- TODO: figure out the right tile based on surrounding data
            local tile = 2
            if s == 1 then
                tile = 9
            end
            -- print("Tile at " .. i .. ", " .. j .. " = " .. tile)
            tilemap:setTileAtPosition(i, j, tile)
        end
    end
end

local function myGameSetUp()
    print("Game setup start")
    gfx.setImageDrawMode(gfx.kDrawModeBlackTransparent)
    gfx.setBackgroundColor(gfx.kColorBlack);

    tilemapImg = gfx.imagetable.new("images/tilemap")
    playerImg = tilemapImg:getImage(1, 3)
    if playerImg == nil then
        print("Missing image?")
        return
    end
    tileSize = playerImg:getSize()

    playerSprite = gfx.sprite.new(playerImg)
    playerSprite:moveTo(-100, -100) --offscreen
    playerSprite:add()

    tilemap = gfx.tilemap.new()
    tilemap:setImageTable(tilemapImg)

    InitRandomMap()
    recalculateTilemap()

    print("Game setup end")
end

myGameSetUp()

function playdate.update()
    GameUpdate()

    --TODO: recalculate tilemap

    gfx.clear()
    gfx.sprite.update()
    tilemap:draw(tilemapWOffset, tilemapHOffset) --TODO: offset tilemap by multiplier by screen size
    playdate.timer.updateTimers()
end