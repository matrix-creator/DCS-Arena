--- Initialization of DCS WoWs CBs
--[[
Author: *HIDDEN*
Date: 12/29/2023
Version 1.2.1
    1.1 -> added cap timers for VP and bonds
    1.2 -> changed the cap calculations to be if one is greater than other
        1.2.1 -> added destroyNil to remove nil values from ground unit tables in zone
]]--

local time = timer.getAbsTime() - timer.getTime0()
local RED = 1
local BLUE = 2


-- Game Ending Conditions w/ print statements
if time > 3900 then
    if red_vp > blue_vp then
        trigger.action.setUserFlag('BLUE', 0)
        trigger.action.outText('Red has won! ' .. 'Red: ' .. red_vp .. ' Blue: ' .. blue_vp, 30, true)
    elseif blue_vp > red_vp then
        trigger.action.setUserFlag('RED', 0)
        trigger.action.outText('Blue has won! ' .. 'Red: ' .. red_vp .. ' Blue: ' .. blue_vp, 30, true)
    end
elseif time > 300 then
    if red_vp <= 0 then
        trigger.action.setUserFlag('RED', 0)
        trigger.action.outText('Blue has won! ' .. 'Red: ' .. red_vp .. ' Blue: ' .. blue_vp, 30, true)
    elseif blue_vp <= 0 then
        trigger.action.setUserFlag('BLUE', 0)
        trigger.action.outText('Red has won! ' .. 'Red: ' .. red_vp .. ' Blue: ' .. blue_vp, 30, true)
    end
elseif mist.groupIsDead('Red_Lifeline') == true then
    trigger.action.setUserFlag('RED', 0)
    trigger.action.outText('Blue has won! ' .. 'Red: ' .. red_vp .. ' Blue: ' .. blue_vp, 30, true)
elseif mist.groupIsDead('Blue_Lifeline') == true then
    trigger.action.setUserFlag('BLUE', 0)
    trigger.action.outText('Red has won! ' .. 'Red: ' .. red_vp .. ' Blue: ' .. blue_vp, 30, true)
end
if time < 30 then
    trigger.action.outText('Please Note!!! Once you pick a team, you cannot change. Thanks!', 1, true)
end

-- Cap Condtions (Adds points if ground units are greater than enemy units in the cap)
local u = mist.getUnitsInZones(mist.makeUnitTable({'[all]'}), {'A_zone'}, 'cylinder')
local blue = {}
local red = {}
for i = 1, #u do
    local coalition = Unit.getCoalition(u[i])
    if coalition == BLUE then
        table.insert(blue, u[i])
    elseif coalition == RED then
        table.insert(red, u[i])
    end
end
function destroyNil(table)
    local tbl = {}
    for i = 1, #table do
        if (table[i] ~= nil) then
            table.insert(tbl, table[i])
        end
    end
    table = tbl
end
destroyNil(blue)
destroyNil(red)
if mist.groupIsDead('Blue Ground A') == false then
    if capTime == 0 and (#blue > #red) then
        setCapTime(time)
    elseif (time - capTime) >= 60 and capTime ~= 0 then
        setRedVP(red_vp - 10)
        setBlueBonds(blue_bonds + 10)
        setCapTime(0)
    end
elseif mist.groupIsDead('Red Ground A') == false then
    if capTime == 0 and (#blue < #red) then
        setCapTime(time)
    elseif (time - capTime) >= 60  and capTime ~= 0 then
        setBlueVP(blue_vp - 10)
        setRedBonds(red_bonds + 10)
        setCapTime(0)
    end
end