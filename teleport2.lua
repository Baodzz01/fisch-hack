--[[
    Project: Fisch Master Dropdown Teleporter Hub (Exact User-Provided Coordinates)
    Author: MrDon
]]

if not game:IsLoaded() then game.Loaded:Wait() end

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer

-- Clean up existing UI safely
pcall(function()
    if LocalPlayer.PlayerGui:FindFirstChild("FischAllDropdownUI") then
        LocalPlayer.PlayerGui.FischAllDropdownUI:Destroy()
    end
    if LocalPlayer.PlayerGui:FindFirstChild("FischAllDropdownToggle") then
        LocalPlayer.PlayerGui.FischAllDropdownToggle:Destroy()
    end
end)

-- Floating Toggle Button
local ToggleGui = Instance.new("ScreenGui")
ToggleGui.Name = "FischAllDropdownToggle"
ToggleGui.ResetOnSpawn = false
ToggleGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ToggleGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local OpenCloseBtn = Instance.new("TextButton")
OpenCloseBtn.Size = UDim2.new(0, 55, 0, 55)
OpenCloseBtn.Position = UDim2.new(0, 15, 0.5, 0)
OpenCloseBtn.BackgroundColor3 = Color3.fromRGB(0, 140, 255)
OpenCloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
OpenCloseBtn.TextSize = 12
OpenCloseBtn.Font = Enum.Font.SourceSansBold
OpenCloseBtn.Text = "SELECT"
OpenCloseBtn.Parent = ToggleGui

local ToggleCorner = Instance.new("UICorner", OpenCloseBtn)
ToggleCorner.CornerRadius = UDim.new(1, 0)

-- Main Menu UI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FischAllDropdownUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = LocalPlayer.PlayerGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 320, 0, 320)
MainFrame.Position = UDim2.new(0.5, -160, 0.5, -160)
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
Title.TextSize = 14
Title.Font = Enum.Font.SourceSansBold
Title.Text = "Fisch - Custom Cords Teleport"
Title.Parent = MainFrame

local TitleCorner = Instance.new("UICorner", Title)
TitleCorner.CornerRadius = UDim.new(0, 8)

-- Complete database using your exact requested coordinates (N/A filtered out to prevent errors)
local locations = {
    ["Ancient Isle"] = Vector3.new(5504, 143, -321),
    ["Atlantis"] = Vector3.new(-4300, -580, 1800),
    ["Boreal Pines"] = Vector3.new(21350, 150, 4400),
    ["Castaway Cliffs"] = Vector3.new(657, 134, -1623),
    ["Desolate Deep"] = Vector3.new(-791, 142, -3102),
    ["Everturn Forest"] = Vector3.new(2365, 130, -2330),
    ["Forsaken Shores"] = Vector3.new(-2645, 130, 1410),
    ["Grand Reef"] = Vector3.new(-3576, 151, 523),
    ["Lost Jungle"] = Vector3.new(-2710, 150, -2050),
    ["Moosewood"] = Vector3.new(370, 134, 223),
    ["Mushgrove Swamp"] = Vector3.new(2420, 135, -750),
    ["Northern Expedition"] = Vector3.new(-1750, 130, 3750),
    ["Ocean"] = Vector3.new(-1645, 125, 505),
    ["Roslit Bay"] = Vector3.new(-1600, 130, 500),
    ["Scoria Reach"] = Vector3.new(-4781, 138, -1378),
    ["Snowcap Island"] = Vector3.new(2595, 140, 2500),
    ["Statue of Sovereignty"] = Vector3.new(35, 135, -1010),
    ["Sunstone Island"] = Vector3.new(-1195, 123, -1220),
    ["Terrapin Island"] = Vector3.new(-95, 130, 1875),
    ["Vertigo"] = Vector3.new(-110, -515, 1040),
    ["Abyssal Zenith"] = Vector3.new(-13672.5, -11035.2, 352.8),
    ["Apollo’s Song of Light"] = Vector3.new(-8840, -2900, 501),
    ["Atlantean Storm"] = Vector3.new(-3662, 131, 670),
    ["Bellona’s Frenzy of War"] = Vector3.new(-8630, -2345, 625),
    ["Birch Cay"] = Vector3.new(1650, 130, -2350),
    ["Blue Moon Pool"] = Vector3.new(2710, 190, 2560),
    ["Brine Pool"] = Vector3.new(-1720, -175, -3115),
    ["Calm Zone"] = Vector3.new(-4309, -11216, 1936),
    ["Carrot Garden"] = Vector3.new(2674, 130, -641),
    ["Challenger’s Deep"] = Vector3.new(738.1, -3354.9, -1529),
    ["Coral Bastion"] = Vector3.new(2560, -1080, 740),
    ["Crimson Cavern"] = Vector3.new(-1071.9, -354.5, -4762.7),
    ["Crystal Cove"] = Vector3.new(1100, -700, 1400),
    ["Earmark Island"] = Vector3.new(1200, 130, 530),
    ["Haddock Rock"] = Vector3.new(-500, 125, -505),
    ["Hades’ Underworld of Indefinite"] = Vector3.new(-8570, -4242, 390),
    ["Harvesters Spike"] = Vector3.new(-1260, 135, 1550),
    ["The Arch"] = Vector3.new(1100, 130, -1250),
    ["The Depths"] = Vector3.new(-75, -530, 1285)
}

