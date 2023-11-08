--[[ events: CLEU:SPELL_SUMMON:SPELL_CAST_SUCCESS ]]
function(allstates,event,_,subEvent,...)
  local unit = select(3,...);
  local creature = select(4,...);
  local spell = select(10,...);
  aura_env.GetTyrantActive(allstates);

  if unit ~= UnitFullName("player").."-"..GetRealmName() then
    return false;
  end

  if subEvent == "SPELL_SUMMON" then
    local petSumd = select(6,...);
    local petType = select(7,...);

    if petType == "Wild Imp" then
      aura_env.AddImp(allstates,petSumd,petType);
    elseif petType == "Demonic Tyrant" then
      aura_env.TyrantSummoned(allstates);
    else
      return false;
    end
  end

  if subEvent == "SPELL_CAST_SUCCESS" then
    if allstates[unit] and not allstates[unit].tyrantActive then
      aura_env.GetImpValue(allstates,unit);
    end
    if spell == 196277 then
      aura_env.ClearImps(allstates);
    elseif spell == 265187 then
      aura_env.tyrantCast = true;
    else
      return false;
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