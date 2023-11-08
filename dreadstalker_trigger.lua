--[[ events: CLEU:SPELL_SUMMON:SPELL_CAST_SUCCESS ]]
function(allstates,event,_,subEvent,...)
  local _,_,caster,_,_,creatureName,_,_,_,_,pet = ...;
  local _,_,_,_,_,_,_,_,_,spell = ...;

  if subEvent == "SPELL_SUMMON" and pet == "Call Dreadstalkers" and caster == UnitName("player") then
    local _,petName = strsplit(" ",pet);

    aura_env.CreateStates(allstates,creatureName,petName);
    return true;
  end

  if subEvent == "SPELL_CAST_SUCCESS" and caster == UnitName("player") and spell == 265187 then
    aura_env.SetTime(allstates);
    return true;
  end
end