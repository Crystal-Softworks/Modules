local Control = {}
Control.__index = Control

local Maid = loadstring(game:HttpGet("https://raw.githubusercontent.com/cy5n03t2ct4y3jc0tn8y5/Modules/refs/heads/main/Maid.luau"))()
local Signal = loadstring(game:HttpGet("https://raw.githubusercontent.com/cy5n03t2ct4y3jc0tn8y5/Modules/refs/heads/main/Signal.luau"))()
local UserInput = game:GetService("UserInputService")

--[=[
    A non‑visual input control with cooldown.

    Example:
        local myControl = Control.new(Enum.KeyCode.Q, 2.5)  -- 2.5 sec cooldown
        myControl.Triggered:Connect(function()
            print("Q pressed!")
        end)
]=]

--- Create a new Control
--- @param keyEnum Enum.KeyCode | Enum.UserInputType
--- @param cooldownTime number (seconds) – optional, 0 = no cooldown
--- @return Control
function Control.new(keyEnum, cooldownTime)
    assert(typeof(keyEnum) == "EnumItem", "Control.new: keyEnum must be an EnumItem")

    local self = setmetatable({
        _key = keyEnum,
        _cooldownTime = cooldownTime or 0,
        _onCooldown = false,
        _maid = Maid.new(),
        Triggered = Signal.new("ControlTriggered"),
    }, Control)

    self._maid:GiveTask(self.Triggered)

    self._maid:GiveTask(UserInput.InputBegan:Connect(function(input, processed)
        if processed then return end
        if input.KeyCode == self._key or input.UserInputType == self._key then
            self:Trigger()
        end
    end))

    return self
end

function Control:Trigger()
    if self._onCooldown then return end

    self.Triggered:Fire()

    if self._cooldownTime > 0 then
        self._onCooldown = true
        task.wait(self._cooldownTime)
        self._onCooldown = false
    end
end

function Control:Destroy()
    self._maid:DoCleaning()
end

return Control
