function(allstates,event,_,subEvent,...)

    aura_env.GetTyrantActive(allstates);

    if subEvent == "SPELL_SUMMON" then

        local _,_,playerName,_,_,petSumd,petType = ...;

        if petType == "Wild Imp" and playerName == UnitName("player") then

            aura_env.AddImp(allstates,petSumd,petType);

        elseif petType == "Demonic Tyrant" then
            
            aura_env.TyrantSummoned(allstates,subEvent,4);

        else
            return true;
        end
    end
        
    if subEvent == "SPELL_CAST_SUCCESS" then

        local _,caster,creature,_,_,_,_,_,_,spell = ...;

        if allstates[caster] and not allstates[caster].tyrantActive then
        
            aura_env.GetImpValue(allstates,caster);

        elseif creature == UnitName("player") and spell == 196277 then

            aura_env.ClearImps(allstates);

        elseif creature == UnitName("player") and spell == 265187 then

            aura_env.TyrantSummoned(allstates,subEvent,15)

        else
            return true;
        end
    end

    if next(allstates) then

        for imp,state in pairs(allstates) do
            if (state.expirationTime <= GetTime()) then

                state.show = false;
                state.changed = true;
                imp = nil;
             end
        end
    end
    return true;
end