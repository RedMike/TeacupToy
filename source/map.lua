-- map is just a basic field of tiles, boolean for whether wall or floor

import "debug"

local mapData = {}
local mapWidth = 12
local mapHeight = 7

local function clearMap(s)
    mapData = {}
    for i=1,mapWidth*mapHeight+1 do
        mapData[i] = s
    end
end

local function mapIndex(x, y)
    return y*(mapWidth + 1) + x;
end

local function addMapRect(x, y, w, h, s)
    for i=x,x+w-1 do
        for j=y,y+h-1 do
            if i < 1 or i > mapWidth then
                goto continue
            end
            if j < 1 or j > mapHeight then
                goto continue
            end
            mapData[mapIndex(i, j)] = s
            ::continue::
        end
    end
end

function InitRandomMap()
    DebugPrint("[map] InitRandomMap")
    clearMap(0)

    --TODO: actually generate

    -- first make a rectangular room
    addMapRect(3, 2, 4, 4, 1)

    DebugPrint("[map] InitRandomMap done")
end

function GetMapWidth()
    return mapWidth
end

function GetMapHeight()
    return mapHeight
end

function GetMapAt(x, y)
    if x < 1 or x > mapWidth then
        return 0
    end
    if y < 1 or y > mapHeight then
        return 0
    end

    return mapData[mapIndex(x, y)]
end