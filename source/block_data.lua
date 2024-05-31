-- block data:
--   0 - not part of the block
--   1 - normal part of the block
--   2 - entry point of the block
--   3 - exit point of the block

local blockData = {}
local blockWidth = 4
local blockHeight = 4
-- blockData[1] = {
--     1, 1, 1, 1,
--     1, 1, 1, 1,
--     1, 1, 1, 1,
--     1, 1, 1, 1
-- }
blockData[1] = {
    0, 1, 3, 0,
    0, 1, 0, 0,
    0, 2, 0, 0,
    0, 0, 0, 0
}
blockData[2] = {
    0, 3, 1, 0,
    0, 0, 1, 0,
    0, 0, 2, 0,
    0, 0, 0, 0
}
blockData[3] = {
    0, 0, 0, 0,
    2, 1, 1, 3,
    0, 0, 0, 0,
    0, 0, 0, 0
}

function GetBlock(i)
    return blockData[i]
end

function GetBlockCount()
    return #blockData
end

function GetBlockWidth()
    return blockWidth
end

function GetBlockHeight()
    return blockHeight
end