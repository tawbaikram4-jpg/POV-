-- [[ ♛ SATAYA VIP - FULL VISIBLE TAB MENU ♛ ]] --
local player = game.Players.LocalPlayer
local pgui = player:WaitForChild("PlayerGui")

-- حذف أي نسخة قديمة لضمان عدم التداخل
if pgui:FindFirstChild("SatayaUltraV3") then pgui.SatayaUltraV3:Destroy() end

local sg = Instance.new("ScreenGui", pgui)
sg.Name = "SatayaUltraV3"
sg.ResetOnSpawn = false

-- [ 1. الهيكل الرئيسي ]
local Main = Instance.new("Frame", sg)
Main.Size = UDim2.new(0, 400, 0, 300)
Main.Position = UDim2.new(0.5, -200, 0.4, -150)
Main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Main.BorderSizePixel = 2
Main.Active = true
Main.Draggable = true

-- [ 2. القائمة اليسرى (التبويبات) ]
local Sidebar = Instance.new("Frame", Main)
Sidebar.Size = UDim2.new(0, 100, 1, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(40, 0, 0)

-- [ 3. منطقة عرض الميزات ]
local Content = Instance.new("Frame", Main)
Content.Position = UDim2.new(0, 110, 0, 10)
Content.Size = UDim2.new(1, -120, 1, -20)
Content.BackgroundTransparency = 1

local list = Instance.new("UIListLayout", Content)
list.Padding = UDim.new(0, 10)

-- دالة لتنظيف المحتوى
local function Clear()
    for _, v in pairs(Content:GetChildren()) do
        if v:IsA("TextButton") then v:Destroy() end
    end
end

-- دالة إضافة أزرار ON/OFF
local function AddToggle(name, func_on, func_off)
    local btn = Instance.new("TextButton", Content)
    btn.Size = UDim2.new(1, 0, 0, 45)
    btn.Text = name .. " [OFF]"
    btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.TextScaled = true
    
    local active = false
    btn.MouseButton1Click:Connect(function()
        active = not active
        btn.Text = active and name .. " [ON]" or name .. " [OFF]"
        btn.BackgroundColor3 = active and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(60, 60, 60)
        if active then task.spawn(func_on) else func_off() end
    end)
end

-- [ 4. محتوى الأقسام ]

-- قسم النار والموارد
local function OpenFire()
    Clear()
    AddToggle("مطر الخشب للنار 🔥", function()
        _G.AutoFire = true
        while _G.AutoFire do
            local fire = game.Workspace:FindFirstChild("Fire", true) or game.Workspace:FindFirstChild("Campfire", true)
            if fire then
                for _, v in pairs(game.Workspace:GetChildren()) do
                    if v:IsA("BasePart") and not v.Anchored then v.CFrame = fire.CFrame + Vector3.new(0,10,0) end
                end
            end
            task.wait(1)
        end
    end, function() _G.AutoFire = false end)
    
    AddToggle("جلب وترتيب البيض 🥚", function()
        _G.AutoEgg = true
        while _G.AutoEgg do
            local count = 0
            for _, v in pairs(game.Workspace:GetDescendants()) do
                if v.Name:lower():find("egg") and v:IsA("BasePart") then
                    v.CFrame = player.Character.HumanoidRootPart.CFrame * CFrame.new((count%4)*4, -2, -6)
                    count = count + 1
                end
            end
            task.wait(1.5)
        end
    end, function() _G.AutoEgg = false end)
end

-- قسم كشف الأماكن (ESP)
local function OpenESP()
    Clear()
    AddToggle("كشف الأنبوب (حيوانات) 🐾", function()
        _G.EspOn = true
        while _G.EspOn do
            -- كود الكشف البسيط هنا
            task.wait(2)
        end
    end, function() _G.EspOn = false end)
end

-- [ 5. أزرار التبديل الجانبية ]
local function SideBtn(text, pos, func)
    local b = Instance.new("TextButton", Sidebar)
    b.Size = UDim2.new(0.9, 0, 0, 40)
    b.Position = UDim2.new(0.05, 0, 0, pos)
    b.Text = text
    b.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
    b.TextColor3 = Color3.new(1, 1, 1)
    b.MouseButton1Click:Connect(func)
end

SideBtn("النار 🔥", 10, OpenFire)
SideBtn("الكشف 👀", 60, OpenESP)
SideBtn("السرعة ⚡", 110, function() 
    Clear()
    AddToggle("سرعة الملك (150)", function() player.Character.Humanoid.WalkSpeed = 150 end, function() player.Character.Humanoid.WalkSpeed = 16 end)
end)

-- زر الإغلاق والفتح (X و ♛)
local Close = Instance.new("TextButton", Main)
Close.Text = "X"; Close.Size = UDim2.new(0, 35, 0, 35); Close.Position = UDim2.new(1, -35, 0, 0)
Close.BackgroundColor3 = Color3.new(1, 0, 0)

local Open = Instance.new("TextButton", sg)
Open.Text = "♛"; Open.Size = UDim2.new(0, 50, 0, 50); Open.Position = UDim2.new(0, 10, 0.5, 0)
Open.BackgroundColor3 = Color3.new(0.5, 0, 0); Open.Visible = false

Close.MouseButton1Click:Connect(function() Main.Visible = false; Open.Visible = true end)
Open.MouseButton1Click:Connect(function() Main.Visible = true; Open.Visible = false end)

-- فتح أول قسم تلقائياً
OpenFire()
