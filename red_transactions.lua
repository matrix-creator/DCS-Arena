--- transactions script
--[[
Author: *HIDDEN*
Date: 1/20/2024
Version 1.1
    1.1 -> changed functions and values to match that in "values.lua"
]]--

local RED = 1
local BLUE = 2

--- STORE VALUES
local mig_nuke = 800
local b52 = 450
local f16 = 400
local a10c = 200
local respawn_convoy = 100
local sa10 = 450
local sa11 = 300
local sa3 = 200
local ewr = 200
local sa19 = 100

local attackCmds = missionCommands.addSubMenuForCoalition(RED, 'Attack')
local defenseCmds = missionCommands.addSubMenuForCoalition(RED, 'Defense')

--- FUNCTIONS FOR ATTACKING
local function legalizeNuclearBombs()
    if red_bonds >= mig_nuke then
        trigger.action.outText('Nuke inbound for Blue Spawn', 15)
        trigger.action.outSoundForCoalition(BLUE, "l10n/DEFAULT/nuke_inbound.wav")
        setRedBonds(red_bonds - mig_nuke)
        mist.respawnGroup('Red Nuke', true)
    else
        trigger.action.outTextForCoalition(RED, 'Not Enough Bonds for Nuke', 15)
    end
end
local function respawn()
    if red_bonds >= respawn_convoy then
        setRedBonds(red_bonds - respawn_convoy)
        mist.respawnGroup('Red Ground A', true)
    else
        trigger.action.outTextForCoalition(RED, 'Not Enough Bonds for Convoy', 15)
    end
end
local function agm_salvo_a()
    if red_bonds >= b52 then
        setRedBonds(red_bonds - b52)
        mist.respawnGroup('Red B52A', true)
    else
        trigger.action.outTextForCoalition(RED, 'Not Enough Bonds for AGM-86C Salvo', 15)
    end
end
local function sead_a()
    if red_bonds >= f16 then
        setRedBonds(red_bonds - f16)
        mist.respawnGroup('Red F16A', true)
    else
        trigger.action.outTextForCoalition(RED, 'Not Enough Bonds for SEAD Strike', 15)
    end
end
local function cas_a()
    if red_bonds >= a10c then
        setRedBonds(red_bonds - a10c)
        mist.respawnGroup('Red A10A', true)
    else
        trigger.action.outTextForCoalition(RED, 'Not Enough Bonds for CAS', 15)
    end
end
--- FUNCTIONS FOR DEFENDING
local function grumble_spawn_a()
    if red_bonds >= sa10 then
        setRedBonds(red_bonds - sa10)
        mist.respawnInZone('Red Grumble A', 'Red A Defense', false, 25, nil)
    else
        trigger.action.outTextForCoalition(RED, 'Not Enough Bonds for SA-10', 15)
    end
end
local function gadfly_spawn_a()
    if red_bonds >= sa11 then
        setRedBonds(red_bonds - sa11)
        mist.respawnInZone('Red Gadfly A', 'Red A Defense', false, 25, nil)
    else
        trigger.action.outTextForCoalition(RED, 'Not Enough Bonds for SA-11', 15)
    end
end
local function goa_spawn_a()
    if red_bonds >= sa3 then
        setRedBonds(red_bonds - sa3)
        mist.respawnInZone('Red Goa A', 'Red A Defense', false, 25, nil)
    else
        trigger.action.outTextForCoalition(RED, 'Not Enough Bonds for SA-3', 15)
    end
end
local function grison_spawn_a()
    if red_bonds >= sa19 then
        setRedBonds(red_bonds - sa19)
        mist.respawnInZone('Red Grison A', 'Red A Defense', false, 25, nil)
    else
        trigger.action.outTextForCoalition(RED, 'Not Enough Bonds for SA-19', 15)
    end
end
local function ewr_spawn()
    if red_bonds >= ewr then
        setRedBonds(red_bonds - ewr)
        mist.respawnGroup('Red EWR', true)
    else
        trigger.action.outTextForCoalition(RED, 'Not Enough Bonds for EWR', 15)
    end
end

--- ATTACK COMMANDS
missionCommands.addCommandForCoalition(RED, 'Respawn Destroyed Convoy (100A)', attackCmds, respawn)
missionCommands.addCommandForCoalition(RED, 'B-52 AGM-86C Salvo (450)', attackCmds, agm_salvo_a)
missionCommands.addCommandForCoalition(RED, 'F-16C SEAD Strike (400)', attackCmds, sead_a)
missionCommands.addCommandForCoalition(RED, 'A-10C CAS Strike (200)', attackCmds, cas_a)
missionCommands.addCommandForCoalition(RED, 'MiG-21 Nuclear Bomb (800)', attackCmds, legalizeNuclearBombs)

--- DEFENSE COMMANDS
missionCommands.addCommandForCoalition(RED, 'SA-10 "Grumble" (450)', defenseCmds, grumble_spawn_a)
missionCommands.addCommandForCoalition(RED, 'SA-11 "Gadfly" (300)', defenseCmds, gadfly_spawn_a)
missionCommands.addCommandForCoalition(RED, 'SA-3 "Goa" (200)', defenseCmds, goa_spawn_a)
missionCommands.addCommandForCoalition(RED, 'SA-19 "Grison" (100)', defenseCmds, grison_spawn_a)
missionCommands.addCommandForCoalition(RED, 'EWR Complex Spawn (200)', defenseCmds, ewr_spawn)