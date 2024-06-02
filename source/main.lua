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
local blockTilemapImg
local tilemap
local tilemapWOffset
local tilemapHOffset

local playerSprite

local availableBlockTilemaps = {}

import "map"
import "game"
import "block_data"
import "block"

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

            -- a  b  c
            -- d (s) f
            -- m  n  o

            local a = GetMapAt(i-1, j-1)
            local b = GetMapAt(i, j-1)
            local c = GetMapAt(i+1, j-1)
            local d = GetMapAt(i-1, j)
            local f = GetMapAt(i+1, j)
            local m = GetMapAt(i-1, j+1)
            local n = GetMapAt(i, j+1)
            local o = GetMapAt(i+1, j+1)

            local tile = 9 --default to show nothing

            if s == 0 then
                --if it's a wall then we always show the blank spot
                tile = 1
            elseif s == 1 then
                --if it's not a wall then sometimes we show the specific tile
                if a == 0 and b == 0 and d == 0 then
                    tile = 2
                elseif b == 0 and c == 0 and f == 0 then
                    tile = 4
                elseif d == 0 and m == 0 and n == 0 then
                    tile = 18
                elseif f == 0 and o == 0 and n == 0 then
                    tile = 20
                elseif d == 0 then
                    tile = 10
                elseif f == 0 then
                    tile = 12
                elseif n == 0 then
                    tile = 19
                elseif b == 0 then
                    tile = 3
                end
            end

            if false and s == 0 then --if it's a wall then we show the appropriate tile
                if f == 0 and m == 0 and n == 0 and o == 1 then
                    tile = 2
                elseif d == 0 and m == 1 and n == 0 and o == 0 then
                    tile = 4
                elseif n == 1 then
                    tile = 3
                elseif f == 0 and a == 0 and b == 0 and c == 1 then
                    tile = 18
                elseif d == 0 and a == 1 and b == 0 and c == 0 then
                    tile = 20
                elseif b == 1 then
                    tile = 19
                elseif f == 1 then
                    tile = 10
                elseif d == 1 then
                    tile = 12
                else
                    tile = 1
                end
            end

            -- print("Tile at " .. i .. ", " .. j .. " = " .. tile)
            tilemap:setTileAtPosition(i, j, tile)
        end
    end
end

local function recalculateAvailableBlocks()
    local w = GetBlockWidth()
    local h = GetBlockHeight()

    -- TODO: only recalculate tilemap data when block data changes
    local count = GetAvailableBlockCount()
    for i = 1,count do
        local data = GetAvailableBlock(i)
        availableBlockTilemaps[i] = gfx.tilemap.new()
        availableBlockTilemaps[i]:setSize(w, h)
        availableBlockTilemaps[i]:setImageTable(blockTilemapImg)

        for x = 1,w do
            for y = 1,h do
                local tile = 4
                if data[((y-1) * w) + x] ~= 0 then
                    tile = 2
                end
                availableBlockTilemaps[i]:setTileAtPosition(x, y, tile)
            end
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
    blockTilemapImg = gfx.imagetable.new("images/blockmap")

    playerSprite = gfx.sprite.new(playerImg)
    playerSprite:moveTo(-100, -100) --offscreen
    playerSprite:add()

    tilemap = gfx.tilemap.new()
    tilemap:setImageTable(tilemapImg)

    recalculateTilemap()

    recalculateAvailableBlocks()

    print("Game setup end")
end

myGameSetUp()

function playdate.update()
    local gameState = GameUpdate()
    if gameState == 0 then
        myGameSetUp()
        TryMoveToState(1)
    end

    --TODO: recalculate tilemap when map data/block data changed

    gfx.clear()
    gfx.sprite.update()
    tilemap:draw(tilemapWOffset, tilemapHOffset)
    local count = GetAvailableBlockCount()
    for i = 1,count do
        local startX = 10 + i * 60
        local startY = screenH - 46
        availableBlockTilemaps[i]:draw(startX+5, startY + 3)
        gfx.setColor(gfx.kColorWhite)
        gfx.setLineWidth(1)
        gfx.drawRect(startX, startY+1, 40, 45)
    end
    playdate.timer.updateTimers()
end