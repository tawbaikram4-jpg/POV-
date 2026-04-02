-- [[ ♛ SATAYA VIP - REAL NUMBER BYPASS ♛ ]] --
local player = game.Players.LocalPlayer
local pgui = player:WaitForChild("PlayerGui")

-- إعداد الواجهة (الشكل الأول مع زر OPEN)
if pgui:FindFirstChild("SatayaBypassTruth") then pgui.SatayaBypassTruth:Destroy() end
local sg = Instance.new("ScreenGui", pgui); sg.Name = "SatayaBypassTruth"; sg.ResetOnSpawn = false

-- [ 1. البانل الرئيسي ]
local Main = Instance.new("Frame", sg)
Main.Size = UDim2.new(0, 320, 0, 240); Main.Position = UDim2.new(0.5, -160, 0.4, 0)
Main.BackgroundColor3 = Color3.fromRGB(10, 0, 10); Main.Active = true; Main.Draggable = true
Instance.new("UICorner", Main)

local Display = Instance.new("TextLabel", Main)
Display.Text = "في انتظار الرقم الحقيقي المعتمد..."; Display.Size = UDim2.new(1, 0, 0, 100)
Display.BackgroundColor3 = Color3.fromRGB(30, 0, 30); Display.TextColor3 = Color3.new(1, 1, 1); Display.TextScaled = true
Instance.new("UICorner", Display)

-- [ 2. زر الـ OPEN (الأثر الدائم) ]
local OpenBtn = Instance.new("TextButton", sg)
OpenBtn.Size = UDim2.new(0, 85, 0, 45); OpenBtn.Position = UDim2.new(0, 5, 0.5, 0)
OpenBtn.Text = "OPEN 🔓"; OpenBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 0); OpenBtn.TextColor3 = Color3.new(1, 1, 1)
OpenBtn.Visible = false; OpenBtn.TextScaled = true; Instance.new("UICorner", OpenBtn)

-- [ المحرك الخارق: كشف الرقم الذي يخبئه السيرفر ]
local function StartTruthFinder()
    Display.Text = "جاري تدمير الأرقام الوهمية..."
    spawn(function()
        while true do
            local found = false
            -- البحث في "RemoteFunctions" و "RemoteEvents" (مكان الحقيقة)
            for _, v in pairs(game:GetDescendants()) do
                if v:IsA("RemoteEvent") and (v.Name:lower():find("guess") or v.Name:lower():find("answer")) then
                    -- مراقبة البيانات التي يرسلها السيرفر فوراً
                    v.OnClientEvent:Connect(function(val)
                        if tonumber(val) then
                            Display.Text = "الرقم الحقيقي المعتمد:\n[" .. tostring(val) .. "]"
                            Display.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
                            found = true
                        end
                    end)
                end
            end
            
            -- فحص بديل في "اللوحة الأم" للعبة
            if not found then
                for _, p in pairs(game.Players:GetPlayers()) do
                    if p ~= player and p.Character then
                        -- البحث عن القيمة التي تتغير "فقط" عند دورك
                        for _, d in pairs(p:GetDescendants()) do
                            if d:IsA("IntValue") and d.Value ~= 0 and d.Value < 1000 then
                                Display.Text = "الرقم المكتشف من السيرفر:\n[" .. tostring(d.Value) .. "]"
                                Display.BackgroundColor3 = Color3.fromRGB(0, 120, 0)
                                found = true
                            end
                        end
                    end
                end
            end
            task.wait(0.1)
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

AddBtn("تفعيل كاشف الحقيقة (Bypass) 👁️", 110, StartTruthFinder)

AddBtn("إغلاق (تحويل لـ Open) 🛑", 165, function()
    Main.Visible = false
    OpenBtn.Visible = true
end)

OpenBtn.MouseButton1Click:Connect(function()
    Main.Visible = true
    OpenBtn.Visible = false
end)
