--[[
    Project: Fisch Hub (GitHub Raw Version)
    Author: MrDon
]]

if not game:IsLoaded() then game.Loaded:Wait() end

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

getgenv().FischHub = getgenv().FischHub or {
    AutoFish = false,
    InstantCatch = false,
    Fly = false,
    FlySpeed = 50
}
local Config = getgenv().FischHub

-- Clean up existing UI safely
pcall(function()
    if LocalPlayer.PlayerGui:FindFirstChild("FischHubUI") then
        LocalPlayer.PlayerGui.FischHubUI:Destroy()
    end
    if LocalPlayer.PlayerGui:FindFirstChild("FischHubToggle") then
        LocalPlayer.PlayerGui.FischHubToggle:Destroy()
    end
end)

-- Floating Toggle Button (Always visible on mobile screen)
local ToggleGui = Instance.new("ScreenGui")
ToggleGui.Name = "FischHubToggle"
ToggleGui.ResetOnSpawn = false
ToggleGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ToggleGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local OpenCloseBtn = Instance.new("TextButton")
OpenCloseBtn.Size = UDim2.new(0, 55, 0, 55)
OpenCloseBtn.Position = UDim2.new(0, 15, 0.35, 0)
OpenCloseBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
OpenCloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
OpenCloseBtn.TextSize = 13
OpenCloseBtn.Font = Enum.Font.SourceSansBold
OpenCloseBtn.Text = "FISCH"
OpenCloseBtn.Parent = ToggleGui

local ToggleCorner = Instance.new("UICorner", OpenCloseBtn)
ToggleCorner.CornerRadius = UDim.new(1, 0)

-- Main Menu UI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FischHubUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = LocalPlayer.PlayerGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 320, 0, 440)
MainFrame.Position = UDim2.new(0.5, -160, 0.5, -220)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 25, 35)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner", MainFrame)
MainCorner.CornerRadius = UDim.new(0, 8)

OpenCloseBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 45)
Title.BackgroundColor3 = Color3.fromRGB(15, 20, 28)
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16
Title.Font = Enum.Font.SourceSansBold
Title.Text = "Fisch Hub - Mobile"
Title.Parent = MainFrame

local TitleCorner = Instance.new("UICorner", Title)
TitleCorner.CornerRadius = UDim.new(0, 8)

local ScrollingFrame = Instance.new("ScrollingFrame")
ScrollingFrame.Size = UDim2.new(1, 0, 1, -45)
ScrollingFrame.Position = UDim2.new(0, 0, 0, 45)
ScrollingFrame.BackgroundTransparency = 1
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 600)
ScrollingFrame.Parent = MainFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 8)
UIListLayout.Parent = ScrollingFrame

local function createButton(name, color, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 280, 0, 38)
    btn.BackgroundColor3 = color
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 14
    btn.Font = Enum.Font.SourceSansBold
    btn.Text = name
    btn.Parent = ScrollingFrame
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    btn.MouseButton1Click:Connect(callback)
end

local function createToggle(name, configKey)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 280, 0, 38)
    btn.BackgroundColor3 = Config[configKey] and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(45, 50, 60)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 14
    btn.Font = Enum.Font.SourceSansBold
    btn.Text = name .. (Config[configKey] and ": ON" or ": OFF")
    btn.Parent = ScrollingFrame
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    
    btn.MouseButton1Click:Connect(function()
        Config[configKey] = not Config[configKey]
        btn.BackgroundColor3 = Config[configKey] and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(45, 50, 60)
        btn.Text = name .. (Config[configKey] and ": ON" or ": OFF")
    end)
end

createToggle("Auto Fish", "AutoFish")
createToggle("Instant Catch", "InstantCatch")
createToggle("Fly", "Fly")

local header = Instance.new("TextLabel")
header.Size = UDim2.new(0, 280, 0, 30)
header.BackgroundTransparency = 1
header.TextColor3 = Color3.fromRGB(0, 170, 255)
header.TextSize = 15
header.Font = Enum.Font.SourceSansBold
header.Text = "--- Island Teleports ---"
header.Parent = ScrollingFrame

local islands = {
    ["Moosewood"] = Vector3.new(380, 133, 230),
    ["Roslit Bay"] = Vector3.new(1450, 135, 300),
    ["Sunstone Island"] = Vector3.new(-925, 135, -1125),
    ["Desolate Deep"] = Vector3.new(3150, -255, 3050),
    ["Keepers Isle"] = Vector3.new(1400, 150, -3800),
    ["Statue of Fisch"] = Vector3.new(42, 155, -2985)
}

for name, pos in pairs(islands) do
    createButton("TP: " .. name, Color3.fromRGB(50, 90, 140), function()
        pcall(function()
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                char.HumanoidRootPart.CFrame = CFrame.new(pos) + Vector3.new(0, 5, 0)
            end
        end)
    end)
end

-- Engine loops for Fly mechanics
local BV, BG
RunService.RenderStepped:Connect(function()
    pcall(function()
        local char = LocalPlayer.Character
        if not char then return end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        local hum = char:FindFirstChildOfClass("Humanoid")
        
        if Config.Fly and hrp and hum then
            hum.PlatformStand = true
            if not BV then
                BV = Instance.new("BodyVelocity", hrp)
                BV.MaxForce = Vector3.new(9e9, 9e9, 9e9)
            end
            if not BG then
                BG = Instance.new("BodyGyro", hrp)
                BG.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
            end
            BV.Velocity = Camera.CFrame.LookVector * Config.FlySpeed
            BG.CFrame = Camera.CFrame
        else
            if hum then hum.PlatformStand = false end
            if BV then BV:Destroy(); BV = nil end
            if BG then BG:Destroy(); BG = nil end
        end
    end)
end)