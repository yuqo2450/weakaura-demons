--[[ events: CLEU:SPELL_SUMMON:SPELL_CAST_SUCCESS ]]
function(allstates,event,_,subEvent,...)

  local _,_,caster,_,_,creatureName,_,_,_,_,pet = ...;
  local _,_,_,_,_,_,_,_,_,spell = ...;

  if subEvent == "SPELL_SUMMON" and pet == "Call Dreadstalkers" and caster == UnitName("player") then
    local _,petName = strsplit(" ",pet)

    allstates[creatureName] = {
      show = true,
      changed = true,
      progressType = "timed",
      icon = 1378282,
      duration = 12,
      expirationTime = GetTime() + 12,
      autoHide = true,
      name = petName,
    }
    return true;
  end

  if subEvent == "SPELL_CAST_SUCCESS" and caster == UnitName("player") and spell == 265187 then
    for _,state in pairs(allstates) do
      state.expirationTime = state.expirationTime + 15;
      state.changed = true;
    end
    return true;
  end
end