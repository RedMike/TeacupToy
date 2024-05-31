import "debug"
import "block_data"

local availableBlocks = {}

function AddRandomAvailableBlock()
    local count = #availableBlocks
    local randomBlock = count + 1
    availableBlocks[count+1] = GetBlock(randomBlock)
    DebugPrint("[block] AddRandomAvailableBlock " .. count .. " + " .. randomBlock .. " now length " .. #availableBlocks)
end

function GetAvailableBlockCount()
    return #availableBlocks
end

function GetAvailableBlock(i)
    return availableBlocks[i]
end

