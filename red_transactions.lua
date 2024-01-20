--- transactions script
--[[
Author: Kameron H
Date: 12/29/2023
Version 1.0
]]--

local RED = 1

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
local A_atk = missionCommands.addSubMenuForCoalition(RED, 'A', attackCmds)
local B_atk = missionCommands.addSubMenuForCoalition(RED, 'B', attackCmds)
local C_atk = missionCommands.addSubMenuForCoalition(RED, 'C', attackCmds)
local A_def = missionCommands.addSubMenuForCoalition(RED, 'A', defenseCmds)
local B_def = missionCommands.addSubMenuForCoalition(RED, 'B', defenseCmds)
local C_def = missionCommands.addSubMenuForCoalition(RED, 'C', defenseCmds)

--- FUNCTIONS FOR ATTACKING
local function legalizeNuclearBombs()
    if red_bonds >= mig_nuke then
        trigger.action.outText('Nuke inbound for Red Spawn', 15)
        setRedBonds(red_bonds - mig_nuke)
        mist.respawnGroup('Red Nuke', true)
    else
        trigger.action.outTextForCoalition(RED, 'Not Enough Bonds for Nuke', 15)
    end
end
local function respawn()
    if red_bonds >= respawn_convoy then
        setRedBonds(red_bonds - respawn_convoy)
    else
        trigger.action.outTextForCoalition(RED, 'Not Enough Bonds for Convoy', 15)
    end
end
--A--
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
--B--
--C--
--- FUNCTIONS FOR DEFENDING
--A--
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
--B--
--C--
--- ATTACK COMMANDS
missionCommands.addCommandForCoalition(RED, 'MiG-21 Nuclear Bomb', attackCmds, legalizeNuclearBombs)
missionCommands.addCommandForCoalition(RED, 'Respawn Destroyed Convoy', attackCmds, respawn)

missionCommands.addCommandForCoalition(RED, 'B-52 AGM-86C Salvo', A_atk, agm_salvo_a)
missionCommands.addCommandForCoalition(RED, 'F-16C Fighting Falcon SEAD Strike', A_atk, sead_a)
missionCommands.addCommandForCoalition(RED, 'A-10C Thunderbolt II CAS Strike', A_atk, cas_a)

--missionCommands.addCommandForCoalition(RED, 'B-52 AGM-86C Salvo', B_atk, agm_salvo_b)
--missionCommands.addCommandForCoalition(RED, 'F-16C Fighting Falcon SEAD Strike', B_atk, sead_b)
--missionCommands.addCommandForCoalition(RED, 'A-10C Thunderbolt II CAS Strike', B_atk, cas_b)

--missionCommands.addCommandForCoalition(RED, 'B-52 AGM-86C Salvo', C_atk, agm_salvo_c)
--missionCommands.addCommandForCoalition(RED, 'F-16C Fighting Falcon SEAD Strike', C_atk, sead_c)
--missionCommands.addCommandForCoalition(RED, 'A-10C Thunderbolt II CAS Strike', C_atk, cas_c)

--- DEFENSE COMMANDS
missionCommands.addCommandForCoalition(RED, 'SA-10 "Grumble" S-300 Complex Spawn', A_def, grumble_spawn_a)
missionCommands.addCommandForCoalition(RED, 'SA-11 "Gadfly" Buk Complex Spawn', A_def, gadfly_spawn_a)
missionCommands.addCommandForCoalition(RED, 'SA-3 "Goa" S-125 Neva Spawn', A_def, goa_spawn_a)
missionCommands.addCommandForCoalition(RED, 'SA-19 "Grison" 2K22 Tunguska Spawn', A_def, grison_spawn_a)
--[[
missionCommands.addCommandForCoalition(RED, 'SA-10 "Grumble" S-300 Complex Spawn', B_def, grumble_spawn_b)
missionCommands.addCommandForCoalition(RED, 'SA-11 "Gadfly" Buk Complex Spawn', B_def, gadfly_spawn_b)
missionCommands.addCommandForCoalition(RED, 'SA-3 "Goa" S-125 Neva Spawn', B_def, goa_spawn_b)
missionCommands.addCommandForCoalition(RED, 'SA-19 "Grison" 2K22 Tunguska Spawn', B_def, grison_spawn_b)

missionCommands.addCommandForCoalition(RED, 'SA-10 "Grumble" S-300 Complex Spawn', C_def, grumble_spawn_c)
missionCommands.addCommandForCoalition(RED, 'SA-11 "Gadfly" Buk Complex Spawn', C_def, gadfly_spawn_c)
missionCommands.addCommandForCoalition(RED, 'SA-3 "Goa" S-125 Neva Spawn', C_def, goa_spawn_c)
missionCommands.addCommandForCoalition(RED, 'SA-19 "Grison" 2K22 Tunguska Spawn', C_def, grison_spawn_c)
]]--
missionCommands.addCommandForCoalition(RED, 'EWR Complex Spawn', defenseCmds, ewr_spawn)