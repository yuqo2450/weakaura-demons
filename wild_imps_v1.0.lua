-- Trigger for wild imps

function(allstates,event,_,subEvent,...)

    --check if Tyrant still active
    if aura_env.lastTyrant and (aura_env.lastTyrant >= GetTime()) then
        for imp,state in pairs(allstates) do
            --If tyrant is active all other added imps will not behave normal
            state.tyrantActive = true;
        end
    else
        for imp,state in pairs(allstates) do
            --If tyrant is not active anymore imps will return to normal behaviour
            state.tyrantActive = false;
        end
    end

    _,_,playerName,_,_,petSumd,_,_,_,_,pet = ...;
    
    if subEvent == "SPELL_SUMMON" and pet == "Wild Imp" and playerName == UnitName("player") then

        --Create new entry in the allstates table
        allstates[petSumd] = {
            
            show = true,
            progressType = "static",
            icon = 460856,
            total = 100,
            value = 100,
            name = pet,
            duration = 17,
            expirationTime = GetTime() + 17,
            tyrantActive = false,
        }
        return true;
    end
    
    --Change value if imp casts spell
    _,caster,creature,_,_,playerName = ...;

    if subEvent == "SPELL_CAST_SUCCESS" and allstates[caster] and not allstates[caster].tyrantActive then
        
        allstates[caster].value = allstates[caster].value - 20;
        allstates[caster].changed = true;

        --Remove table entry if value is 0
        if allstates[caster].value <= 0 then
            allstates[caster].show = false;
            allstates[caster].changed = true;
            allstates[caster] = nil;
        end
        return true;
    end

    --Check if implosion was cast
    _,_,_,_,_,_,_,_,_,spell = ...;

    if subEvent == "SPELL_CAST_SUCCESS" and creature == UnitName("player") and spell == 196277 then

        for imp,state in pairs(allstates) do
            --Remove all acitve imps if implosion is cast
            state.show = false;
            state.changed = true;
            imp = nil;
        end
        return true;
    end

    --Check if Demonic Tyrant was summoned
    if subEvent == "SPELL_CAST_SUCCESS" and creature == UnitName("player") and spell == 265187 then
        --Check for Demonic Comsumption
        if(select(4, GetTalentInfo(7, 2, 1))) then
            for imp,state in pairs(allstates) do
                state.show = false;
                state.changed = true;
                imp = nil;
            end
        else
            for imp,state in pairs(allstates) do
                --Increase duration of all imps by 15 seconds
                state.expirationTime = state.expirationTime + 15;
                --Casting tyrant will stop normal imp behaviour power value won't drop per firebolt cast
                state.tyrantActive = true;
                aura_env.lastTyrant = GetTime() + 15;
                state.changed = true;
            end
        end
        return true;
    end

    --Check if imps that didn't spent all their power are still
    if next(allstates) then

        for imp,state in pairs(allstates) do
            if (state.expirationTime <= GetTime()) then
                --Remove all expired frames
                state.show = false;
                state.changed = true;
                imp = nil; 
             end
        end
        return true;
    end
end