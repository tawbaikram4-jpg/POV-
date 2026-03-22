-- [[ ♛ SATAYA VIP - TRIPLE TOUCH SENSE ♛ ]] --
local player = game.Players.LocalPlayer
local root = player.Character:WaitForChild("HumanoidRootPart")
local run = game:GetService("RunService")
local UIS = game:GetService("UserInputService")

-- [ 1. إنشاء الواجهة المضمونة ]
if player.PlayerGui:FindFirstChild("SatayaTouchPanel") then player.PlayerGui.SatayaTouchPanel:Destroy() end
local sg = Instance.new("ScreenGui", player.PlayerGui)
sg.Name = "SatayaTouchPanel"
sg.ResetOnSpawn = false

-- [ 2. اللوحة الرئيسية ]
local Main = Instance.new("Frame", sg)
Main.Size = UDim2.new(0, 240, 0, 350)
Main.Position = UDim2.new(0.5, -120, 0.5, -175)
Main.BackgroundColor3 = Color3.fromRGB(15, 0, 0)
Main.BorderSizePixel = 3
Main.BorderColor3 = Color3.fromRGB(255, 0, 0)
Main.Visible = true -- تبدأ ظاهرة
Main.Active = true; Main.Draggable = true

-- [ 3. ميزة "اللمس بثلاث أصابع" للإخفاء والإظهار ]
UIS.TouchStarted:Connect(function(touch, processed)
    if not processed then
        local activeTouches = UIS:GetTouches()
        if #activeTouches >= 3 then -- إذا لمست الشاشة بـ 3 أصابع
            Main.Visible = not Main.Visible
        end
    end
end)

local Title = Instance.new("TextLabel", Main)
Title.Text = "♛ لوحة SATAYA (المس بـ3 أصابع) ♛"
Title.Size = UDim2.new(1, 0, 0, 45); Title.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
Title.TextColor3 = Color3.fromRGB(255, 255, 255); Title.TextScaled = true

-- وظيفة الأزرار
local function CreateButton(text, pos, callback)
    local state = false
    local btn = Instance.new("TextButton", Main)
    btn.Text = text .. ": OFF"; btn.Size = UDim2.new(0.9, 0, 0, 45); btn.Position = UDim2.new(0.05, 0, 0, pos)
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50); btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.SourceSansBold
    btn.MouseButton1Click:Connect(function()
        state = not state
        btn.Text = state and (text .. ": ON") or (text .. ": OFF")
        btn.BackgroundColor3 = state and Color3.fromRGB(0, 180, 0) or Color3.fromRGB(50, 50, 50)
        callback(state)
    end)
end

-- [ الميزات الملكية ]

-- 1. اختراق مناطق الـ VIP (تسونامي)
CreateButton("دخول VIP مجاناً", 60, function(on)
    _G.VipBypass = on
    run.Stepped:Connect(function()
        if _G.VipBypass then
            for _, v in pairs(workspace:GetDescendants()) do
                if v.Name:lower():find("vip") and v:IsA("BasePart") then
                    v.CanCollide = false
                end
            end
        end
    end)
end)

-- 2. صيد السماوي (Cyan)
CreateButton("صيد السماوي (Cyan)", 115, function(on)
    _G.CyanH = on
    task.spawn(function()
        while _G.CyanH do
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("BasePart") and v.Name:lower():find("cyan") then
                    root.CFrame = v.CFrame; task.wait(0.2)
                end
            end
            task.wait(0.5)
        end
    end)
end)

-- 3. السرعة والخلود VIP
CreateButton("سرعة + عدم موت VIP", 170, function(on)
    _G.God = on
    player.Character.Humanoid.WalkSpeed = on and 120 or 16
    local p = workspace:FindFirstChild("SatayaSafe") or Instance.new("Part", workspace)
    p.Name = "SatayaSafe"; p.Size = Vector3.new(20, 1, 20); p.Anchored = true; p.Transparency = 1
    run.Heartbeat:Connect(function()
        if _G.God then p.CFrame = root.CFrame * CFrame.new(0, -3.2, 0) else p.CFrame = CFrame.new(0,-500,0) end
    end)
end)

-- 4. كشف الكوكيز
CreateButton("كشف الكوكيز", 225, function(on)
    for _, v in pairs(workspace:GetDescendants()) do
        if v.Name:lower():find("cookie") and v:IsA("BasePart") then
            if on then
                local h = Instance.new("Highlight", v); h.Name = "SAT"; h.FillColor = Color3.fromRGB(255, 255, 0)
            else
                if v:FindFirstChild("SAT") then v.SAT:Destroy() end
            end
        end
    end
end)
