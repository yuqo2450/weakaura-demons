aura_env.lastTyrant = GetTime();
aura_env.castTyrant = false;

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
  allstates[imp].value = allstates[imp].value - 20;
  allstates[imp].changed = true;

  if allstates[imp].value <= 0 then
    allstates[imp].show = false;
    allstates[imp].changed = true;
  end
  return true;
end

function aura_env.ClearImps(allstates)
  for imp,state in pairs(allstates) do
    state.show = false;
    state.changed = true;
  end
  return true;
end

function aura_env.TyrantSummoned(allstates)
  local seconds

  if aura_env.tyrantCast then
    seconds = 15;
    aura_env.tyrantCast = false;
  else
    seconds = 5.25;
  end

  if aura_env.lastTyrant < GetTime() + seconds then
    aura_env.lastTyrant = GetTime() + seconds;
  end
  aura_env.ExtendImpDuartion(allstates,seconds);

  return true;
end

function aura_env.GetTyrantActive(allstates)
  if aura_env.lastTyrant and (aura_env.lastTyrant >= GetTime()) then
    for _,state in pairs(allstates) do
      state.tyrantActive = true;
    end
    return true;
  else
    for _,state in pairs(allstates) do
      state.tyrantActive = false;
    end
    return false;
  end
end

function aura_env.ExtendImpDuartion(allstates,seconds)
  for _,state in pairs(allstates) do
    state.expirationTime = state.expirationTime + seconds;
    state.tyrantActive = true;
    state.changed = true;
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
