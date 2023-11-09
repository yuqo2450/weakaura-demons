--[[ events: PLAYER_ENTERING_WORLD,CLEU:SPELL_SUMMON:SPELL_CAST_SUCCESS:SPELL_AURA_APPLIED,FRAME_UPDATE ]]
function(allstates,event,time,subEvent,...)
  local guidCaster = select(2,...);
  local spell = select(10,...);

  if event == "PLAYER_ENTERING_WORLD" then
    aura_env.lastTyrant = GetTime();
    aura_env.tyrantSummoned = false;
    return false;
  end

  aura_env.GetTyrantActive();

  if next(allstates) then
    aura_env.ClearExpImps(allstates);
    aura_env.SetProgressType(allstates);
  end

  if subEvent == "SPELL_SUMMON" and guidCaster == UnitGUID("player") then
    local guidSummoned = select(6,...);
    local demon = select(7,...);

    if demon == "Wild Imp" then
      aura_env.AddImp(allstates,guidSummoned,demon);
    elseif demon == "Demonic Tyrant" then
      aura_env.tyrantSummoned = true;
      aura_env.TyrantSummoned(allstates);
    else
      return false;
    end
  elseif subEvent == "SPELL_CAST_SUCCESS" then
    if spell == 104318 and allstates[guidCaster] ~= nil then
        aura_env.SetImpValue(allstates,guidCaster);
    elseif spell == 196277 and guidCaster == UnitGUID("player") then
      aura_env.ClearImps(allstates);
    else
      return false;
    end
  elseif subEvent == "SPELL_AURA_APPLIED" then
    local guidApplied = select(6,...);
    local demon = select(11,...);
    if spell == 387458 and allstates[guidApplied] ~= nil then
      aura_env.SetImpType(allstates, guidApplied, demon);
    end
  end
  return true;
end
