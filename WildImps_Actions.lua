aura_env.lastTyrant = GetTime();
aura_env.castTyrant = false;

function aura_env.AddImp(allstates,petSumd,petType)
  local expTime;

  if aura_env.lastTyrant > GetTime() then
    expTime = aura_env.lastTyrant + 41;
  else
    expTime = GetTime() + 41;
  end

  allstates[petSumd] = {
    show = true,
    progressType = "static",
    icon = 460856,
    tyrantActive = aura_env.lastTyrant > GetTime() and true or false,
    total = 100,
    value = 100,
    name = petType,
    duration = expTime - GetTime(),
      expirationTime = expTime,
  }

  return true;
end

function aura_env.GetImpValue(allstates,caster)
  allstates[caster].value = allstates[caster].value - 20;
  allstates[caster].changed = true;
  allstates[caster].casting = false;

  if allstates[caster].value <= 0 then
    allstates[caster].show = false;
    allstates[caster].changed = true;
    allstates[caster] = nil;
  end
  return true;
end

function aura_env.ClearImps(allstates)
  for imp,state in pairs(allstates) do
    state.show = false;
    state.changed = true;
    imp = nil;
  end
  return true;
end

function aura_env.TyrantSummoned(allstates)
  local seconds

  if aura_env.tyrantCast then
    seconds = 15;
    aura_env.tyrantCast = false;
  else
    seconds = 5,25;
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