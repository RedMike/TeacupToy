local printEnabled = true -- set to false for release build

function DebugPrint(msg)
    if printEnabled then
        print(msg)
    end
end
