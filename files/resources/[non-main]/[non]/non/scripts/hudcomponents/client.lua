function GameHudComp()
  local self = {}
  self.hideWheel = true

  self.enumCompId = {
    ['WANTED_STARS']= 1, ['WEAPON_ICON']= 2, ['CASH']= 3, ['MP_CASH']= 4,
    ['MP_MESSAGE']= 5, ['VEHICLE_NAME']= 6, ['AREA_NAME']= 7, ['VEHICLE_CLASS']= 8,
    ['STREET_NAME']= 9, ['HELP_TEXT']= 10, ['FLOATING_HELP_TEXT_1']= 11,
    ['FLOATING_HELP_TEXT_2']= 12, ['CASH_CHANGE']= 13, ['SUBTITLE_TEXT']= 15,
    ['RADIO_STATIONS']= 16, ['SAVING_GAME']= 17, ['GAME_STREAM']= 18,
    ['WEAPON_WHEEL']= 19, ['WEAPON_WHEEL_STATS']= 20, ['HUD_COMPONENTS']= 21,
    ['HUD_WEAPONS']= 22
  }

  -- ['RETICLE']= 14,

  self.EnableAll = function()
    for i = 1, 22 do
      ResetHudComponentValues(i)
    end
    -- if editRecticle then
    --   self.DisableOne('reticle')
    -- end
  end

  self.DisableAll = function()
    for i = 1, 22 do
      SetHudComponentPosition(i, -5.0, -5.0)
    end
    -- if editRecticle then
    --   self.EnableOne('reticle')
    -- end
  end

  self.EnableOne = function(id)
    id = type(id) == 'string' and self.enumCompId[id:upper()] or id
    ResetHudComponentValues(id)
  end

  self.DisableOne = function(id)
    id = type(id) == 'string' and self.enumCompId[id:upper()] or id
    SetHudComponentPosition(id, -5.0, -5.0)
  end

  self.ForceDisableWheel = function(state)
    if self.hideWheel == state then return end
    self.hideWheel = state
    if not state then return end
    CreateThread(function()
      while self.hideWheel do
        HudWeaponWheelIgnoreSelection()
        DisableControlAction(0, 37, true)
        Wait(2)
      end
    end)
  end

  return self
end

local HudComp = GameHudComp()

CreateThread(function()
  HudComp.DisableAll(false)
  for _, compId in ipairs({5, 10, 11, 12, 14, 15, 16, 19, 20, 21, 22}) do
    HudComp.EnableOne(compId)
  end
end)