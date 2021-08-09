aura_env.lastTyrant = GetTime();

function aura_env.AddImp(allstates,petSumd,petType)

    local expTime;
    
    if aura_env.lastTyrant > GetTime() then
        expTime = aura_env.lastTyrant + 41;
    else
        expTime = GetTime() + 41;
    end
    
    --Create new entry in the allstates table
    allstates[petSumd] = {
        show = true,
        progressType = "static",
        icon = 460856,
        tyrantActive = aura_env.lastTyrant > GetTime() and true or false,
        total = 100,
        value = 100,
        name = petType,
        duration = expTime - GetTime(),
        expirationTime = expTime,
    }
    
    return true;
end

function aura_env.GetImpValue(allstates,caster)

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

function aura_env.ClearImps(allstates)

    for imp,state in pairs(allstates) do
        --Remove all acitve imps if implosion is cast
        state.show = false;
        state.changed = true;
        imp = nil;
    end
    return true;
end

function aura_env.TyrantSummoned(allstates,subEvent,seconds)

    if subEvent == "SPELL_CAST_SUCCESS" then

        local _,_,_,_,talentSelected = 4, GetTalentInfo(7, 2, 1);        
        aura_env.lastTyrant = GetTime() + seconds;
        --Check for Demonic Comsumption
        if talentSelected then
            aura_env.ClearImps(allstates);
        end        

    else

        if aura_env.lastTyrant < GetTime() + seconds then
            aura_env.lastTyrant = GetTime() + seconds;
        end
        aura_env.ExtendImpDuartion(allstates,seconds);

    end
    return true;
end

function aura_env.GetTyrantActive(allstates)

    --check if Tyrant still active
    if aura_env.lastTyrant and (aura_env.lastTyrant >= GetTime()) then
        for _,state in pairs(allstates) do
            --If tyrant is active all other added imps will not behave normal
            state.tyrantActive = true;
        end
    else
        for _,state in pairs(allstates) do
            --If tyrant is not active anymore imps will return to normal behaviour
            state.tyrantActive = false;
        end
    end
end

function aura_env.ExtendImpDuartion(allstates,seconds)

    for _,state in pairs(allstates) do
        --Increase duration of all imps by seconds
        state.expirationTime = state.expirationTime + seconds;
        --Casting tyrant will stop normal imp behaviour. Power value won't drop per firebolt cast
        state.tyrantActive = true;
        state.changed = true;
    end
end