--- Calculates point values based on kill
--[[
Author: *HIDDEN*
Date: 12/29/2023
Version 1.3
    1.1 -> removed friendly fire to do 'nil' returning sometimes
        1.1.1 -> fixed friendly fire issue
        1.1.2 -> fixed awacs values and team kills
    1.2 -> coded ground units and player crashes, ejections, and leaving units
	1.3 -> added code for weapon on weapon kills
]]--
--- getDesc().category
local AIRPLANE = 0
local HELICOPTER = 1
local GROUND_UNIT = 2
local SHIP = 3

--- getCoalition()
local RED = 1
local BLUE = 2

--- VP Values
local awacs_vp = 250
local fixed_wing_vp = 100
local rotor_vp = 50
local ai_aircraft_vp = 50
local sam_vp = 20
local spaag_vp = 15
local ground_vp = 10
local cap_vp = 10

--- BOND Values
local awacs_bond = 200
local aircraft_bond = 50
local sam_bond = 15
local cap_bond = 10
local ground_bond = 5


local killer = {}
local dead = {}
function killer:onEvent(event)
    local isPlayer = false
	local isWeapon = event.target:getDesc().category == 2
    if event.id == 28 and isWeapon == false then
        local killer_coalition = event.initiator:getCoalition()
        local dead_category = event.target:getDesc().category
        local dead_coalition = event.target:getCoalition()
        if event.target:getPlayerName() ~= nil then
            isPlayer = true
        end
        -- WHEN FRIENDLY FIRE OCCURS
        if killer_coalition == dead_coalition then
            if killer_coalition == RED then
                if dead_category == AIRPLANE then
                    if isPlayer then
                        setRedVP(red_vp - fixed_wing_vp)
                        setBlueBonds(blue_bonds + aircraft_bond)
                    elseif event.target:hasAttribute('AWACS') then
                        setRedVP(red_vp - awacs_vp)
                        setBlueBonds(blue_bonds + awacs_bond)
                    else
                        setRedVP(red_vp - ai_aircraft_vp)
                        setBlueBonds(blue_bonds + aircraft_bond)
                    end
                elseif dead_category == HELICOPTER then
                    setRedVP(red_vp - rotor_vp)
                    setBlueBonds(blue_bonds + aircraft_bond)
                elseif dead_category == GROUND_UNIT then
                    if event.target:hasAttribute('SAM elements') then
                        setRedVP(red_vp - sam_vp)
                        setBlueBonds(blue_bonds + sam_bond)
                    elseif event.target:hasAttribute('Static AAA') then
                        setRedVP(red_vp - spaag_vp)
                        setBlueBonds(blue_bonds + ground_bond)
                    elseif event.initiator:hasAttribute('Infantry') == false then
                        setRedVP(red_vp - ground_vp)
                        setBlueBonds(blue_bonds + ground_bond)
                    end
                end
            elseif killer_coalition == BLUE then
                if dead_category == AIRPLANE then
                    if isPlayer then
                        setBlueVP(blue_vp - fixed_wing_vp)
                        setRedBonds(red_bonds + aircraft_bond)
                    elseif event.target:hasAttribute('AWACS') then
                        setBlueVP(blue_vp - awacs_vp)
                        setRedBonds(red_bonds + awacs_bond)
                    else
                        setBlueVP(blue_vp - ai_aircraft_vp)
                        setRedBonds(red_bonds + aircraft_bond)
                    end
                elseif dead_category == HELICOPTER then
                    setBlueVP(blue_vp - rotor_vp)
                    setRedBonds(red_bonds + aircraft_bond)
                elseif dead_category == GROUND_UNIT then
                    if event.target:hasAttribute('SAM elements') then
                        setBlueVP(blue_vp - sam_vp)
                        setRedBonds(red_bonds + sam_bond)
                    elseif event.target:hasAttribute('Static AAA') then
                        setBlueVP(blue_vp - spaag_vp)
                        setRedBonds(red_bonds + ground_bond)
                    elseif event.initiator:hasAttribute('Infantry') == false then
                        setBlueVP(blue_vp - ground_vp)
                        setRedBonds(red_bonds + ground_bond)
                    end
                end
            end
        end
        -- WHEN A REGULAR KILLS OCCURS
        if killer_coalition ~= dead_coalition then
            if killer_coalition == BLUE then
                if dead_category == AIRPLANE then
                    if isPlayer then
                        setRedVP(red_vp - fixed_wing_vp)
                        setBlueBonds(blue_bonds + aircraft_bond)
                    elseif event.target:hasAttribute('AWACS') then
                        setRedVP(red_vp - awacs_vp)
                        setBlueBonds(blue_bonds + awacs_bond)
                    else
                        setRedVP(red_vp - ai_aircraft_vp)
                        setBlueBonds(blue_bonds + aircraft_bond)
                    end
                elseif dead_category == HELICOPTER then
                    setRedVP(red_vp - rotor_vp)
                    setBlueBonds(blue_bonds + aircraft_bond)
                elseif dead_category == GROUND_UNIT then
                    if event.target:hasAttribute('SAM elements') then
                        setRedVP(red_vp - sam_vp)
                        setBlueBonds(blue_bonds + sam_bond)
                    elseif event.target:hasAttribute('Static AAA') then
                        setRedVP(red_vp - spaag_vp)
                        setBlueBonds(blue_bonds + ground_bond)
                    elseif event.initiator:hasAttribute('Infantry') == false then
                        setRedVP(red_vp - ground_vp)
                        setBlueBonds(blue_bonds + ground_bond)
                    end
                end
            elseif killer_coalition == RED then
                if dead_category == AIRPLANE then
                    if isPlayer then
                        setBlueVP(blue_vp - fixed_wing_vp)
                        setRedBonds(red_bonds + aircraft_bond)
                    elseif event.target:hasAttribute('AWACS') then
                        setBlueVP(blue_vp - awacs_vp)
                        setRedBonds(red_bonds + awacs_bond)
                    else
                        setBlueVP(blue_vp - ai_aircraft_vp)
                        setRedBonds(red_bonds + aircraft_bond)
                    end
                elseif dead_category == HELICOPTER then
                    setBlueVP(blue_vp - rotor_vp)
                    setRedBonds(red_bonds + aircraft_bond)
                elseif dead_category == GROUND_UNIT then
                    if event.target:hasAttribute('SAM elements') then
                        setBlueVP(blue_vp - sam_vp)
                        setRedBonds(red_bonds + sam_bond)
                    elseif event.target:hasAttribute('Static AAA') then
                        setBlueVP(blue_vp - spaag_vp)
                        setRedBonds(red_bonds + ground_bond)
                    elseif event.initiator:hasAttribute('Infantry') == false then
                        setBlueVP(blue_vp - ground_vp)
                        setRedBonds(red_bonds + ground_bond)
                    end
                end
            end
        end
    end
