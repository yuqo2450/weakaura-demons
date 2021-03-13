-- Trigger for Dreadstallkers

function(allstates,event,_,subEvent,...)

    local _,_,caster,_,_,creatureName,_,_,_,_,pet = ...;

    if subEvent == "SPELL_SUMMON" and pet == "Call Dreadstalkers" and caster == UnitName("player") then

        local _,petName = strsplit(" ",pet)
        
        --Create new entry in the allstates table
        allstates[creatureName] = {
            
            show = true,
            changed = true,
            progressType = "timed",
            icon = 1378282,
            duration = 12,
            expirationTime = GetTime() + 12,
            autoHide = true,
            name = petName,
        }
        return true;
    end

    local _,_,_,_,_,_,_,_,_,spell = ...;

    --Check if Demonic Tyrant was summoned
    if subEvent == "SPELL_CAST_SUCCESS" and caster == UnitName("player") and spell == 265187 then

        for _,state in pairs(allstates) do
            
            --Increase duration of all dread stalkers by 15 seconds
            state.expirationTime = state.expirationTime + 15;
            state.changed = true;
        end
        
        return true;
    end
end