-- Sort location names alphabetically for easy selection
local locationNames = {}
for name, _ in pairs(locations) do
    table.insert(locationNames, name)
end
table.sort(locationNames)

local selectedLocation = locationNames[1]

-- Dropdown Main Box Button
local DropdownBtn = Instance.new("TextButton")
DropdownBtn.Size = UDim2.new(0, 280, 0, 45)
DropdownBtn.Position = UDim2.new(0.5, -140, 0, 65)
DropdownBtn.BackgroundColor3 = Color3.fromRGB(35, 42, 55)
DropdownBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
DropdownBtn.TextSize = 13
DropdownBtn.Font = Enum.Font.SourceSansBold
DropdownBtn.Text = "Selected: " .. selectedLocation
DropdownBtn.Parent = MainFrame
Instance.new("UICorner", DropdownBtn).CornerRadius = UDim.new(0, 6)

-- Dropdown Scrolling List Container (Initially Hidden)
local DropdownList = Instance.new("ScrollingFrame")
DropdownList.Size = UDim2.new(0, 280, 0, 140)
DropdownList.Position = UDim2.new(0.5, -140, 0, 115)
DropdownList.BackgroundColor3 = Color3.fromRGB(25, 30, 40)
DropdownList.BorderSizePixel = 0
DropdownList.Visible = false
DropdownList.CanvasSize = UDim2.new(0, 0, 0, #locationNames * 35)
DropdownList.Parent = MainFrame
Instance.new("UICorner", DropdownList).CornerRadius = UDim.new(0, 6)

local ListLayout = Instance.new("UIListLayout")
ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
ListLayout.Parent = DropdownList

-- Populate list items
for _, name in ipairs(locationNames) do
    local itemBtn = Instance.new("TextButton")
    itemBtn.Size = UDim2.new(1, 0, 0, 32)
    itemBtn.BackgroundTransparency = 1
    itemBtn.TextColor3 = Color3.fromRGB(200, 220, 255)
    itemBtn.TextSize = 13
    itemBtn.Font = Enum.Font.SourceSans
    itemBtn.Text = name
    itemBtn.Parent = DropdownList
    
    itemBtn.MouseButton1Click:Connect(function()
        selectedLocation = name
        DropdownBtn.Text = "Selected: " .. selectedLocation
        DropdownList.Visible = false
    end)
end

DropdownBtn.MouseButton1Click:Connect(function()
    DropdownList.Visible = not DropdownList.Visible
end)

-- Teleport Button
local TPBtn = Instance.new("TextButton")
TPBtn.Size = UDim2.new(0, 280, 0, 48)
TPBtn.Position = UDim2.new(0.5, -140, 0, 245)
TPBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
TPBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
TPBtn.TextSize = 16
TPBtn.Font = Enum.Font.SourceSansBold
TPBtn.Text = "TELEPORT"
TPBtn.Parent = MainFrame
Instance.new("UICorner", TPBtn).CornerRadius = UDim.new(0, 6)

TPBtn.MouseButton1Click:Connect(function()
    pcall(function()
        local pos = locations[selectedLocation]
        if pos then
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                char.HumanoidRootPart.CFrame = CFrame.new(pos) + Vector3.new(0, 5, 0)
            end
        end
    end)
end)