end
function dead:onEvent(event)
    if event.id == 5 then -- WHEN SOMEONE CRASHES FROM A UNIT AFTER LOADING
        if event.initiator:getPlayerName() ~= nil then
            local dead_category = event.initiator:getDesc().category
            local dead_coalition = event.initiator:getCoalition()
            if dead_coalition == RED then
                if dead_category == AIRPLANE then
                    setRedVP(red_vp - fixed_wing_vp)
                    setBlueBonds(blue_bonds + aircraft_bond)
                elseif dead_category == HELICOPTER then
                    setRedVP(red_vp - rotor_vp)
                    setBlueBonds(blue_bonds + aircraft_bond)
                end
            elseif dead_coalition == BLUE then
                if dead_category == AIRPLANE then
                    setBlueVP(blue_vp - fixed_wing_vp)
                    setRedBonds(red_bonds + aircraft_bond)
                elseif dead_category == HELICOPTER then
                    setBlueVP(blue_vp - rotor_vp)
                    setRedBonds(red_bonds + aircraft_bond)
                end
            end
        end
    elseif event.id == 21 then -- WHEN SOMEONE LEAVES A UNIT AFTER LOADING (includes EJECTING)
        local dead_category = event.initiator:getDesc().category
        local dead_coalition = event.initiator:getCoalition()
        if dead_coalition == RED then
            if dead_category == AIRPLANE then
                setRedVP(red_vp - fixed_wing_vp/2)
                setBlueBonds(blue_bonds + aircraft_bond/2)
            elseif dead_category == HELICOPTER then
                setRedVP(red_vp - rotor_vp/2)
                setBlueBonds(blue_bonds + aircraft_bond/2)
            end
        elseif dead_coalition == BLUE then
            if dead_category == AIRPLANE then
                setBlueVP(blue_vp - fixed_wing_vp/2)
                setRedBonds(red_bonds + aircraft_bond/2)
            elseif dead_category == HELICOPTER then
                setBlueVP(blue_vp - rotor_vp/2)
                setRedBonds(red_bonds + aircraft_bond/2)
            end
        end
    end
end
world.addEventHandler(dead)
world.addEventHandler(killer)