--[[ events: CLEU:SPELL_SUMMON:SPELL_CAST_SUCCESS ]]
function(allstates,event,time,subEvent,...)
  local guidCaster = select(2,...);
  local creature = select(6,...);
  local pet = select(11,...);
  local spell = select(10,...);

  if guidCaster ~= UnitGUID("player") then
    return false;
  end

  if subEvent == "SPELL_SUMMON" and pet == "Call Dreadstalkers" then
    local _,petName = strsplit(" ",pet);

    aura_env.CreateStates(allstates,creature,petName);
    return true;
  end

  if subEvent == "SPELL_CAST_SUCCESS" and spell == 265187 then
    aura_env.UpdateOnTyrant(allstates);
    return true;
  end
end
