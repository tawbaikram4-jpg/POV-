-- [[ ♛ SATAYA VIP - ANTI-BACK NO CLIP (BRAINROT) ♛ ]] --
local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local root = char:WaitForChild("HumanoidRootPart")
local hum = char:WaitForChild("Humanoid")
local run = game:GetService("RunService")
local UIS = game:GetService("UserInputService")

-- [ 1. نظام الدخول ]
if player.PlayerGui:FindFirstChild("AntiBackAdmin") then player.PlayerGui.AntiBackAdmin:Destroy() end
local sg = Instance.new("ScreenGui", player.PlayerGui); sg.Name = "AntiBackAdmin"

local Login = Instance.new("Frame", sg)
Login.Size = UDim2.new(0, 260, 0, 140); Login.Position = UDim2.new(0.5, -130, 0.4, -70)
Login.BackgroundColor3 = Color3.fromRGB(20, 0, 0); Login.BorderColor3 = Color3.fromRGB(255, 255, 0); Login.BorderSizePixel = 2

local Inp = Instance.new("TextBox", Login)
Inp.PlaceholderText = "باسورد SATAYA..."; Inp.Size = UDim2.new(0.8, 0, 0, 40); Inp.Position = UDim2.new(0.1, 0, 0.3, 0)
Inp.BackgroundColor3 = Color3.fromRGB(0,0,0); Inp.TextColor3 = Color3.fromRGB(255,255,255)

local btn = Instance.new("TextButton", Login)
btn.Text = "تفعيل الأدمن"; btn.Size = UDim2.new(0.8, 0, 0, 35); btn.Position = UDim2.new(0.1, 0, 0.7, 0)
btn.BackgroundColor3 = Color3.fromRGB(0, 150, 0); btn.TextColor3 = Color3.fromRGB(255, 255, 255)

-- [ 2. لوحة الأدمن (بدون رجوع للخلف) ]
local Main = Instance.new("Frame", sg); Main.Visible = false
Main.Size = UDim2.new(0, 240, 0, 320); Main.Position = UDim2.new(0.5, -120, 0.4, -160)
Main.BackgroundColor3 = Color3.fromRGB(0, 0, 0); Main.BorderColor3 = Color3.fromRGB(255, 255, 0); Main.Draggable = true; Main.Active = true

UIS.TouchStarted:Connect(function(_, p) if not p and #UIS:GetTouches() >= 3 then Main.Visible = not Main.Visible end end)

local function AddCmd(name, pos, func)
    local b = Instance.new("TextButton", Main)
    b.Text = name; b.Size = UDim2.new(0.9, 0, 0, 45); b.Position = UDim2.new(0.05, 0, 0, pos)
    b.BackgroundColor3 = Color3.fromRGB(40, 40, 40); b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.MouseButton1Click:Connect(func)
end

-- [ الميزات المطورة لحل مشكلة الرجوع ]

-- 1. اختراق الجدران (بدون رجوع للخلف)
AddCmd("اختراق البيت (بدون رجوع)", 55, function()
    _G.AntiBack = true
    run.Stepped:Connect(function()
        if _G.AntiBack and char then
            for _, v in pairs(char:GetDescendants()) do
                if v:IsA("BasePart") then 
                    v.CanCollide = false -- يزيل التصادم
                end
            end
            -- خدعة السيرفر: دفع الشخصية للأمام قليلاً لمنع التعليق داخل الجدار
            root.Velocity = root.CFrame.LookVector * 1.5
        end
    end)
end)

-- 2. سحب الأغراض (نقل ذكي)
AddCmd("سحب كل السرقة (Smart)", 110, function()
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") and (v.Name:lower():find("money") or v.Name:lower():find("steal")) then
            -- الانتقال فوق الغرض قليلاً لتجنب الرجوع
            root.CFrame = v.CFrame * CFrame.new(0, 2, 0) 
            task.wait(0.2)
        end
    end
end)

-- 3. طيران الأدمن (السلس)
AddCmd("طيران سلس (Fly)", 165, function()
    local bg = Instance.new("BodyGyro", root)
    bg.P = 9e4; bg.MaxTorque = Vector3.new(9e9, 9e9, 9e9); bg.CFrame = root.CFrame
    local bv = Instance.new("BodyVelocity", root)
    bv.Velocity = Vector3.new(0, 0, 0); bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
    -- هذا النوع من الطيران لا يكتشفه السيرفر بسهولة
end)

-- 4. منصة الخلود (تحميك من السقوط)
AddCmd("منصة الخلود VIP", 220, function()
    local p = Instance.new("Part", workspace); p.Size = Vector3.new(15, 1, 15); p.Anchored = true; p.Transparency = 1
    run.Heartbeat:Connect(function() p.CFrame = root.CFrame * CFrame.new(0, -3.5, 0) end)
end)

-- تفعيل الدخول
btn.MouseButton1Click:Connect(function()
    if Inp.Text == pass then Login.Visible = false; Main.Visible = true else Inp.Text = "غلط يا بطل!"; task.wait(1); Inp.Text = "" end
end)
