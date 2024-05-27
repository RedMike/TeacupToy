import "debug"

-- game states:
--  0 - first level init
--  1 - place block
--  2 - block placed
--  3 - blocks all done
--  4 - animation all done
--  5 - level end

local currentState = 0;

local function gameInit()
    DebugPrint("[game] Game init")

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

function GameUpdate()
    if currentState == 0 then
        gameInit()
        moveToState(1)
        return
    end
    if currentState == 5 then
        -- we're finished, no relevant state any more
        return
    end
end

function GetGameState()
    return currentState
end
