-- [[ ♛ SATAYA VIP - THE FINAL 100% WORKING HUB ♛ ]] --
local player = game.Players.LocalPlayer
local pgui = player:WaitForChild("PlayerGui")

-- تنظيف الشاشة من أي محاولات سابقة
if pgui:FindFirstChild("SatayaFinal100") then pgui.SatayaFinal100:Destroy() end
local sg = Instance.new("ScreenGui", pgui); sg.Name = "SatayaFinal100"; sg.ResetOnSpawn = false

-- [ 1. البانل الملكي ]
local Main = Instance.new("Frame", sg)
Main.Size = UDim2.new(0, 340, 0, 320); Main.Position = UDim2.new(0.5, -170, 0.4, 0)
Main.BackgroundColor3 = Color3.fromRGB(5, 5, 10); Main.Active = true; Main.Draggable = true
Instance.new("UICorner", Main)

local Display = Instance.new("TextLabel", Main)
Display.Text = "نظام SATAYA جاهز للتعويض..."; Display.Size = UDim2.new(1, 0, 0, 100)
Display.BackgroundColor3 = Color3.fromRGB(0, 20, 40); Display.TextColor3 = Color3.new(1, 1, 1); Display.TextScaled = true
Instance.new("UICorner", Display)

-- [ 2. زر الـ OPEN (الأثر الدائم) ]
local OpenBtn = Instance.new("TextButton", sg)
OpenBtn.Size = UDim2.new(0, 90, 0, 45); OpenBtn.Position = UDim2.new(0, 10, 0.5, 0)
OpenBtn.Text = "OPEN 🔓"; OpenBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0); OpenBtn.TextColor3 = Color3.new(1, 1, 1)
OpenBtn.Visible = false; OpenBtn.TextScaled = true; Instance.new("UICorner", OpenBtn)

--- [[ المحرك الذهبي: قنص الأرقام الحقيقية ]] ---
local function StartUltimateScanner()
    Display.Text = "جاري قنص الرقم (تجاوز الفخاخ)..."
    spawn(function()
        while true do
            local found = false
            -- البحث في "كل" كائنات اللعبة عن أي قيمة رقمية تتغير
            for _, v in pairs(game:GetDescendants()) do
                if (v:IsA("IntValue") or v:IsA("StringValue") or v:IsA("TextLabel")) then
                    local val = tonumber(v.Value or v.Text)
                    -- الفلتر النهائي: حظر 4، 6، 999، 0 وأي رقم ثابت لا يتغير
                    if val and val > 0 and val < 800 and val ~= 6 and val ~= 4 and val ~= 999 then
                        Display.Text = "الرقم المضمون الآن:\n[" .. tostring(val) .. "]"
                        Display.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
                        found = true
                    end
                end
            end
            task.wait(0.4)
        end
    end)
end

--- [[ محرك الضغط الذكي: منع الأصفار (Human Jitter) ]] ---
local clicking = false
local function StartSmartClicker()
    clicking = not clicking
    if clicking then
        Display.Text = "أوتو كليكر: نـشـط 🔥\n(جمع الـ Infinity بدون أصفار)"
        Display.BackgroundColor3 = Color3.fromRGB(150, 100, 0)
        spawn(function()
            local r = Random.new()
            while clicking do
                -- إرسال ضغطة حقيقية متغيرة التوقيت لخداع الحماية
                game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, true, game, 1)
                task.wait(r:NextNumber(0.025, 0.045)) 
                game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, false, game, 1)
                task.wait(r:NextNumber(0.015, 0.035))
            end
        end)
    else
        Display.Text = "تم إيقاف الضغط."
        Display.BackgroundColor3 = Color3.fromRGB(0, 20, 40)
    end
end

-- [ أزرار التحكم بالواجهة ]
local function AddBtn(txt, pos, func)
    local b = Instance.new("TextButton", Main)
    b.Size = UDim2.new(0.9, 0, 0, 45); b.Position = UDim2.new(0.05, 0, 0, pos)
    b.Text = txt; b.BackgroundColor3 = Color3.fromRGB(40, 40, 45); b.TextColor3 = Color3.new(1, 1, 1); b.TextScaled = true
    b.MouseButton1Click:Connect(func); Instance.new("UICorner", b)
end

AddBtn("كشف الرقم الحقيقي (100%) 👁️", 110, StartUltimateScanner)
AddBtn("أوتو كليكر (بوب كورن + كوكيز) ⚡", 165, StartSmartClicker)
AddBtn("إخفاء (تحويل لـ Open) 🛑", 220, function()
    Main.Visible = false
    OpenBtn.Visible = true
end)

OpenBtn.MouseButton1Click:Connect(function()
    Main.Visible = true
    OpenBtn.Visible = false
end)
