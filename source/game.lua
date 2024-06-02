import "debug"
import "map"
import "block_data"
import "block"

-- game states:
--  0 - first level init
--  1 - place block
--  2 - block placed
--  3 - blocks all done
--  4 - animation all done
--  5 - level end

local currentState = 0
local gameInitDone = false

local playerX, playerY

local function gameInit()
    if gameInitDone then
        return
    end
    gameInitDone = true

    DebugPrint("[game] Game init")
    InitRandomMap()
    AddRandomAvailableBlock()
    AddRandomAvailableBlock()
    AddRandomAvailableBlock()

    --TODO: actually place player/mobs properly
    playerX = 7
    playerY = 3
end

local function gameEnded()
    DebugPrint("[game] Game end")

end

local function moveToState(newState)
    if newState == currentState then
        return
    end
    if newState == 0 then
        DebugPrint("[game] ERROR: Attempting to set state 0")
        return
    end
    if currentState == 5 then
        DebugPrint("[game] ERROR: Attempting to move from state 5")
        return
    end
    DebugPrint("[game] Moving from " .. currentState .. " to " .. newState)

    if newState == 5 then
        DebugPrint("[game] Game ending")
        gameEnded()
    end

    DebugPrint("[game] Moved from " .. currentState .. " to " .. newState)
    currentState = newState
end

function TryMoveToState(newState)
    if newState == currentState then
        return false
    end
    if currentState == 0 and not gameInitDone then
        return false
    end
    moveToState(newState)
    return true
end

function GameUpdate()
    if currentState == 0 then
        gameInit()
        return currentState
    end
    if currentState == 5 then
        -- we're finished, no relevant state any more
        return currentState
    end

    -- TODO: state handling
    return currentState
end

function GetGameState()
    return currentState
end

function GetPlayerX()
    return playerX
end
function GetPlayerY()
    return playerY
end
