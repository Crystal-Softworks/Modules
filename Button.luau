local Button = {}
Button.__index = Button

local Stellar = shared.Stellar

local Players = game:GetService("Players")

local Signal = loadstring(game:HttpGet("https://raw.githubusercontent.com/Crystal-Softworks/Modules/refs/heads/main/Signal.luau))()
local Maid = loadstring(game:HttpGet("https://raw.githubusercontent.com/Crystal-Softworks/Modules/refs/heads/main/Maid.luau"))()
local SoundFX = Stellar.Get("SoundFX")

function Button.new(Instance, UseClickEffect, CallbackDelay, DisableHoverSound)

	local IsBusy = false

	local IsValid = Instance:IsA("ImageButton") or Instance:IsA("TextButton")

	local ClassName = Instance.ClassName

	assert(IsValid, ("[Button] Instance passed must be a button, a '%s' was passed."):format(ClassName))

	local Self = {
		Instance = Instance,
		OriginalSize = Instance.Size,
		CallbackDelay = CallbackDelay or 0,
		Active = true,
		Maid = Maid.new(),
		Callbacks = {
			Clicks = {},
			MouseEnters = {},
			MouseLeaves = {}
		}
	}

	setmetatable(Self, Button)

	Self.Clicked = Signal.new("ButtonClicked")

	local function HandleClick()

		if not Self.Active then
			return
		end

		Self.Clicked:Fire()

		if Players.LocalPlayer:GetAttribute("DeathScreen") then
			return
		end

		if IsBusy then
			return
		end

		IsBusy = true

		if UseClickEffect then
			Self:ClickEffect()
		end

		SoundFX:Play("ButtonClick", nil, nil, nil, true)

		task.delay(CallbackDelay, function()

			for _, Callback in Self.Callbacks.Clicks do

				local Success, Error = pcall(Callback)

				if not Success and Error then
					warn(("[Button] Callback failed for button " .. Self.Instance.Name .. " with error:\n%s"):format(Error))
				end

			end

		end)

		task.wait(0.4)

		IsBusy = false

	end

	Self.Maid:GiveTask(Instance.MouseButton1Down:Connect(HandleClick))

	Self.Maid:GiveTask(Instance.MouseEnter:Connect(function()

		if not Self.Active then
			return
		end

		if not DisableHoverSound then

			SoundFX:Play("Hover")

			for _, Callback in Self.Callbacks.MouseEnters do

				local Success, Error = pcall(Callback)

				if not Success then
					warn("[Button Fail]", Error)
				end

			end

		end

	end))

	Self.Maid:GiveTask(Instance.MouseLeave:Connect(function()

		for _, Callback in Self.Callbacks.MouseLeaves do

			local Success, Error = pcall(Callback)

			if not Success then
				warn("[Button Fail]", Error)
			end

		end

	end))

	return Self

end

function Button:ClickEffect()

	self.Instance:TweenSize(
		UDim2.fromScale(
			self.OriginalSize.X.Scale / 1.8,
			self.OriginalSize.Y.Scale / 1.8
		),
		"Out",
		"Quad",
		0.15
	)

	task.delay(0.25, function()

		if self.Instance and self.Instance.Parent then
			self.Instance:TweenSize(self.OriginalSize, "Out", "Quad", 0.15)
		end

	end)

end

function Button:OnClick(Callback)

	table.insert(self.Callbacks.Clicks, Callback)

end

function Button:MouseHovered(Callback)

	table.insert(self.Callbacks.MouseEnters, Callback)

end

function Button:MouseLeft(Callback)

	table.insert(self.Callbacks.MouseLeaves, Callback)

end

function Button:WaitClick()

	self.Clicked:Wait()

end

function Button:SetActive(State)

	self.Active = State

end

function Button:Destroy()

	if self and self.Maid then

		self.Maid:DoCleaning()

		self.Callbacks = {}

	end

end

return Button
