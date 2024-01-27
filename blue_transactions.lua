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

local attackCmds = missionCommands.addSubMenuForCoalition(BLUE, 'Attack')
local defenseCmds = missionCommands.addSubMenuForCoalition(BLUE, 'Defense')

--- FUNCTIONS FOR ATTACKING
local function legalizeNuclearBombs()
    if blue_bonds >= mig_nuke then
        trigger.action.outText('Nuke inbound for Red Spawn', 15)
        trigger.action.outSoundForCoalition(RED, "l10n/DEFAULT/nuke_inbound.wav")
        setBlueBonds(blue_bonds - mig_nuke)
        mist.respawnGroup('Blue Nuke', true)
    else
        trigger.action.outTextForCoalition(BLUE, 'Not Enough Bonds for Nuke', 15)
    end
end
local function respawn()
    if blue_bonds >= respawn_convoy then
        setBlueBonds(blue+bonds - respawn_convoy)
        mist.respawnGroup('Blue Ground A', true)
    else
        trigger.action.outTextForCoalition(BLUE, 'Not Enough Bonds for Convoy', 15)
    end
end
local function agm_salvo_a()
    if blue_bonds >= b52 then
        setBlueBonds(blue_bonds - b52)
        mist.respawnGroup('Blue B52A', true)
    else
        trigger.action.outTextForCoalition(BLUE, 'Not Enough Bonds for AGM-86C Salvo', 15)
    end
end
local function sead_a()
    if blue_bonds >= f16 then
        setBlueBonds(blue_bonds - f16)
        mist.respawnGroup('Blue F16A', true)
    else
        trigger.action.outTextForCoalition(BLUE, 'Not Enough Bonds for SEAD Strike', 15)
    end
end
local function cas_a()
    if blue_bonds >= a10c then
        setBlueBonds(blue_bonds - a10c)
        mist.respawnGroup('Blue A10A', true)
    else
        trigger.action.outTextForCoalition(BLUE, 'Not Enough Bonds for CAS', 15)
    end
end
--- FUNCTIONS FOR DEFENDING
local function grumble_spawn_a()
    if blue_bonds >= sa10 then
        setBlueBonds(blue_bonds - sa10)
        mist.respawnInZone('Blue Grumble A', 'Blue A Defense', false, 25, nil)
    else
        trigger.action.outTextForCoalition(BLUE, 'Not Enough Bonds for SA-10', 15)
    end
end
local function gadfly_spawn_a()
    if blue_bonds >= sa11 then
        setBlueBonds(blue_bonds - sa11)
        mist.respawnInZone('Blue Gadfly A', 'Blue A Defense', false, 25, nil)
    else
        trigger.action.outTextForCoalition(BLUE, 'Not Enough Bonds for SA-11', 15)
    end
end
local function goa_spawn_a()
    if blue_bonds >= sa3 then
        setBlueBonds(blue_bonds - sa3)
        mist.respawnInZone('Blue Goa A', 'Blue A Defense', false, 25, nil)
    else
        trigger.action.outTextForCoalition(BLUE, 'Not Enough Bonds for SA-3', 15)
    end
end
local function grison_spawn_a()
    if blue_bonds >= sa19 then
        setBlueBonds(blue_bonds - sa19)
        mist.respawnInZone('Blue Grison A', 'Blue A Defense', false, 25, nil)
    else
        trigger.action.outTextForCoalition(BLUE, 'Not Enough Bonds for SA-19', 15)
    end
end
local function ewr_spawn()
    if blue_bonds >= ewr then
        setBlueBonds(blue_bonds - ewr)
        mist.respawnGroup('Blue EWR', true)
    else
        trigger.action.outTextForCoalition(BLUE, 'Not Enough Bonds for EWR', 15)
    end
end
--- ATTACK COMMANDS
missionCommands.addCommandForCoalition(BLUE, 'Respawn Destroyed Convoy A', attackCmds, respawn)
missionCommands.addCommandForCoalition(BLUE, 'B-52 AGM-86C Salvo', attackCmds, agm_salvo_a)
missionCommands.addCommandForCoalition(BLUE, 'F-16C Fighting Falcon SEAD Strike', attackCmds, sead_a)
missionCommands.addCommandForCoalition(BLUE, 'A-10C Thunderbolt II CAS Strike', attackCmds, cas_a)
missionCommands.addCommandForCoalition(BLUE, 'MiG-21 Nuclear Bomb', attackCmds, legalizeNuclearBombs)

--- DEFENSE COMMANDS
missionCommands.addCommandForCoalition(BLUE, 'SA-10 "Grumble" S-300 Complex Spawn', defenseCmds, grumble_spawn_a)
missionCommands.addCommandForCoalition(BLUE, 'SA-11 "Gadfly" Buk Complex Spawn', defenseCmds, gadfly_spawn_a)
missionCommands.addCommandForCoalition(BLUE, 'SA-3 "Goa" S-125 Neva Spawn', defenseCmds, goa_spawn_a)
missionCommands.addCommandForCoalition(BLUE, 'SA-19 "Grison" 2K22 Tunguska Spawn', defenseCmds, grison_spawn_a)
missionCommands.addCommandForCoalition(BLUE, 'EWR Complex Spawn', defenseCmds, ewr_spawn)