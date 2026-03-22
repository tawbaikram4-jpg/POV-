-- [[ ♛ SATAYA VIP - NEW PASSWORD SYSTEM ♛ ]] --
local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local root = char:WaitForChild("HumanoidRootPart")
local hum = char:WaitForChild("Humanoid")
local UIS = game:GetService("UserInputService")
local run = game:GetService("RunService")

-- [ 1. الباسورد الجديد سهل جداً ]
local CorrectPass = "في لفيديو" 

if player.PlayerGui:FindFirstChild("SatayaFix") then player.PlayerGui.SatayaFix:Destroy() end
local sg = Instance.new("ScreenGui", player.PlayerGui); sg.Name = "SatayaFix"

local Login = Instance.new("Frame", sg)
Login.Size = UDim2.new(0, 260, 0, 140); Login.Position = UDim2.new(0.5, -130, 0.4, -70)
Login.BackgroundColor3 = Color3.fromRGB(30, 0, 0); Login.BorderSizePixel = 3; Login.BorderColor3 = Color3.fromRGB(255, 255, 255)

local Inp = Instance.new("TextBox", Login)
Inp.PlaceholderText = "اكتب 1122 هنا..."; Inp.Size = UDim2.new(0.8, 0, 0, 40); Inp.Position = UDim2.new(0.1, 0, 0.3, 0)
Inp.BackgroundColor3 = Color3.fromRGB(0,0,0); Inp.TextColor3 = Color3.fromRGB(255,255,255)

local btn = Instance.new("TextButton", Login)
btn.Text = "دخول (Login)"; btn.Size = UDim2.new(0.8, 0, 0, 35); btn.Position = UDim2.new(0.1, 0, 0.7, 0)
btn.BackgroundColor3 = Color3.fromRGB(0, 150, 0); btn.TextColor3 = Color3.fromRGB(255, 255, 255)

-- [ 2. لوحة الأدمن (تظهر بلمس 3 أصابع) ]
local Main = Instance.new("Frame", sg); Main.Visible = false
Main.Size = UDim2.new(0, 240, 0, 320); Main.Position = UDim2.new(0.5, -120, 0.4, -160)
Main.BackgroundColor3 = Color3.fromRGB(0, 0, 0); Main.BorderColor3 = Color3.fromRGB(255, 0, 0); Main.Draggable = true; Main.Active = true

-- الإخفاء والإظهار بـ 3 أصابع (للجوال)
UIS.TouchStarted:Connect(function(_, p) if not p and #UIS:GetTouches() >= 3 then Main.Visible = not Main.Visible end end)

local function AddCmd(name, pos, func)
    local b = Instance.new("TextButton", Main)
    b.Text = name; b.Size = UDim2.new(0.9, 0, 0, 45); b.Position = UDim2.new(0.05, 0, 0, pos)
    b.BackgroundColor3 = Color3.fromRGB(40, 40, 40); b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.MouseButton1Click:Connect(func)
end

-- [ أوامر التخريب والاختراق ]
AddCmd("اختراق البيت (بدون رجوع)", 55, function()
    run.Stepped:Connect(function() 
        if char then for _, v in pairs(char:GetDescendants()) do if v:IsA("BasePart") then v.CanCollide = false end end end
    end)
end)

AddCmd("سحب كل سرقة الماب", 110, function()
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") and (v.Name:lower():find("money") or v.Name:lower():find("steal")) then
            root.CFrame = v.CFrame * CFrame.new(0, 2, 0); task.wait(0.2)
        end
    end
end)

AddCmd("سرقة VIP + قفز", 165, function()
    hum.WalkSpeed = 120; hum.JumpPower = 100
end)

AddCmd("منصة الأدمن العائمة", 220, function()
    local p = Instance.new("Part", workspace); p.Size = Vector3.new(15, 1, 15); p.Anchored = true; p.CFrame = root.CFrame * CFrame.new(0, -3.5, 0)
end)

-- تفعيل الدخول
btn.MouseButton1Click:Connect(function()
    if Inp.Text == CorrectPass then 
        Login.Visible = false; Main.Visible = true 
    else 
        Inp.Text = ""; Inp.PlaceholderText = "خطأ! الباسورد هو 1122" 
    end
end)
