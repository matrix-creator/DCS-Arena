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
local A_atk = missionCommands.addSubMenuForCoalition(BLUE, 'A', attackCmds)
local B_atk = missionCommands.addSubMenuForCoalition(BLUE, 'B', attackCmds)
local C_atk = missionCommands.addSubMenuForCoalition(BLUE, 'C', attackCmds)
local A_def = missionCommands.addSubMenuForCoalition(BLUE, 'A', defenseCmds)
local B_def = missionCommands.addSubMenuForCoalition(BLUE, 'B', defenseCmds)
local C_def = missionCommands.addSubMenuForCoalition(BLUE, 'C', defenseCmds)

--- FUNCTIONS FOR ATTACKING
local function legalizeNuclearBombs()
    if blue_bonds >= mig_nuke then
        trigger.action.outText('Nuke inbound for Red Spawn', 15)
        trigger.action.outSound("l10n/DEFAULT/nuke_inbound.wav")
        setBlueBonds(blue_bonds - mig_nuke)
        mist.respawnGroup('Blue Nuke', true)
    else
        trigger.action.outTextForCoalition(BLUE, 'Not Enough Bonds for Nuke', 15)
    end
end
    --A--
local function respawn()
    if blue_bonds >= respawn_convoy then
        setBlueBonds(blue+bonds - respawn_convoy)
        mist.respawnGroup('Blue Ground A', true)
    else
        trigger.action.outTextForCoalition(RED, 'Not Enough Bonds for Convoy', 15)
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
    --B--
    --C--
--- FUNCTIONS FOR DEFENDING
    --A--
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
    --B--
    --C--
--- ATTACK COMMANDS
missionCommands.addCommandForCoalition(BLUE, 'MiG-21 Nuclear Bomb', attackCmds, legalizeNuclearBombs)

missionCommands.addCommandForCoalition(BLUE, 'Respawn Destroyed Convoy A', A_atk, respawn)
missionCommands.addCommandForCoalition(BLUE, 'B-52 AGM-86C Salvo', A_atk, agm_salvo_a)
missionCommands.addCommandForCoalition(BLUE, 'F-16C Fighting Falcon SEAD Strike', A_atk, sead_a)
missionCommands.addCommandForCoalition(BLUE, 'A-10C Thunderbolt II CAS Strike', A_atk, cas_a)
--[[
missionCommands.addCommandForCoalition(BLUE, 'B-52 AGM-86C Salvo', B_atk, agm_salvo_b)
missionCommands.addCommandForCoalition(BLUE, 'F-16C Fighting Falcon SEAD Strike', B_atk, sead_b)
missionCommands.addCommandForCoalition(BLUE, 'A-10C Thunderbolt II CAS Strike', B_atk, cas_b)

missionCommands.addCommandForCoalition(BLUE, 'B-52 AGM-86C Salvo', C_atk, agm_salvo_c)
missionCommands.addCommandForCoalition(BLUE, 'F-16C Fighting Falcon SEAD Strike', C_atk, sead_c)
missionCommands.addCommandForCoalition(BLUE, 'A-10C Thunderbolt II CAS Strike', C_atk, cas_c)
]]--
--- DEFENSE COMMANDS
missionCommands.addCommandForCoalition(BLUE, 'SA-10 "Grumble" S-300 Complex Spawn', A_def, grumble_spawn_a)
missionCommands.addCommandForCoalition(BLUE, 'SA-11 "Gadfly" Buk Complex Spawn', A_def, gadfly_spawn_a)
missionCommands.addCommandForCoalition(BLUE, 'SA-3 "Goa" S-125 Neva Spawn', A_def, goa_spawn_a)
missionCommands.addCommandForCoalition(BLUE, 'SA-19 "Grison" 2K22 Tunguska Spawn', A_def, grison_spawn_a)
--[[
missionCommands.addCommandForCoalition(BLUE, 'SA-10 "Grumble" S-300 Complex Spawn', B_def, grumble_spawn_b)
missionCommands.addCommandForCoalition(BLUE, 'SA-11 "Gadfly" Buk Complex Spawn', B_def, gadfly_spawn_b)
missionCommands.addCommandForCoalition(BLUE, 'SA-3 "Goa" S-125 Neva Spawn', B_def, goa_spawn_b)
missionCommands.addCommandForCoalition(BLUE, 'SA-19 "Grison" 2K22 Tunguska Spawn', B_def, grison_spawn_b)

missionCommands.addCommandForCoalition(BLUE, 'SA-10 "Grumble" S-300 Complex Spawn', C_def, grumble_spawn_c)
missionCommands.addCommandForCoalition(BLUE, 'SA-11 "Gadfly" Buk Complex Spawn', C_def, gadfly_spawn_c)
missionCommands.addCommandForCoalition(BLUE, 'SA-3 "Goa" S-125 Neva Spawn', C_def, goa_spawn_c)
missionCommands.addCommandForCoalition(BLUE, 'SA-19 "Grison" 2K22 Tunguska Spawn', C_def, grison_spawn_c)
]]--
missionCommands.addCommandForCoalition(BLUE, 'EWR Complex Spawn', defenseCmds, ewr_spawn)