-- [[ ♛ SATAYA VIP - CROSS-MAP GOD MODE (TSUNAMI & STEAL) ♛ ]] --
local player = game.Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local run = game:GetService("RunService")

-- [ 1. إنشاء واجهة الأدمن - تظهر بـ 3 أصابع ]
if player.PlayerGui:FindFirstChild("SatayaCrossMap") then player.PlayerGui.SatayaCrossMap:Destroy() end
local sg = Instance.new("ScreenGui", player.PlayerGui); sg.Name = "SatayaCrossMap"
sg.ResetOnSpawn = false

local Main = Instance.new("Frame", sg)
Main.Size = UDim2.new(0, 250, 0, 340); Main.Position = UDim2.new(0.5, -125, 0.4, -170)
Main.BackgroundColor3 = Color3.fromRGB(15, 0, 30); Main.BorderColor3 = Color3.fromRGB(255, 0, 255)
Main.Visible = true; Main.Active = true; Main.Draggable = true

-- إخفاء وإظهار بـ 3 أصابع (للجوال)
UIS.TouchStarted:Connect(function(_, p) if not p and #UIS:GetTouches() >= 3 then Main.Visible = not Main.Visible end end)

local Title = Instance.new("TextLabel", Main)
Title.Text = "♛ SATAYA CROSS-MAP ♛"; Title.Size = UDim2.new(1, 0, 0, 45)
Title.BackgroundColor3 = Color3.fromRGB(50, 0, 100); Title.TextColor3 = Color3.fromRGB(255, 255, 255)

local function CreateBtn(name, pos, callback)
    local state = false
    local b = Instance.new("TextButton", Main)
    b.Text = name .. ": OFF"; b.Size = UDim2.new(0.9, 0, 0, 45); b.Position = UDim2.new(0.05, 0, 0, pos)
    b.BackgroundColor3 = Color3.fromRGB(30, 30, 30); b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.MouseButton1Click:Connect(function()
        state = not state
        b.Text = state and (name .. ": ON") or (name .. ": OFF")
        b.BackgroundColor3 = state and Color3.fromRGB(130, 0, 200) or Color3.fromRGB(30, 30, 30)
        callback(state)
    end)
end

-- [ 2. ميزات الخلود والعبور ]

-- أ. خلود التسونامي والسرقة (God Mode)
CreateBtn("تفعيل الخلود الشامل", 60, function(on)
    _G.GodActive = on
    task.spawn(function()
        while _G.GodActive do
            if player.Character and player.Character:FindFirstChild("Humanoid") then
                -- 1. تثبيت الدم (Infinite Health)
                player.Character.Humanoid.Health = 100
                -- 2. إبطال مفعول الماء والليزرات (CanTouch = false)
                for _, v in pairs(player.Character:GetDescendants()) do
                    if v:IsA("BasePart") then v.CanTouch = false end
                end
            end
            task.wait(0.1)
        end
        if player.Character then
            for _, v in pairs(player.Character:GetDescendants()) do
                if v:IsA("BasePart") then v.CanTouch = true end
            end
        end
    end)
end)

-- ب. اختراق الحواجز (Noclip) - للدخول للبوابة بسهولة
CreateBtn("اختراق الحواجز والبيوت", 115, function(on)
    _G.Noclip = on
    run.Stepped:Connect(function()
        if _G.Noclip and player.Character then
            for _, v in pairs(player.Character:GetDescendants()) do
                if v:IsA("BasePart") then v.CanCollide = false end
            end
        end
    end)
end)

-- ج. سحب السرقة من السيرفرين (Auto Loot)
CreateBtn("سحب السرقة والنوادر", 170, function(on)
    _G.AutoLoot = on
    task.spawn(function()
        while _G.AutoLoot do
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("BasePart") and (v.Name:lower():find("steal") or v.Name:lower():find("money") or v.Name:lower():find("item")) then
                    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                        player.Character.HumanoidRootPart.CFrame = v.CFrame
                        task.wait(0.2)
                    end
                end
            end
            task.wait(0.5)
        end
    end)
end)

-- د. منصة النجاة (تتحرك معك)
CreateBtn("منصة النجاة من الغرق", 225, function(on)
    _G.Floor = on
    local p = workspace:FindFirstChild("SatayaSafeFloor") or Instance.new("Part", workspace)
    p.Name = "SatayaSafeFloor"; p.Size = Vector3.new(15, 1, 15); p.Anchored = true; p.Transparency = 1
    run.Heartbeat:Connect(function()
        if _G.Floor and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            p.CFrame = player.Character.HumanoidRootPart.CFrame * CFrame.new(0, -3.2, 0)
        else
            p.CFrame = CFrame.new(0, -1000, 0)
        end
    end)
end)

-- هـ. السرعة الخارقة
CreateBtn("سرعة الهاكر VIP", 280, function(on)
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.WalkSpeed = on and 125 or 16
    end
end)
