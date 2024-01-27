--- initial values
--[[
Author: *HIDDEN*
Date: 1/21/2024
Version 1.2
    1.1 -> made variables global
        1.1.1 -> added global setter functions to change the values
    1.2 -> added printStats()
]]--
values = {}
red_vp = 1000
blue_vp = 1000
red_bonds = 0
blue_bonds = 0
capTime = 0
local RED = 1
local BLUE = 2

function setRedVP(newValue)
    red_vp = newValue
end
function setBlueVP(newValue)
    blue_vp = newValue
end
function setRedBonds(newValue)
    red_bonds = newValue
end
function setBlueBonds(newValue)
    blue_bonds = newValue
end
function setCapTime(newValue)
    capTime = newValue
end

function printStats() 
    trigger.action.outTextForCoalition(RED, 'Red: ' .. red_vp .. ' Blue: ' .. blue_vp .. '  Bonds: ' .. red_bonds, 5)
    trigger.action.outTextForCoalition(BLUE, 'Red: ' .. red_vp .. ' Blue: ' .. blue_vp .. '  Bonds: ' .. blue_bonds, 5)
end

-- Checking for Tactical Nukes Inside an Enemy Base
function checkForNuke()
    local redBase = mist.getUnitsInZones(mist.makeUnitTable({'[g]Blue Nuke'}), {'RedBase'}, 'cylinder')
    local blueBase = mist.getUnitsInZones(mist.makeUnitTable({'[g]Red Nuke'}), {'BlueBase'}, 'cylinder')
    if redBase ~= nil then
        trigger.action.outText('Blue Tactical Nuke has arrived inside Red base.')
        trigger.action.outSoundForCoalition(RED, "l10n/DEFAULT/nuke_arrived.wav")
    end
    if blueBase ~= nil then
        trigger.action.outText('Red Tactical Nuke has arrived inside Blue base.')
        trigger.action.outSoundForCoalition(BLUE, "l10n/DEFAULT/nuke_arrived.wav")
    end
end

env.setErrorMessageBoxEnabled(false)
mist.scheduleFunction(checkForNuke, {}, timer.getTime() + 300, 10, timer.getTime() + 3900)
mist.scheduleFunction(printStats, {}, timer.getTime() + 30, 7, timer.getTime() + 3900)