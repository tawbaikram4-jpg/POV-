-- [[ ♛ SATAYA VIP - HOUSE BREAKER (BRAINROT) ♛ ]] --
local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local root = char:WaitForChild("HumanoidRootPart")
local run = game:GetService("RunService")
local UIS = game:GetService("UserInputService")

-- [ 1. إنشاء الواجهة - تظهر بلمس الشاشة بـ 3 أصابع ]
if player.PlayerGui:FindFirstChild("HouseBreaker") then player.PlayerGui.HouseBreaker:Destroy() end
local sg = Instance.new("ScreenGui", player.PlayerGui)
sg.Name = "HouseBreaker"
sg.ResetOnSpawn = false

local Main = Instance.new("Frame", sg)
Main.Size = UDim2.new(0, 240, 0, 300); Main.Position = UDim2.new(0.5, -120, 0.4, -150)
Main.BackgroundColor3 = Color3.fromRGB(0, 0, 0); Main.BorderSizePixel = 2
Main.BorderColor3 = Color3.fromRGB(0, 255, 255); Main.Visible = true; Main.Draggable = true; Main.Active = true

-- إخفاء وإظهار بـ 3 أصابع (للجوال)
UIS.TouchStarted:Connect(function(_, processed)
    if not processed and #UIS:GetTouches() >= 3 then Main.Visible = not Main.Visible end
end)

local Title = Instance.new("TextLabel", Main)
Title.Text = "♛ SATAYA اختراق البيوت ♛"; Title.Size = UDim2.new(1, 0, 0, 45)
Title.BackgroundColor3 = Color3.fromRGB(0, 50, 100); Title.TextColor3 = Color3.fromRGB(255, 255, 255)

local function CreateBtn(name, pos, callback)
    local state = false
    local btn = Instance.new("TextButton", Main)
    btn.Text = name .. ": OFF"; btn.Size = UDim2.new(0.9, 0, 0, 45); btn.Position = UDim2.new(0.05, 0, 0, pos)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40); btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.MouseButton1Click:Connect(function()
        state = not state
        btn.Text = state and (name .. ": ON") or (name .. ": OFF")
        btn.BackgroundColor3 = state and Color3.fromRGB(0, 150, 200) or Color3.fromRGB(40, 40, 40)
        callback(state)
    end)
end

-- [ 2. ميزات الاختراق SATAYA ]

-- أ. اختراق البيت والجدران (Noclip)
CreateBtn("اختراق الجدران (House Bypass)", 60, function(on)
    _G.HouseNoclip = on
    run.Stepped:Connect(function()
        if _G.HouseNoclip and player.Character then
            for _, v in pairs(player.Character:GetDescendants()) do
                if v:IsA("BasePart") then v.CanCollide = false end
            end
            -- تعطيل تصادم جدران البيوت والـ VIP في الماب
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("BasePart") and (v.Name:lower():find("house") or v.Name:lower():find("vip") or v.Name:lower():find("wall")) then
                    v.CanCollide = false
                end
            end
        end
    end)
end)

-- ب. تجميع السرقة والمال داخل البيت
CreateBtn("تجميع سرقة البيت فوري", 115, function(on)
    _G.AutoLoot = on
    task.spawn(function()
        while _G.AutoLoot do
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("BasePart") and (v.Name:lower():find("steal") or v.Name:lower():find("money") or v.Name:lower():find("gold")) then
                    root.CFrame = v.CFrame; task.wait(0.3)
                end
            end
            task.wait(0.5)
        end
    end)
end)

-- ج. سرعة البرق (بدون طرد)
CreateBtn("سرعة الاختراق VIP", 170, function(on)
    player.Character.Humanoid.WalkSpeed = on and 110 or 16
end)

-- د. وضع الخلود (عدم الموت)
CreateBtn("الخلود VIP", 225, function(on)
    _G.God = on
    local p = workspace:FindFirstChild("SatayaFloor") or Instance.new("Part", workspace)
    p.Name = "SatayaFloor"; p.Size = Vector3.new(15, 1, 15); p.Anchored = true; p.Transparency = 1
    run.Heartbeat:Connect(function()
        if _G.God then p.CFrame = root.CFrame * CFrame.new(0, -3.2, 0) else p.CFrame = CFrame.new(0,-500,0) end
    end)
end)
