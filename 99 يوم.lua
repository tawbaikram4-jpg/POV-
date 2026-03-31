-- [[ ♛ SATAYA VIP - TOGGLE SYSTEM ♛ ]] --
local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()

-- [ 1. إنشاء الواجهة الرئيسية ]
if player.PlayerGui:FindFirstChild("SatayaSystem") then player.PlayerGui.SatayaSystem:Destroy() end
local sg = Instance.new("ScreenGui", player.PlayerGui); sg.Name = "SatayaSystem"; sg.ResetOnSpawn = false

-- [ 2. الزر العائم (الذي يفتح القائمة) ]
local OpenBtn = Instance.new("TextButton", sg)
OpenBtn.Name = "OpenButton"
OpenBtn.Size = UDim2.new(0, 80, 0, 40)
OpenBtn.Position = UDim2.new(0, 10, 0.5, -20) -- يظهر في يسار الشاشة
OpenBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
OpenBtn.Text = "♛ SATAYA"
OpenBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
OpenBtn.TextScaled = true
OpenBtn.BorderSizePixel = 2
OpenBtn.Visible = false -- يكون مخفياً في البداية إذا القائمة مفتوحة

-- جعل الزر العائم دائرياً قليلاً وشكلاً جذاباً
local corner = Instance.new("UICorner", OpenBtn); corner.CornerRadius = ToolBuffer.new(0, 10)

-- [ 3. إطار القائمة الرئيسية ]
local Main = Instance.new("Frame", sg)
Main.Size = UDim2.new(0, 280, 0, 280); Main.Position = UDim2.new(0.5, -140, 0.3, 0)
Main.BackgroundColor3 = Color3.fromRGB(20, 0, 0); Main.BorderSizePixel = 2; Main.Draggable = true
Main.Active = true

-- زر الإغلاق (X) داخل القائمة
local CloseBtn = Instance.new("TextButton", Main)
CloseBtn.Text = "X"; CloseBtn.Size = UDim2.new(0, 35, 0, 35); CloseBtn.Position = UDim2.new(1, -40, 0, 5)
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0); CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextScaled = true

-- [ 4. برمجة الفتح والإغلاق ]
CloseBtn.MouseButton1Click:Connect(function()
    Main.Visible = false
    OpenBtn.Visible = true -- يظهر الزر الصغير عند إغلاق القائمة
end)

OpenBtn.MouseButton1Click:Connect(function()
    Main.Visible = true
    OpenBtn.Visible = false -- يختفي الزر الصغير عند فتح القائمة
end)

-- [ 5. أزرار الميزات (جلب الأغراض وتطوير النار) ]
local function AddToggle(name, pos, callback)
    local btn = Instance.new("TextButton", Main)
    btn.Text = name; btn.Size = UDim2.new(0.9, 0, 0, 45); btn.Position = UDim2.new(0.05, 0, 0, pos)
    btn.BackgroundColor3 = Color3.fromRGB(50, 0, 0); btn.TextColor3 = Color3.fromRGB(255, 255, 255); btn.TextScaled = true
    
    local enabled = false
    btn.MouseButton1Click:Connect(function()
        enabled = not enabled
        btn.BackgroundColor3 = enabled and Color3.fromRGB(0, 180, 0) or Color3.fromRGB(50, 0, 0)
        callback(enabled)
    end)
end

-- أضف ميزاتك هنا كما في السكربت السابق
AddToggle("جلب البيض والأغراض 🔥", 50, function(state)
    _G.AutoGrab = state
    while _G.AutoGrab do
        for _, item in pairs(game:GetService("Workspace"):GetDescendants()) do
            if (item.Name:lower():find("egg") or item.Name:lower():find("item")) and item:IsA("BasePart") then
                item.CFrame = char.HumanoidRootPart.CFrame
            end
        end
        task.wait(0.5)
    end
end)

AddToggle("تطوير النار تلقائياً ⚡", 110, function(state)
    _G.AutoFire = state
    while _G.AutoFire do
        local remote = game:GetService("ReplicatedStorage"):FindFirstChild("UpgradeRemote")
        if remote then remote:FireServer("Upgrade", "Fire") end
        task.wait(2)
    end
end)

AddToggle("سرعة الملك SATAYA ♛", 170, function(state)
    char.Humanoid.WalkSpeed = state and 120 or 16
end)

print("♛ نظام SATAYA VIP الجديد جاهز للسيطرة! ♛")
