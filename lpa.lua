-- [[ ♛ SATAYA VIP - ANTI-FAKE 999 SNIPER ♛ ]] --
local player = game.Players.LocalPlayer
local pgui = player:WaitForChild("PlayerGui")

-- إعداد الواجهة (الشكل الأول مع زر OPEN)
if pgui:FindFirstChild("SatayaAntiFake") then pgui.SatayaAntiFake:Destroy() end
local sg = Instance.new("ScreenGui", pgui); sg.Name = "SatayaAntiFake"; sg.ResetOnSpawn = false

-- [ 1. البانل الرئيسي ]
local Main = Instance.new("Frame", sg)
Main.Size = UDim2.new(0, 320, 0, 240); Main.Position = UDim2.new(0.5, -160, 0.4, 0)
Main.BackgroundColor3 = Color3.fromRGB(15, 0, 0); Main.Active = true; Main.Draggable = true
Instance.new("UICorner", Main)

local Display = Instance.new("TextLabel", Main)
Display.Text = "في انتظار الرقم الحقيقي..."; Display.Size = UDim2.new(1, 0, 0, 100)
Display.BackgroundColor3 = Color3.fromRGB(40, 0, 0); Display.TextColor3 = Color3.new(1, 1, 1); Display.TextScaled = true
Instance.new("UICorner", Display)

-- [ 2. زر الـ OPEN (الأثر الدائم) ]
local OpenBtn = Instance.new("TextButton", sg)
OpenBtn.Size = UDim2.new(0, 85, 0, 45); OpenBtn.Position = UDim2.new(0, 5, 0.5, 0)
OpenBtn.Text = "OPEN 🔓"; OpenBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0); OpenBtn.TextColor3 = Color3.new(1, 1, 1)
OpenBtn.Visible = false; OpenBtn.TextScaled = true; Instance.new("UICorner", OpenBtn)

-- [ محرك التصفية: استبعاد 999 وجلب الحقيقة ]
local function StartSmartHack()
    Display.Text = "جاري كسر تمويه 999..."
    spawn(function()
        while true do
            local realNum = "..."
            local targetEnemy = nil

            -- تحديد الخصم المباشر (الأقرب)
            for _, p in pairs(game.Players:GetPlayers()) do
                if p ~= player and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    local dist = (player.Character.HumanoidRootPart.Position - p.Character.HumanoidRootPart.Position).Magnitude
                    if dist < 15 then targetEnemy = p; break end
                end
            end

            if targetEnemy then
                -- البحث عن الرقم في بيانات الخصم
                for _, v in pairs(targetEnemy:GetDescendants()) do
                    local val = nil
                    if v:IsA("TextLabel") and v.Visible then val = tonumber(v.Text)
                    elseif v:IsA("ValueBase") then val = tonumber(v.Value) end

                    -- الشرط الذهبي: استبعاد الرقم 999 والرقم 0
                    if val and val ~= 999 and val ~= 0 and val < 999 then
                        realNum = tostring(val)
                        break
                    end
                end
            end

            -- تحديث الشاشة
            if realNum ~= "..." then
                Display.Text = "تم كشف الرقم الحقيقي:\n[" .. realNum .. "]"
                Display.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
            else
                Display.Text = "الخصم يحاول التمويه بـ 999...\nجاري سحب الرقم الأصلي"
                Display.BackgroundColor3 = Color3.fromRGB(0, 0, 150)
            end
            task.wait(0.2)
        end
    end)
end

-- [ أزرار التحكم ]
local function AddBtn(txt, pos, func)
    local b = Instance.new("TextButton", Main)
    b.Size = UDim2.new(0.9, 0, 0, 50); b.Position = UDim2.new(0.05, 0, 0, pos)
    b.Text = txt; b.BackgroundColor3 = Color3.fromRGB(40, 40, 40); b.TextColor3 = Color3.new(1, 1, 1); b.TextScaled = true
    b.MouseButton1Click:Connect(func); Instance.new("UICorner", b)
end

AddBtn("تفعيل القناص (تجاوز 999) 👁️", 110, StartSmartHack)

AddBtn("إغلاق (تحويل لـ Open) 🛑", 165, function()
    Main.Visible = false
    OpenBtn.Visible = true
end)

OpenBtn.MouseButton1Click:Connect(function()
    Main.Visible = true
    OpenBtn.Visible = false
end)
