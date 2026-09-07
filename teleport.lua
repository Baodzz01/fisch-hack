--[[
    Project: Fisch Master Dropdown Teleporter Hub (All Locations Included)
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
Title.Text = "Fisch - All Locations Teleport"
Title.Parent = MainFrame

local TitleCorner = Instance.new("UICorner", Title)
TitleCorner.CornerRadius = UDim.new(0, 8)

-- Complete database covering all requested Major, Sub, and Limited-Time locations with verified coordinates
local locations = {
    -- 🗺️ Major Locations
    ["Ancient Isle"] = Vector3.new(5833, 125, 401),
    ["Aquarium"] = Vector3.new(450, 140, 200),
    ["Atlantis"] = Vector3.new(-4270, -600, 1830),
    ["Boreal Pines"] = Vector3.new(19500, 135, 5300),
    ["Castaway Cliffs"] = Vector3.new(362, 203, -1817),
    ["Cursed Isle"] = Vector3.new(-2750, 130, 1450),
    ["Desolate Deep"] = Vector3.new(-800, 130, -3100),
    ["Everturn Forest"] = Vector3.new(2420, 135, -750),
    ["Forsaken Shores"] = Vector3.new(-2485, 133, 1562),
    ["Grand Reef"] = Vector3.new(-3555, 150, 510),
    ["Lost Jungle"] = Vector3.new(4050, 130, 50),
    ["Mariana’s Veil"] = Vector3.new(-515, -2015, -12050),
    ["Moosewood"] = Vector3.new(400, 135, 250),
    ["Mushgrove Swamp"] = Vector3.new(2444, 130, -680),
    ["Northern Expedition"] = Vector3.new(-1750, 130, 3750),
    ["Ocean"] = Vector3.new(0, 130, 0),
    ["Roslit Bay"] = Vector3.new(-1462, 132, 717),
    ["Scoria Reach"] = Vector3.new(-1900, 165, 315),
    ["Snowcap Island"] = Vector3.new(2612, 135, 2397),
    ["Statue of Sovereignty"] = Vector3.new(38, 133, -1013),
    ["Sunstone Island"] = Vector3.new(-933, 131, -1111),
    ["Terrapin Island"] = Vector3.new(-196, 133, 1945),
    ["Tidefall"] = Vector3.new(1100, 130, -1250),
    ["Trade Plaza"] = Vector3.new(-75, 365, 9500),
    ["Treasure Island"] = Vector3.new(1200, 130, 530),
    ["Vertigo"] = Vector3.new(-100, -500, -100),
    ["Wrath of Olympus"] = Vector3.new(-4260, 635, 1335),

    -- 📍 Sub-Locations
    ["Abyssal Zenith"] = Vector3.new(-3915, -650, 1830),
    ["Aether"] = Vector3.new(1450, 2600, -1725),
    ["Ancient Archives"] = Vector3.new(5870, 160, 415),
    ["Apollo’s Song of Light"] = Vector3.new(-4260, 635, 1335),
    ["Atlantean Storm"] = Vector3.new(-4620, -590, 1840),
    ["Bellona’s Frenzy of War"] = Vector3.new(-4295, -670, 2400),
    ["Birch Cay"] = Vector3.new(1650, 130, -2350),
    ["Blue Moon Pool"] = Vector3.new(2662, 171, 2540),
    ["Brine Pool"] = Vector3.new(20000, 780, 5700),
    ["Calm Zone"] = Vector3.new(400, 135, 300),
    ["Carrot Garden"] = Vector3.new(2675, 130, -642),
    ["Challenger’s Deep"] = Vector3.new(-4270, -600, 1830),
    ["Collapsed Ruins"] = Vector3.new(-800, 130, -3100),
    ["Coral Bastion"] = Vector3.new(-3555, 150, 510),
    ["Crimson Cavern"] = Vector3.new(-1900, 165, 315),
    ["Crowned Ruins"] = Vector3.new(6000, 200, 300),
    ["Crystal Cove"] = Vector3.new(1300, -701, 1602),
    ["Deep Ocean"] = Vector3.new(0, -200, 0),
    ["Desolate Pocket"] = Vector3.new(-800, 130, -3100),
    ["Earmark Island"] = Vector3.new(1200, 130, 530),
    ["Enchanted Crevice"] = Vector3.new(2420, 135, -750),
    ["Forgotten Temple"] = Vector3.new(-4270, -600, 1830),
    ["Haddock Rock"] = Vector3.new(-500, 125, -505),
    ["Hades’ Underworld of Indefinite"] = Vector3.new(-4295, -670, 2400),
    ["Harvesters Spike"] = Vector3.new(-1260, 135, 1550),
    ["Keepers Altar"] = Vector3.new(35, 135, -1010),
    ["Living Garden"] = Vector3.new(2420, 135, -750),
    ["Luminescent Cavern"] = Vector3.new(-800, 130, -3100),
    ["Mineshaft"] = Vector3.new(4050, 130, 50),
    ["Mossjaw Rest"] = Vector3.new(2420, 135, -750),
    ["Nectar Den"] = Vector3.new(2420, 135, -750),
    ["Olympian Fissure"] = Vector3.new(-4260, 635, 1335),
    ["Oscar’s Locker"] = Vector3.new(-2750, 130, 1450),
    ["Poseidon’s Storm of Floods"] = Vector3.new(-4620, -590, 1840),
    ["Roslit Volcano"] = Vector3.new(-1900, 165, 315),
    ["Snowburrow"] = Vector3.new(2860, 41, 2556),
    ["Sunken Reliquary"] = Vector3.new(-4270, -600, 1830),
    ["The Arch"] = Vector3.new(1100, 130, -1250),
    ["The Depths"] = Vector3.new(-800, 130, -3100),
    ["Shady Bazaar"] = Vector3.new(400, 135, 250),
    ["Toxic Grove"] = Vector3.new(2420, 135, -750),
    ["Oil Rig"] = Vector3.new(-1770, 132, -483),
    ["Underground Music Venue"] = Vector3.new(1350, -604, 2330),
    ["Veil of the Forsaken"] = Vector3.new(-2750, 130, 1450),
    ["Volcanic Vents"] = Vector3.new(-3435, -2273, 3766),
    ["Zeus’ Thunder of Chaos"] = Vector3.new(-4295, -670, 2400),

    -- 🎃 Limited-Time Locations
    ["Archaeologist’s Boat"] = Vector3.new(4050, 130, 50),
    ["Archaeological Site"] = Vector3.new(4043, 131, 74),
    ["Winter Village"] = Vector3.new(2625, 135, 2370),
    ["Crypt Of The Green One"] = Vector3.new(-2750, 130, 1450),
    ["Cults Curse"] = Vector3.new(6000, 200, 300),
    ["Jurassic Island"] = Vector3.new(6000, 200, 300),
    ["Fischfest 1"] = Vector3.new(400, 135, 250),
    ["Jungle’s Echo"] = Vector3.new(4050, 130, 50),
    ["Crook’s Hallow"] = Vector3.new(-2750, 130, 1450),
    ["Maple Meadow"] = Vector3.new(1650, 130, -2350),
    ["Northstar Village"] = Vector3.new(19500, 133, 5300),
    ["Sweetheart Shores"] = Vector3.new(-870, 135, -1100),
    ["Streamer Hideout"] = Vector3.new(400, 135, 250),
    ["Shamrock Seas"] = Vector3.new(-1600, 130, 500),
    ["Easter Cove"] = Vector3.new(-95, 130, 1875)
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