-- [[ ♛ SATAYA VIP 4X - PRO TOGGLE SYSTEM ♛ ]] --
local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local pgui = player:WaitForChild("PlayerGui")

-- تنظيف النسخ القديمة
if pgui:FindFirstChild("SatayaPro") then pgui.SatayaPro:Destroy() end

local sg = Instance.new("ScreenGui", pgui); sg.Name = "SatayaPro"; sg.ResetOnSpawn = false

-- [ 1. الزر العائم الصغير (لإعادة فتح القائمة) ]
local OpenBtn = Instance.new("TextButton", sg)
OpenBtn.Size = UDim2.new(0, 60, 0, 60); OpenBtn.Position = UDim2.new(0, 10, 0.4, 0)
OpenBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0); OpenBtn.Text = "♛"; OpenBtn.TextScaled = true
OpenBtn.TextColor3 = Color3.new(1,1,1); OpenBtn.Visible = false
local corner = Instance.new("UICorner", OpenBtn); corner.CornerRadius = UDim.new(1, 0)

-- [ 2. القائمة الرئيسية ]
local Main = Instance.new("Frame", sg)
Main.Size = UDim2.new(0, 300, 0, 400); Main.Position = UDim2.new(0.5, -150, 0.2, 0)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 15); Main.Active = true; Main.Draggable = true

local Title = Instance.new("TextLabel", Main)
Title.Text = "♛ SATAYA 4X PRO ♛"; Title.Size = UDim2.new(1, -40, 0, 50)
Title.BackgroundColor3 = Color3.fromRGB(120, 0, 0); Title.TextColor3 = Color3.new(1,1,1); Title.TextScaled = true

local Close = Instance.new("TextButton", Main)
Close.Text = "X"; Close.Size = UDim2.new(0, 40, 0, 50); Close.Position = UDim2.new(1, -40, 0, 0)
Close.BackgroundColor3 = Color3.new(0.8, 0, 0); Close.TextColor3 = Color3.new(1,1,1)

local Scroll = Instance.new("ScrollingFrame", Main)
Scroll.Size = UDim2.new(1, 0, 1, -50); Scroll.Position = UDim2.new(0, 0, 0, 50)
Scroll.CanvasSize = UDim2.new(0, 0, 2, 0); Scroll.ScrollBarThickness = 5; Scroll.BackgroundColor3 = Color3.fromRGB(25, 25, 25)

-- برمجة الفتح والإغلاق
Close.MouseButton1Click:Connect(function() Main.Visible = false; OpenBtn.Visible = true end)
OpenBtn.MouseButton1Click:Connect(function() Main.Visible = true; OpenBtn.Visible = false end)

-- [ 3. دالة إنشاء أزرار ON/OFF ]
local function CreateToggle(name, pos, func)
    local btn = Instance.new("TextButton", Scroll)
    btn.Size = UDim2.new(0.9, 0, 0, 45); btn.Position = UDim2.new(0.05, 0, 0, pos)
    btn.BackgroundColor3 = Color3.fromRGB(150, 0, 0) -- البداية أحمر (OFF)
    btn.Text = name .. " [OFF]"; btn.TextColor3 = Color3.new(1,1,1); btn.TextScaled = true
    local cornerBtn = Instance.new("UICorner", btn)

    local active = false
    btn.MouseButton1Click:Connect(function()
        active = not active
        if active then
            btn.BackgroundColor3 = Color3.fromRGB(0, 150, 0) -- أخضر (ON)
            btn.Text = name .. " [ON]"
            -- تشغيل الوظيفة في حلقة تكرار
            task.spawn(function()
                while active do
                    func()
                    task.wait(0.5) -- سرعة التكرار
                end
            end)
        else
            btn.BackgroundColor3 = Color3.fromRGB(150, 0, 0) -- أحمر (OFF)
            btn.Text = name .. " [OFF]"
        end
    end)
end

-- [ 4. إضافة المميزات ]

-- أ. مطر الخشب والوقود فوق النار
CreateToggle("مطر الخشب والوقود 🔥", 10, function()
    for _, v in pairs(game.Workspace:GetDescendants()) do
        if (v.Name:lower():find("wood") or v.Name:lower():find("fuel") or v.Name:lower():find("log")) and v:IsA("BasePart") then
            v.CFrame = game.Workspace.Fire.CFrame + Vector3.new(0, 15, 0)
        end
    end
end)

-- ب. إنقاذ الأطفال فوراً
CreateToggle("جلب الأطفال 👶", 65, function()
    for _, v in pairs(game.Workspace:GetDescendants()) do
        if v.Name:lower():find("kid") or v.Name:lower():find("child") then
            v.CFrame = player.Character.HumanoidRootPart.CFrame
        end
    end
end)

-- ج. جلب الضمادات (التداوي)
CreateToggle("جلب الضمادات 🩹", 120, function()
    for _, v in pairs(game.Workspace:GetDescendants()) do
        if v.Name:lower():find("bandage") or v.Name:lower():find("med") then
            v.CFrame = player.Character.HumanoidRootPart.CFrame
        end
    end
end)

-- د. قطع الأشجار تلقائياً
CreateToggle("قطع الأشجار 🪓", 175, function()
    local rem = game.ReplicatedStorage:FindFirstChild("AxeRemote") or game.ReplicatedStorage:FindFirstChild("CutRemote")
    if rem then rem:FireServer("All") end
end)

-- هـ. السرعة الملكية
CreateToggle("سرعة الملك ⚡", 230, function()
    player.Character.Humanoid.WalkSpeed = 150
end)

-- و. الطيران
CreateToggle("تفعيل الطيران ✈️", 285, function()
    player.Character.HumanoidRootPart.Velocity = Vector3.new(0, 50, 0)
end)

print("♛ نسخة SATAYA PRO بنظام التشغيل والإيقاف جاهزة! ♛")
