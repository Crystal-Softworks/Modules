local Control = {}
Control.__index = Control

local Stellar = shared.Stellar
local UI = Stellar.Get("UserInterface")
local KeyTranslations = Stellar.Get("KeyCodeTranslation")
local UserInput = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Maid = loadstring(game:HttpGet("https://raw.githubusercontent.com/cy5n03t2ct4y3jc0tn8y5/Modules/refs/heads/main/Maid.luau"))()
local Button = loadstring(game:HttpGet("https://raw.githubusercontent.com/cy5n03t2ct4y3jc0tn8y5/Modules/refs/heads/main/Button.luau"))()
local Signal = loadstring(game:HttpGet("https://raw.githubusercontent.com/cy5n03t2ct4y3jc0tn8y5/Modules/refs/heads/main/Signal.luau"))()

local Assets = game:GetService("ReplicatedStorage").Assets
local ControlsFrame = UI:GetFrame("HUD").Controls
local ControlTemplate = Assets.Control
local InputIcons = Assets.InputIcons

function Control:ConfigureIconScaling(isTouch)
	self.Icon.Position = UDim2.fromScale(0.511, 0.497)
	self.Icon.Size = UDim2.fromScale(0.768, 0.852)
	self.Icon.Visible = false
	self.Icon.ZIndex = 4

	Instance.new("UIAspectRatioConstraint").Parent = self.Icon

	task.delay(0.1, function()
		if not isTouch then
			self.Icon.Visible = true
		end
	end)
end

function Control:Trigger()
	if self.Icon then
		self.Icon:TweenSize(UDim2.fromScale(0.666, 0.738), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.1, true, function()
			self.Icon:TweenSize(UDim2.fromScale(0.768, 0.852), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.1)
		end)
	end

	if self.Cooldown then return end

	self.Triggered:Fire()

	if not self.CooldownTime then return end

	self.Cooldown = true
	task.wait(0.1)

	if not self.Icon then return end

	self.Icon.Visible = false
	self.Template.Cooldown.Visible = true
	self.Template.Line.Size = UDim2.fromScale(1, 1)
	self.Template.Line:TweenSize(UDim2.fromScale(0.082, 1), Enum.EasingDirection.In, Enum.EasingStyle.Linear, self.CooldownTime, true)

	local endTime = tick() + self.CooldownTime
	local connection

	connection = RunService.Heartbeat:Connect(function()
		if endTime < tick() then
			self.Cooldown = false
			self.Template.Cooldown.Visible = false
			if self.Icon then
				self.Icon.Visible = true
			end
			connection:Disconnect()
		end
		self.Template.Cooldown.Text = string.format("%.1f", endTime - tick())
	end)

	self._Maid:GiveTask(function()
		if connection and connection.Connected then
			connection:Disconnect()
		end
	end)
end

function Control.new(keyEnum, displayText, cooldownTime)
	assert(typeof(keyEnum) == "EnumItem", string.format("[Control] '%s' is not an Enum.", tostring(keyEnum)))

	local template = ControlTemplate:Clone()
	local self = setmetatable({
		Cooldown = false,
		_Maid = Maid.new(),
		Triggered = Signal.new("ControlTriggered"),
		Template = template,
		Button = Button.new(template.Click),
		CooldownTime = cooldownTime,
		Icon = nil,
	}, Control)

	self._Maid:GiveTask(self.Triggered)
	self._Maid:GiveTask(self.Button)

	local iconName = KeyTranslations[keyEnum]
	local iconAsset = iconName and InputIcons:FindFirstChild(iconName) or InputIcons:FindFirstChild(keyEnum.Name)

	if iconAsset then
		self.Icon = iconAsset:Clone()
		self:ConfigureIconScaling(false)
		self.Icon.Parent = self.Template
	end

	self.Template.MainFrame.Control.Text = displayText
	self.Template.MainFrame.Title.Text = keyEnum.Name
	self.Template.Parent = ControlsFrame
	self.Template.Visible = true

	self._Maid:GiveTask(UserInput.InputBegan:Connect(function(input, processed)
		if not processed and (input.KeyCode == keyEnum or input.UserInputType == keyEnum) then
			self:Trigger()
		end
	end))

	self.Button:OnClick(function() self:Trigger() end)

	self.Button:MouseHovered(function()
		if not self.Cooldown then
			self.Template.Line:TweenSize(UDim2.fromScale(1, 1), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.25, true)
		end
	end)

	self.Button:MouseLeft(function()
		if not self.Cooldown then
			self.Template.Line:TweenSize(UDim2.fromScale(0.082, 1), Enum.EasingDirection.In, Enum.EasingStyle.Quad, 0.25, true)
		end
	end)

	return self
end

function Control:Destroy()
	self._Maid:DoCleaning()
	self.Template:Destroy()
end

return Control
