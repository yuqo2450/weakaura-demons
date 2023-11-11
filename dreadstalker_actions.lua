function aura_env.CreateStates(allstates,creature,petName)
  allstates[creature] = {
    show = true,
    changed = true,
    progressType = "timed",
    icon = 1378282,
    duration = 12,
    expirationTime = GetTime() + 12,
    autoHide = true,
    name = petName,
  };
end

function aura_env.UpdateOnTyrant(allstates)
  for _,state in pairs(allstates) do
    state.expirationTime = state.expirationTime + 15;
    state.changed = true;
  end
end
