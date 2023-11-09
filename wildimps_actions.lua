function aura_env.AddImp(allstates,imp,demon)
  local duration = 21.5;
  local expTime = GetTime() + duration;
  local power = 120;

  allstates[imp] = {
    show = true,
    progressType = UnitAffectingCombat("player") and "static" or "timed",
    icon = 460856,
    total = power,
    value = power,
    name = demon,
    duration = duration,
    expirationTime = expTime,
    autoHide = true,
  }

  return true;
end

function aura_env.SetImpValue(allstates,imp)
  if not aura_env.GetTyrantActive() then
    allstates[imp].energyFrozen = false;
  end
  if allstates[imp].energyFrozen then
    return false;
  end

  allstates[imp].value = allstates[imp].value - 20;
  if allstates[imp].value <= 0 then
    allstates[imp].show = false;
  end
  allstates[imp].changed = true;
  return true;
end

function aura_env.ClearImps(allstates)
  for imp,state in pairs(allstates) do
    state.show = false;
    state.changed = true;
  end
  return true;
end

function aura_env.GetTyrantActive()
  if aura_env.lastTyrant >= GetTime() then
    return true;
  else
    return false;
  end
end

function aura_env.SetLastTyrant(allstates)
  local seconds = 15;
  aura_env.lastTyrant = GetTime() + seconds;
  aura_env.ExtendImpDuartion(allstates, seconds)
end

function aura_env.ExtendImpDuartion(allstates,seconds)
  local impsExtended = 0;
  for _,state in pairs(allstates) do
    state.expirationTime = state.expirationTime + seconds;
    state.energyFrozen = true;
    state.changed = true;
    impsExtended = impsExtended + 1;
    if impsExtended == 10 then
      break;
    end
  end
end

function aura_env.ClearExpImps(allstates)
  for imp,state in pairs(allstates) do
    if state.expirationTime <= GetTime() then
      state.show = false;
      state.changed = true;
    end
  end
  return true;
end

function aura_env.SetProgressType(allstates)
  for imp,state in pairs(allstates) do
    state.progressType = UnitAffectingCombat("player") and "static" or "timed";
    state.changed = true;
  end
end

function aura_env.SetImpType(allstates, imp, demon)
  allstates[imp].name = demon;
  allstates[imp].icon = 615097;
  allstates[imp].changed = true;
end

function aura_env.SetBarColor()
  local color = aura_env.config.colorWildImp;

  if aura_env.state.icon == 615097 then
    color = aura_env.config.colorImpGangBoss;
  end

  return color[1],color[2],color[3],color[4];
end
