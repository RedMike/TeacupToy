import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"

-- local gfx <const> = playdate.graphics

local function myGameSetUp()
    print("Game setup")

end

myGameSetUp()

function playdate.update()

    -- gfx.sprite.update()
    playdate.timer.updateTimers()
end