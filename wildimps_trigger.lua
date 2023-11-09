--[[ events: CLEU:SPELL_SUMMON:SPELL_CAST_SUCCESS:SPELL_AURA_APPLIED,FRAME_UPDATE ]]
function(allstates,event,time,subEvent,...)
  local guid = select(2,...);
  local spell = select(10,...);
  aura_env.GetTyrantActive(allstates);

  if next(allstates) then
    aura_env.RemoveExpImps(allstates);
    aura_env.SetProgressType(allstates);
  end

  if subEvent == "SPELL_SUMMON" and guid == UnitGUID("player") then
    local imp = select(6,...);
    local demon = select(7,...);

    if demon == "Wild Imp" then
      aura_env.AddImp(allstates,imp,demon);
    elseif demon == "Demonic Tyrant" then
      aura_env.TyrantSummoned(allstates);
    else
      return false;
    end
  elseif subEvent == "SPELL_CAST_SUCCESS" then
    if spell == 104318 and allstates[guid] ~= nil then
        aura_env.GetImpValue(allstates,guid);
    elseif spell == 196277 and guid == UnitGUID("player") then
      aura_env.ClearImps(allstates);
    elseif spell == 265187 and guid == UnitGUID("player") then
      aura_env.tyrantCast = true;
    else
      return false;
    end
  elseif subEvent == "SPELL_AURA_APPLIED" then
    local imp = select(6,...);
    local demon = select(11,...);
    if spell == 387458 and allstates[imp] ~= nil then
      aura_env.SetImpType(allstates, imp, demon)
    end
  end
  return true;
end
