-- [[ ♛ SATAYA VIP - LIVE SERVER SNIPER ♛ ]] --
local player = game.Players.LocalPlayer
local pgui = player:WaitForChild("PlayerGui")

-- إعادة ضبط الواجهة فوراً
if pgui:FindFirstChild("SatayaFinalJustice") then pgui.SatayaFinalJustice:Destroy() end
local sg = Instance.new("ScreenGui", pgui); sg.Name = "SatayaFinalJustice"; sg.ResetOnSpawn = false

local Main = Instance.new("Frame", sg)
Main.Size = UDim2.new(0, 320, 0, 240); Main.Position = UDim2.new(0.5, -160, 0.4, 0)
Main.BackgroundColor3 = Color3.fromRGB(20, 0, 0); Main.Active = true; Main.Draggable = true
Instance.new("UICorner", Main)

local Display = Instance.new("TextLabel", Main)
Display.Text = "جاري تدمير الرقم 6 الوهمي..."; Display.Size = UDim2.new(1, 0, 0, 100)
Display.BackgroundColor3 = Color3.fromRGB(60, 0, 0); Display.TextColor3 = Color3.new(1, 1, 1); Display.TextScaled = true

-- [ محرك القنص المباشر من السيرفر ]
local function LiveGrab()
    spawn(function()
        while true do
            local found = false
            for _, p in pairs(game.Players:GetPlayers()) do
                if p ~= player and p.Character then
                    -- فحص "القيم الحية" التي تتغير في هذه اللحظة فقط
                    for _, v in pairs(p:GetDescendants()) do
                        if v:IsA("StringValue") or v:IsA("IntValue") then
                            local val = tonumber(v.Value)
                            -- استبعاد الأرقام الوهمية (6، 0، 999) والتركيز على الرقم الجديد
                            if val and val ~= 6 and val ~= 999 and val ~= 0 and val < 1000 then
                                Display.Text = "الرقم الحقيقي المكتشف:\n[" .. tostring(val) .. "]"
                                Display.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
                                found = true
                                break
                            end
                        end
                    end
                end
            end
            if not found then
                Display.Text = "في انتظار وضع الخصم للرقم الحقيقي..."
                Display.BackgroundColor3 = Color3.fromRGB(40, 0, 0)
            end
            task.wait(0.1)
        end
    end)
end

-- [ الأزرار ]
local function AddBtn(txt, pos, func)
    local b = Instance.new("TextButton", Main)
    b.Size = UDim2.new(0.9, 0, 0, 50); b.Position = UDim2.new(0.05, 0, 0, pos)
    b.Text = txt; b.BackgroundColor3 = Color3.fromRGB(40, 40, 40); b.TextColor3 = Color3.new(1, 1, 1); b.TextScaled = true
    b.MouseButton1Click:Connect(func); Instance.new("UICorner", b)
end

AddBtn("تفعيل القنص المباشر (تجاهل الوهمي) 👁️", 110, LiveGrab)

-- زر الأثر (Open)
local OpenBtn = Instance.new("TextButton", sg)
OpenBtn.Size = UDim2.new(0, 90, 0, 45); OpenBtn.Position = UDim2.new(0, 10, 0.5, 0)
OpenBtn.Text = "OPEN 🔓"; OpenBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 0); OpenBtn.TextColor3 = Color3.new(1, 1, 1)
OpenBtn.Visible = false; OpenBtn.TextScaled = true; Instance.new("UICorner", OpenBtn)

AddBtn("إغلاق (تحويل لـ Open) 🛑", 165, function()
    Main.Visible = false
    OpenBtn.Visible = true
end)

OpenBtn.MouseButton1Click:Connect(function()
    Main.Visible = true
    OpenBtn.Visible = false
end)
