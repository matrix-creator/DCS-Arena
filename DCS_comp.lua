--- Initialization of DCS WoWs CBs
--[[
Author: Kameron H
Date: 12/29/2023
Version 1.0

Time Int Values:
    300 = 5 mins
    3900 = 1 hour and 5 mins
]]--

local absTime = timer.getAbsTime()
local envTime = timer.getTime0()
local RED = 1
local BLUE = 2
local game_running = true
--[[if absTime + 300 > envTime then
    red_vp = 1000
    blue_vp = 1000
end]]--
trigger.action.outTextForCoalition(RED, 'Red: ' .. red_vp .. ' Blue: ' .. blue_vp .. '  Bonds: ' .. red_bonds, 5, true)
trigger.action.outTextForCoalition(BLUE, 'Red: ' .. red_vp .. ' Blue: ' .. blue_vp .. '  Bonds: ' .. blue_bonds, 5, true)
if absTime - envTime > 3900 then
        --DCS.setPause(true)
    if red_vp > blue_vp then
           trigger.action.setUserFlag('BLUE', 0)
        trigger.action.outText('Red has won! ' .. 'Red: ' .. red_vp .. ' Blue: ' .. blue_vp, 30, true)
    elseif blue_vp > red_vp then
        trigger.action.setUserFlag('RED', 0)
        trigger.action.outText('Blue has won! ' .. 'Red: ' .. red_vp .. ' Blue: ' .. blue_vp, 30, true)
    end
end
if absTime - envTime > 300 then
    if red_vp <= 0 then
        trigger.action.setUserFlag('RED', 0)
        trigger.action.outText('Blue has won! ' .. 'Red: ' .. red_vp .. ' Blue: ' .. blue_vp, 30, true)
    elseif blue_vp <= 0 then
        trigger.action.setUserFlag('BLUE', 0)
        trigger.action.outText('Red has won! ' .. 'Red: ' .. red_vp .. ' Blue: ' .. blue_vp, 30, true)
    end
end