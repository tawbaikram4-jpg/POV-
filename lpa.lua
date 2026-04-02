-- [[ ♛ SATAYA VIP - THE FINAL JUSTICE ♛ ]] --
local player = game.Players.LocalPlayer
local pgui = player:WaitForChild("PlayerGui")

-- تنظيف الشاشة من أي سكربت قديم
if pgui:FindFirstChild("SatayaFinalFull") then pgui.SatayaFinalFull:Destroy() end
local sg = Instance.new("ScreenGui", pgui); sg.Name = "SatayaFinalFull"; sg.ResetOnSpawn = false

-- [ 1. البانل الرئيسي ]
local Main = Instance.new("Frame", sg)
Main.Size = UDim2.new(0, 340, 0, 320); Main.Position = UDim2.new(0.5, -170, 0.4, 0)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 15); Main.Active = true; Main.Draggable = true
Instance.new("UICorner", Main)

local Display = Instance.new("TextLabel", Main)
Display.Text = "المحرك جاهز لخدمتك..."; Display.Size = UDim2.new(1, 0, 0, 90)
Display.BackgroundColor3 = Color3.fromRGB(30, 30, 30); Display.TextColor3 = Color3.new(1, 1, 1); Display.TextScaled = true
Instance.new("UICorner", Display)

-- [ 2. زر الـ OPEN (الأثر الدائم) ]
local OpenBtn = Instance.new("TextButton", sg)
OpenBtn.Size = UDim2.new(0, 90, 0, 45); OpenBtn.Position = UDim2.new(0, 10, 0.5, 0)
OpenBtn.Text = "OPEN 🔓"; OpenBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0); OpenBtn.TextColor3 = Color3.new(1, 1, 1)
OpenBtn.Visible = false; OpenBtn.TextScaled = true; Instance.new("UICorner", OpenBtn)

--- [[ المحركات المدمجة ]] ---

-- أ. محرك كشف الرقم (تجاهل الفخاخ والأرقام القديمة)
local function StartNumberFinder()
    Display.Text = "جاري قنص الرقم الحقيقي الجديد..."
    spawn(function()
        while true do
            local foundVal = nil
            for _, p in pairs(game.Players:GetPlayers()) do
                if p ~= player then
                    for _, v in pairs(p:GetDescendants()) do
                        if v:IsA("ValueBase") or v:IsA("TextLabel") then
                            local val = tonumber(v.Value or v.Text)
                            -- الفلتر الذهبي: يتجاهل 999، 6، 4، 0
                            if val and val > 0 and val < 900 and val ~= 999 and val ~= 6 and val ~= 4 then
                                foundVal = val
                                break
                            end
                        end
                    end
                end
            end
            
            if foundVal then
                Display.Text = "الرقم المكتشف الآن:\n[" .. tostring(foundVal) .. "]"
                Display.BackgroundColor3 = Color3.fromRGB(0, 120, 0)
            end
            task.wait(0.3)
        end
    end)
end

-- ب. محرك البوب كورن الذهبي (بدون أصفار)
local clicking = false
local function TogglePopcorn()
    clicking = not clicking
    if clicking then
        Display.Text = "أوتو كليكر: نـشـط 🔥\n(نقرات حقيقية لتعويض الـ Infinity)"
        Display.BackgroundColor3 = Color3.fromRGB(150, 100, 0)
        spawn(function()
            while clicking do
                game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, true, game, 1)
                task.wait(0.02)
                game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, false, game, 1)
                task.wait(0.02)
            end
        end)
    else
        Display.Text = "تم إيقاف الضغط."
        Display.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    end
end

-- [ أزرار التحكم ]
local function AddBtn(txt, pos, func)
    local b = Instance.new("TextButton", Main)
    b.Size = UDim2.new(0.9, 0, 0, 45); b.Position = UDim2.new(0.05, 0, 0, pos)
    b.Text = txt; b.BackgroundColor3 = Color3.fromRGB(45, 45, 45); b.TextColor3 = Color3.new(1, 1, 1); b.TextScaled = true
    b.MouseButton1Click:Connect(func); Instance.new("UICorner", b)
end

AddBtn("كشف الرقم الحقيقي (تجاهل الفخاخ) 👁️", 100, StartNumberFinder)
AddBtn("أوتو كليكر بوب كورن (نقرات ذهبية) ⚡", 155, TogglePopcorn)
AddBtn("إغلاق (أثر Open) 🛑", 210, function()
    Main.Visible = false
    OpenBtn.Visible = true
end)

OpenBtn.MouseButton1Click:Connect(function()
    Main.Visible = true
    OpenBtn.Visible = false
end)
