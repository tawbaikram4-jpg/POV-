-- [[ ♛ SATAYA VIP - FIXED VERSION ♛ ]] --
local player = game.Players.LocalPlayer
local pgui = player:WaitForChild("PlayerGui")

-- حذف أي نسخة قديمة لضمان عدم التداخل
if pgui:FindFirstChild("SatayaFixed") then pgui.SatayaFixed:Destroy() end

local sg = Instance.new("ScreenGui", pgui)
sg.Name = "SatayaFixed"
sg.ResetOnSpawn = false

-- [ 1. الزر الصغير (الذي يفتح القائمة) ]
local OpenBtn = Instance.new("TextButton", sg)
OpenBtn.Size = UDim2.new(0, 100, 0, 40)
OpenBtn.Position = UDim2.new(0, 10, 0.5, 0)
OpenBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
OpenBtn.Text = "OPEN SATAYA"
OpenBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
OpenBtn.Visible = false -- مخفي لأن القائمة ستفتح أولاً
OpenBtn.ZIndex = 10

-- [ 2. إطار القائمة الرئيسية ]
local Main = Instance.new("Frame", sg)
Main.Size = UDim2.new(0, 250, 0, 250)
Main.Position = UDim2.new(0.5, -125, 0.4, -125)
Main.BackgroundColor3 = Color3.fromRGB(30, 0, 0)
Main.BorderSizePixel = 3
Main.Active = true
Main.Draggable = true -- يمكنك تحريك القائمة بيدك

-- عنوان القائمة
local Title = Instance.new("TextLabel", Main)
Title.Text = "♛ SATAYA MENU ♛"
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
Title.TextColor3 = Color3.new(1,1,1)

-- [ 3. زر الإغلاق داخل القائمة ]
local CloseBtn = Instance.new("TextButton", Main)
CloseBtn.Text = "X"
CloseBtn.Size = UDim2.new(0, 40, 0, 40)
CloseBtn.Position = UDim2.new(1, -40, 0, 0)
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
CloseBtn.TextColor3 = Color3.new(1,1,1)

-- برمجة الفتح والإغلاق
CloseBtn.MouseButton1Click:Connect(function()
    Main.Visible = false
    OpenBtn.Visible = true
end)

OpenBtn.MouseButton1Click:Connect(function()
    Main.Visible = true
    OpenBtn.Visible = false
end)

-- [ 4. أزرار الميزات (جلب الأغراض والسرعة) ]
local function AddButton(name, pos, func)
    local btn = Instance.new("TextButton", Main)
    btn.Text = name
    btn.Size = UDim2.new(0.9, 0, 0, 45)
    btn.Position = UDim2.new(0.05, 0, 0, pos)
    btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.MouseButton1Click:Connect(func)
end

AddButton("جلب البيض والأغراض 🔥", 60, function()
    -- كود جلب الأغراض
    for _, item in pairs(game.Workspace:GetDescendants()) do
        if (item.Name:lower():find("egg") or item.Name:lower():find("item")) and item:IsA("BasePart") then
            item.CFrame = player.Character.HumanoidRootPart.CFrame
        end
    end
end)

AddButton("تطوير النار ⚡", 120, function()
    -- كود التطوير
    local rem = game.ReplicatedStorage:FindFirstChild("UpgradeRemote")
    if rem then rem:FireServer("Upgrade", "Fire") end
end)

AddButton("سرعة الملك ♛", 180, function()
    player.Character.Humanoid.WalkSpeed = 100
end)
