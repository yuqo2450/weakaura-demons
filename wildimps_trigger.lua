--[[ events: CLEU:SPELL_SUMMON:SPELL_CAST_SUCCESS:SPELL_AURA_APPLIED,FRAME_UPDATE ]]
function(allstates,event,time,subEvent,...)
  local unit = select(3,...);
  local spell = select(10,...);
  aura_env.GetTyrantActive(allstates);

  if next(allstates) then
    aura_env.RemoveExpImps(allstates);
    aura_env.SetProgressType(allstates);
  end

  if subEvent == "SPELL_SUMMON" and unit == UnitFullName("player").."-"..GetRealmName() then
    local creature = select(6,...);
    local petType = select(7,...);

    if petType == "Wild Imp" then
      aura_env.AddImp(allstates,creature,petType);
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
    if spell == 196277 and unit == UnitFullName("player").."-"..GetRealmName() then
      aura_env.ClearImps(allstates);
    elseif spell == 265187 and unit == UnitFullName("player").."-"..GetRealmName() then
      aura_env.tyrantCast = true;
    else
      return false;
    end
  end
  return true;
end
