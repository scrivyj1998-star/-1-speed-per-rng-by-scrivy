local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer

local function getHRP()
	local character = player.Character or player.CharacterAdded:Wait()
	return character:WaitForChild("HumanoidRootPart")
end

-- GUI Setup
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ScrivyAutoFarm"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 220, 0, 200)
frame.Position = UDim2.new(0.5, -110, 0.55, -100)
frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui

-- Title
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -40, 0, 40)
title.Position = UDim2.new(0, 10, 0, 0)
title.Text = "Scrivys Auto Farm"
title.TextScaled = true
title.BackgroundTransparency = 1
title.TextColor3 = Color3.new(1,1,1)
title.Parent = frame

-- Close Button
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 5)
closeBtn.Text = "X"
closeBtn.TextScaled = true
closeBtn.BackgroundColor3 = Color3.fromRGB(170,0,0)
closeBtn.TextColor3 = Color3.new(1,1,1)
closeBtn.Parent = frame

-- TELEPORT DROPDOWN BUTTON
local openTeleportsBtn = Instance.new("TextButton")
openTeleportsBtn.Size = UDim2.new(1, -20, 0, 30)
openTeleportsBtn.Position = UDim2.new(0, 10, 0, 45)
openTeleportsBtn.Text = "Open Teleports ▼"
openTeleportsBtn.BackgroundColor3 = Color3.fromRGB(35,35,35)
openTeleportsBtn.TextColor3 = Color3.new(1,1,1)
openTeleportsBtn.Parent = frame

-- Dropdown Frame
local teleportFrame = Instance.new("Frame")
teleportFrame.Size = UDim2.new(1, -20, 0, 0)
teleportFrame.Position = UDim2.new(0, 10, 0, 80)
teleportFrame.BackgroundColor3 = Color3.fromRGB(30,30,30)
teleportFrame.ClipsDescendants = true
teleportFrame.Parent = frame

local layout = Instance.new("UIListLayout")
layout.Parent = teleportFrame
layout.Padding = UDim.new(0,5)

local dropdownOpen = false

local function makeTeleport(name, position)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(1, 0, 0, 30)
	btn.Text = name
	btn.BackgroundColor3 = Color3.fromRGB(45,45,45)
	btn.TextColor3 = Color3.new(1,1,1)
	btn.Parent = teleportFrame
	
	btn.MouseButton1Click:Connect(function()
		local hrp = getHRP()
		hrp.CFrame = CFrame.new(position)
	end)
end

-- YOUR TELEPORTS
makeTeleport("Farm Start", Vector3.new(551.34, 41.28, 3583.16))
makeTeleport("Tween End", Vector3.new(508.77, 42.28, 3579.88))
makeTeleport("Spawn", Vector3.new(0, 10, 0)) -- change if needed

openTeleportsBtn.MouseButton1Click:Connect(function()
	dropdownOpen = not dropdownOpen
	
	if dropdownOpen then
		openTeleportsBtn.Text = "Close Teleports ▲"
		local count = 0
		for _,v in pairs(teleportFrame:GetChildren()) do
			if v:IsA("TextButton") then
				count += 1
			end
		end
		teleportFrame:TweenSize(UDim2.new(1, -20, 0, count * 35), "Out", "Quad", 0.25, true)
	else
		openTeleportsBtn.Text = "Open Teleports ▼"
		teleportFrame:TweenSize(UDim2.new(1, -20, 0, 0), "Out", "Quad", 0.25, true)
	end
end)

-- Toggle Switch
local toggleBg = Instance.new("Frame")
toggleBg.Size = UDim2.new(0, 80, 0, 35)
toggleBg.Position = UDim2.new(0.5, -40, 1, -50)
toggleBg.BackgroundColor3 = Color3.fromRGB(170,0,0)
toggleBg.Parent = frame

local toggleCorner = Instance.new("UICorner", toggleBg)
toggleCorner.CornerRadius = UDim.new(1,0)

local toggleCircle = Instance.new("Frame")
toggleCircle.Size = UDim2.new(0, 30, 0, 30)
toggleCircle.Position = UDim2.new(0, 3, 0.5, -15)
toggleCircle.BackgroundColor3 = Color3.new(1,1,1)
toggleCircle.Parent = toggleBg

local circleCorner = Instance.new("UICorner", toggleCircle)
circleCorner.CornerRadius = UDim.new(1,0)

-- Confirmation Popup
local confirmFrame = Instance.new("Frame")
confirmFrame.Size = UDim2.new(0, 200, 0, 120)
confirmFrame.Position = UDim2.new(0.5, -100, 0.5, -60)
confirmFrame.BackgroundColor3 = Color3.fromRGB(40,40,40)
confirmFrame.Visible = false
confirmFrame.Parent = screenGui

local confirmText = Instance.new("TextLabel")
confirmText.Size = UDim2.new(1, -10, 0, 50)
confirmText.Position = UDim2.new(0, 5, 0, 10)
confirmText.Text = "Are you sure you want to close?"
confirmText.TextWrapped = true
confirmText.TextScaled = true
confirmText.BackgroundTransparency = 1
confirmText.TextColor3 = Color3.new(1,1,1)
confirmText.Parent = confirmFrame

local yesBtn = Instance.new("TextButton")
yesBtn.Size = UDim2.new(0.4, 0, 0, 35)
yesBtn.Position = UDim2.new(0.1, 0, 1, -45)
yesBtn.Text = "Confirm"
yesBtn.BackgroundColor3 = Color3.fromRGB(0,170,0)
yesBtn.TextColor3 = Color3.new(1,1,1)
yesBtn.Parent = confirmFrame

local noBtn = Instance.new("TextButton")
noBtn.Size = UDim2.new(0.4, 0, 0, 35)
noBtn.Position = UDim2.new(0.5, 0, 1, -45)
noBtn.Text = "Cancel"
noBtn.BackgroundColor3 = Color3.fromRGB(170,0,0)
noBtn.TextColor3 = Color3.new(1,1,1)
noBtn.Parent = confirmFrame

-- Auto Farm Logic
local toggled = false
local currentTween

local function autoLoop()
	while toggled do
		local hrp = getHRP()

		hrp.CFrame = CFrame.new(551.34, 41.28, 3583.16)

		task.wait(0.2)
		if not toggled then break end

		local goal = {CFrame = CFrame.new(508.77, 42.28, 3579.88)}
		local tweenInfo = TweenInfo.new(0.375, Enum.EasingStyle.Linear) -- 2x faster

		currentTween = TweenService:Create(hrp, tweenInfo, goal)
		currentTween:Play()
		currentTween.Completed:Wait()

		if not toggled then break end

		task.wait(1.3)
	end
end

toggleBg.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or
	   input.UserInputType == Enum.UserInputType.Touch then

		toggled = not toggled

		if toggled then
			toggleBg.BackgroundColor3 = Color3.fromRGB(0,170,0)
			toggleCircle:TweenPosition(UDim2.new(1, -33, 0.5, -15), "Out", "Quad", 0.2, true)
			task.spawn(autoLoop)
		else
			toggleBg.BackgroundColor3 = Color3.fromRGB(170,0,0)
			toggleCircle:TweenPosition(UDim2.new(0, 3, 0.5, -15), "Out", "Quad", 0.2, true)
			if currentTween then
				currentTween:Cancel()
			end
		end
	end
end)

closeBtn.MouseButton1Click:Connect(function()
	confirmFrame.Visible = true
end)

yesBtn.MouseButton1Click:Connect(function()
	screenGui:Destroy()
end)

noBtn.MouseButton1Click:Connect(function()
	confirmFrame.Visible = false
end)
